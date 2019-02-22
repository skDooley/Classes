from collections import Counter
import rpy2.rinterface
from rpy2.robjects.packages import STAP
from rpy2.robjects.vectors import FloatVector as rArray
import sys
start = int(sys.argv[1])
stop =  int(sys.argv[2])

class SeqRead:
    def __init__(self,data):
        rec = data.strip().split()
        self.errorProb = 10.0**(-(ord(rec[4])-33)/10.0)
        self.q = ord(rec[4])
        self.call = rec[3]

class Locus:
    def __init__(self,pos):
        self.majorAllele = None
        self.majorAlleleCount = -1
        self.qscores = {0:[],1:[],2:[]}
        self.reads = {0:[],1:[],2:[]}
        nuc_counter = {'A':0, 'C':0, 'G':0, 'T':0}
        self.read_counter = {0:nuc_counter.copy(),    1:nuc_counter.copy(),    2:nuc_counter.copy()}
        self.total_reads = {0:0,1:0,2:0}
        
    def __iter__(self):
        for key in self.qscores.keys():yield key
            
    def add(self,line,individual):
        if line != "":
            read = SeqRead(line)
            self.read_counter[individual][read.call] += 1
            self.reads[individual].append(read)
            self.total_reads[individual] += 1

    def calcMajorAllele(self):
        totals = {}
        for base in ['A','C','G','T']:
            for i in range(0,3):
                try: totals[base] += self.read_counter[i][base]
                except: totals[base] = self.read_counter[i][base]
        totals = Counter(totals)
        self.majorAllele, self.majorAlleleCount = totals.most_common(1)[0]  
        for ind in self:
            for read in self.reads[ind]:
                #if read.call == self.majorAllele: read.q = 1-read.q
                self.qscores[ind].append(read.q)
        
def ProcessPosition(pos):
    curLocus = Locus(pos)
    i_0_file = "data/Individual0_position%i.txt" % pos
    i_1_file = "data/Individual1_position%i.txt" % pos
    i_2_file = "data/Individual2_position%i.txt" % pos
    for line in open(i_0_file): curLocus.add(line,0)
    for line in open(i_1_file): curLocus.add(line,1)
    for line in open(i_2_file): curLocus.add(line,2)
    curLocus.calcMajorAllele()
    return curLocus  

from rpy2.robjects.packages import STAP
from rpy2.robjects.vectors import FloatVector as rArray
with open('Q2_DPBinomial.R', 'r') as fh: rtext = fh.read()
rfuncts = STAP(rtext,"")

from scipy.stats import bernoulli
rbern=bernoulli.rvs 

nsims = 1000
output = open("output/Question2_%i_%i.txt" % (start,stop),"w")
output.write("Individual Pos MC-PVal PA-Pval NA-PVal BA-PVal MCBN-PVal\n")
data=None
failed, totalRuns = 0, 0
for pos in range(start,stop):
    print(pos)
    data = ProcessPosition(pos)
    for individual in data:
        print(individual,pos,data.read_counter[individual],)
        if data.total_reads[individual] == 0: #if there are no reads for that individual at that position
            output.write("%i %i %0.4f %0.4f %0.4f %0.4f %0.4f\n" % (individual,pos,0.0,0.0,0.0,0.0,0.0))
            continue
        successfulTrials = 0
        refAllele = data.majorAllele
        for sim in range(nsims):
            numMatchesRef = 0
            for read in data.reads[individual]:
                #randomDraw = bern random (1-eij,1)
                rdraw = rbern(1 - read.errorProb, size=1)[0]
                numMatchesRef += rdraw
            if numMatchesRef <= data.read_counter[individual][refAllele]: successfulTrials+=1
            else: failed+=1
            totalRuns+=1
        MC_PVal   = successfulTrials/float(nsims)
        PA_Pval   = rfuncts.dpbinom(data.read_counter[individual][refAllele],rArray(data.qscores[individual]),method="PA")[0]
        NA_PVal   = rfuncts.dpbinom(data.read_counter[individual][refAllele],rArray(data.qscores[individual]),method="NA")[0]
        BA_PVal   = rfuncts.dpbinom(data.read_counter[individual][refAllele],rArray(data.qscores[individual]),method="BA")[0]
        MCBN_PVal = rfuncts.dpbinom(data.read_counter[individual][refAllele],rArray(data.qscores[individual]),method="MC")[0]
        #outString = "\t".join([str(individual),str(pos),"%0.8f" % MC_PVal,"%0.8f" % PA_Pval,"%0.8f" % NA_PVal,"%0.8f" % BA_PVal,"%0.8f" % MCBN_PVal,str(data.read_counter[individual],)])
        #output.write(outString+"\n")
        output.write("%i %i %0.4f %0.4f %0.4f %0.4f %0.4f\n" % (individual,pos,MC_PVal,PA_Pval,NA_PVal,BA_PVal,MCBN_PVal))
output.close()  