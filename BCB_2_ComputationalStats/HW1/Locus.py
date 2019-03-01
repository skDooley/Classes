from collections import Counter     
class Locus:
    def __init__(self,pos):
        self.majorAllele = None
        self.majorAlleleCount = -1
        self.qscores = {0:[],1:[],2:[]}
        self.errorProbs = {0:[],1:[],2:[]}
        self.reads = {0:[],1:[],2:[]}
        self.callMatchRef = {0:[],1:[],2:[]}
        nuc_counter = {'A':0, 'C':0, 'G':0, 'T':0}
        self.read_counter = {0:nuc_counter.copy(),    1:nuc_counter.copy(),    2:nuc_counter.copy()}
        self.total_reads = {0:0,1:0,2:0}
        
    def __iter__(self):
        for key in self.qscores.keys():yield key
            
    def add(self,line,individual):
        if line != "":
            read = SeqRead(line)
            self.reads[individual].append(read)
            self.errorProbs[individual].append(read.errorProb)
            self.read_counter[individual][read.call] += 1
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
                self.callMatchRef[ind].append(int(read.call == self.majorAllele))
#                 self.qscores[ind].append(read.q)
        
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

class SeqRead:
    def __init__(self,data):
        rec = data.strip().split()
        self.q = ord(rec[4]) - 33
        self.errorProb = 10.0**((-self.q)/10.0)
        self.call = rec[3]
        self.matchesRef = False        
