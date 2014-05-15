import re

def printDic(dic):
    for key in dic:
        print key,
        print dic[key]
        
def calcCost(capacities, distances, numberOfCities):
    cost = {}
    for a in range(1, numberOfCities + 1):
        cost[a] = 0
        for b in range(1, numberOfCities + 1):
            d = distances[(a, b)] * capacities[b]
            cost[a] += d

inFile = open('distancias.txt') #open file

lines = [line.strip('\n') for line in inFile] #reads each line without new line

numberOfCities = int(lines[0])
lines = lines[1::]

capacities = {}
cities = {}
distances = {}
readCities = True

for line in lines:
    words = re.findall('[^\s]+', line)
    if words[2] == 'xx':
        readCities = False
        continue
        
    if words[2] == '-1':        
        break
    
    if readCities == True:
        cities[int(words[0])] = words[2]
        capacities[int(words[0])] = int(words[1])
    else:
        distances[(int(words[0]), int(words[1]))] = int(words[2])
     
cost = {}

printDic(distances)

    
inFile.close()
