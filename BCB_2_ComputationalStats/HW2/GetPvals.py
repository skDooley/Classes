from Bio import motifs as Motifs # If this doesn't load: conda install -c bioconda biopython
from Bio.SeqIO import index as fIndex
from IPython.display import display, Image, Audio
from itertools import product as cartProduct
from math import log
from numpy import dot as dotp
from pandas import DataFrame, Series
from scipy.stats import chi2
from timeit import default_timer as timer
from wand.image import Image as WImage #Comment this out if you don't need to display a NEW PDF pip install Wand

class valWrapper:
    def __init__(self,value): self.value=value
    def __getitem__(self, index): return float(self.value[index])
class dfWrapper():
    def __init__(self,df): 
        self.df=df
        self.itemGetter = {type(''):self._getBase,type(1):self._getPos}
    def _getPos(self,key): return self.df[key]
    def _getBase(self,key): return valWrapper(self.df[self.df.index==key])
    def __getitem__(self, key): return self.itemGetter[type(key)](key)
    
tfSites = fIndex("transciptionFactorBindingMotifs.fasta","fasta")

seqs = []
for seq in tfSites.values():seqs.append(str(seq.seq).upper())
    
motif = Motifs.create(seqs)

pfm = DataFrame(motif.counts,index=range(1,10),columns=['A','C','G','T']).transpose()
pfm=pfm.reindex(['A','C','G','T'])
pwm = pfm/pfm.sum()
pwm = dfWrapper(pwm)

Ps = {}
#Initialize the Ps matrix
for pos in range(1,9):
    Ps[pos]={}
    for firstBase,secondBase in cartProduct(['A','C','G','T'],['A','C','G','T']):
        try: Ps[pos][firstBase][secondBase] = 0
        except: Ps[pos][firstBase] = {secondBase:0}

#Count the number of times each base is found together
for seq in seqs:
    for pos in range(0,8): Ps[pos+1][seq[pos]][seq[pos+1]]+=1

#Scale to make a PW transition matrix
transMat = {}
for pos in range(1,9):
    transMat[pos] = {}
    for firstBase,secondBase in cartProduct(['A','C','G','T'],['A','C','G','T']):
        rc_total = Series(Ps[pos][firstBase]).sum()
        if rc_total == 0.0:
            try: transMat[pos][firstBase][secondBase] = 0.0
            except: transMat[pos][firstBase] = {secondBase: 0.0}
        else:
            try: transMat[pos][firstBase][secondBase] = Ps[pos][firstBase][secondBase]/rc_total
            except: transMat[pos][firstBase] = {secondBase: Ps[pos][firstBase][secondBase]/rc_total}
                

seqMapper = {'1000':'A','0100':'C','0010':'G', '0001':'T'}
index = 0
for b1,b2 in cartProduct(['A','C','G','T'],['A','C','G','T']): 
    indetifier = '0' * index + '1' + '0' * (15-index)
    index += 1
    seqMapper[indetifier] = b1+b2
index = 0
for b1,b2,b3 in cartProduct(['A','C','G','T'],['A','C','G','T'],['A','C','G','T']): 
    indetifier = '0' * index + '1' + '0' * (63-index)
    index += 1
    seqMapper[indetifier] = b1+b2+b3
    
index = 0
for b1,b2,b3,b4 in cartProduct(['A','C','G','T'],['A','C','G','T'],['A','C','G','T'],['A','C','G','T']): 
    indetifier = '0' * index + '1' + '0' * (255-index)
    index += 1
    seqMapper[indetifier] = b1+b2+b3+b4
    
index = 0
for b1,b2,b3,b4,b5 in cartProduct(['A','C','G','T'],['A','C','G','T'],['A','C','G','T'],['A','C','G','T'],['A','C','G','T']): 
    indetifier = '0' * index + '1' + '0' * (1023-index)
    index += 1
    seqMapper[indetifier] = b1+b2+b3+b4+b5
    
from scipy.stats import multinomial
rv = multinomial.rvs

class randBase:
    def __init__(self,pVals):
        base = rv(1,pVals)
        self.seq = seqMapper[''.join(str(v) for v in base)]
    def __hash__(self):return hash(self.seq)
    def __str__(self):return self.seq   
    def __add__(self, other): return str(self) + other
    def __radd__(self, other): return other + str(self)

knownTs = set(seqs)

promoters = fIndex("promoters.fasta","fasta")
promoterSeqs = []
alphas = {}
index = 0
for rec in promoters.values():
    for base in ['A','C','G','T']: 
        try:alphas[index][base] = rec.seq.count(base)
        except:alphas[index]= {base:rec.seq.count(base)}
    index+=1
    promoterSeqs.append(str(rec.seq).upper())
alphas = DataFrame(alphas)/len(rec.seq)

Ps_promoters = {}
for firstBase,secondBase in cartProduct(['A','C','G','T'],['A','C','G','T']):
    try: Ps_promoters[firstBase][secondBase] = 0
    except: Ps_promoters[firstBase] = {secondBase:0}

H_promoters = {}
index = 0
for seq in promoterSeqs:
    H_promoters[index]= {}
    Ps_promoters = {}
    for firstBase,secondBase in cartProduct(['A','C','G','T'],['A','C','G','T']):
        try: Ps_promoters[firstBase][secondBase] = 0
        except: Ps_promoters[firstBase] = {secondBase:0}
    for i in range(0,len(seq)-1):
        if seq[i] == 'N': # If both are N or the first base is N, do not count
            continue
        elif seq[i+1] == 'N': #We know the proceeding base so add 1 to all possible basse
            for base in ['A','C','G','T']:
                try:Ps_promoters[seq[i]][base]+=1
                except: 
                    try:Ps_promoters[seq[i]][base]=1
                    except:Ps_promoters[seq[i]] = {base:1}
        else: 
            try:Ps_promoters[seq[i]][seq[i+1]]+=1
            except: 
                try:Ps_promoters[seq[i]][seq[i+1]]=1
                except:Ps_promoters[seq[i]] = {seq[i+1]:1}
    #Position weight the count matrix to get the frequency matrix for the current sequence
    H_promoters[index] = DataFrame(Ps_promoters)
    H_promoters[index] = H_promoters[index]/H_promoters[index].sum()     
    index+=1
index = 0 
tCounts,tSeqs={},{}
for seq in promoterSeqs:
    tCounts[index] = 0
    tSeqs[index] = {'In':0,'Total':0}
    for i in range(0,len(seq)-8):
        subseq = seq[i:i+9]
        if 'N' in subseq:continue
        L_H_q1 = pwm[1][seq[i]]
        L_H_promoters = alphas[index][seq[i]]
        for pos in range(0,8):
            L_H_q1 *= transMat[pos+1][subseq[pos]][subseq[pos+1]]
            L_H_promoters *= H_promoters[index][subseq[pos]][subseq[pos+1]]
        if L_H_q1/L_H_promoters >= 1:
            tSeqs[index]['Total']+=1
            tSeqs[index]['In'] += int(subseq in knownTs)
        tCounts[index] += int(L_H_q1/L_H_promoters >= 1)
    #print (index,tCounts[index])
    index+=1
def GenerateSeq(transMatrix,alpha,length):
    seq = str(randBase(alpha))
    for i in range(length-1):
        seq += randBase(transMatrix[seq[-1]])
    return seq

from numpy import prod
def T_s(seq,pwm,alphas,transMatrix,H_proms):
    tCount = 0
    for i in range(0,len(seq)-8):
        subseq = seq[i:i+9]
        alpha_ho = pwm[1][seq[i]]
        alpha_ha = alphas[seq[i]]
        HoList = [transMatrix[pos+1][subseq[pos]][subseq[pos+1]] for pos in range(0,8)]
        HaList = [H_proms[subseq[pos]][subseq[pos+1]] for pos in range(0,8)]
        HoList.append(alpha_ho)
        HaList.append(alpha_ha)
        L_H_q1 = prod(HoList)
        L_H_promoters = prod(HaList)
        tCount += int(L_H_q1/L_H_promoters >= 1)
    return tCount

fh = open("PvaluesOfMC_Q2.txt","w")
numSims = 100
for index in range(len(H_promoters)):
    tSuccesses = 0
    for sim in range(numSims):
        genSeq = GenerateSeq(H_promoters[index],alphas[index],1000)
        tSuccesses += int(T_s(genSeq,pwm,alphas[index],transMat,H_promoters[index]) >= tCounts[index])
    print(index,tSuccesses/float(numSims))
    fh.write("Sequence %i *.2f" % (index,tSuccesses/float(numSims)))
fh.close()