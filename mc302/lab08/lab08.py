import re

def printDic(dic):
    for key in dic:
        print key,
        print dic[key]
        
def calcCost(capacities, min_distances, numberOfCities):
    cost = []
    for city_a in range(1, numberOfCities + 1):
        totalDeliveryCost = 0;
        for city_b in range(1, numberOfCities + 1):
            deliveryCost = min_distances[(city_a, city_b)] * capacities[(city_b)]
            totalDeliveryCost += deliveryCost
        cost.append(totalDeliveryCost)
       
    return cost

def calcMinDist(distances, numberOfCities):
    min_dist = {}
    res = {}
    
    for i in range(1, numberOfCities + 1):
        for j in range(1, numberOfCities + 1):
            if (i, j) in distances:
                min_dist[(0, i, j)] = distances[(i, j)]
            else:
                min_dist[(0, i, j)] = float("inf")
    
    for k in range(1, numberOfCities + 1):
        for i in range(1, numberOfCities + 1):
            for j in range(1, numberOfCities + 1):
                min_dist[(k, i, j)] = min( min_dist[(k-1, i, j)], min_dist[(k-1, i, k)] + min_dist[(k-1, k, j)] )
                res[(i, j)] = min_dist[(k, i, j)]
                if min_dist[(k - 1, i, j)] < min_dist[(k, i, j)]:
                    res[(i, j)] = min_dist[(k - 1, i, j)]
    
    return res

def printCost(cities, capacities, cost):
    for city in range(1, len(cities)):
        test = [cities[city], capacities[city], cost[city]]
        print test

#main==========================================================================

inFile = open('distancias.txt') #open file

lines = [line.strip('\n') for line in inFile] #reads each line without new line

numberOfCities = int(lines[0])  #numberOfCities
lines = lines[1::]              #ignores first line from process

capacities = {}
cities = {}
distances = {}
readCities = True
min_distances = {}
cost = []

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
        distances[(int(words[1]), int(words[0]))] = int(words[2])
        
min_distances = calcMinDist(distances, numberOfCities)
cost = calcCost(capacities, min_distances, numberOfCities)

printCost(cities, capacities, cost)
#printDic(min_distances)

    
inFile.close()
