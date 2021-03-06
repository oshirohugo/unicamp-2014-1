import re

capacities = {}         #dictionary to store each city capacity
cities = {}             #dictionary to store city and number
distances = {}          #dictionary to store distaces between cities that were given
readCities = True       #aux variable to inform if second part of file is to be read
cityAndIndex = {}
min_distances = {}

#Auxiliry Function just to debug================================================
def printDic(dic):
    for key in dic:
        print key,
        print dic[key]

#Calculates distribution cost for each city=====================================
def calcCost(capacities, minDistances, numberOfCities):
    cost = {}
    for city_a in range(1, numberOfCities + 1):
        totalDeliveryCost = 0;
        for city_b in range(1, numberOfCities + 1):
            if city_a == city_b: #there is no distribution cost from a city to itself
                continue
            #uses delivery cost given in enunciation
            deliveryCost = minDistances[(city_a, city_b)] * capacities[(city_b)]
            totalDeliveryCost += deliveryCost #accumulates
        cost[city_a] = totalDeliveryCost #puts cost in a cost dictionary
       
    return cost #return dictionary with costs for each city

#Calculates min distance between 2 cities with Floy-Marshal algorithm===========
def calcMinDist(distances_, numberOfCities):
    min_dist = {} #aux dictionary to be used in Floy_Marshal algorithm loops
    res = {} #dictionary that will contains the minimun distances_ between two points
    
    for i in range(1, numberOfCities + 1):
        for j in range(1, numberOfCities + 1):
            if (i, j) in distances_: #if there is path between two points
                min_dist[(0, i, j)] = distances_[(i, j)]
            else:
                min_dist[(0, i, j)] = float("inf")
    
    for k in range(1, numberOfCities + 1):
        for i in range(1, numberOfCities + 1):
            for j in range(1, numberOfCities + 1):
                min_dist[(k, i, j)] = min( min_dist[(k-1, i, j)], min_dist[(k-1, i, k)] + min_dist[(k-1, k, j)] )
                res[(i, j)] = min_dist[(k, i, j)]
                if min_dist[(k - 1, i, j)] < min_dist[(k, i, j)]: #always take the minimun path apart from number of vertices used
                    res[(i, j)] = min_dist[(k - 1, i, j)]
    
    return res

#Prints cost and capacities of each city in way determined in 'saida.txt'======
def printCost(cities, capacities, cost):
    for city in range(1, len(cities) + 1):
        test = [cities[city], capacities[city], cost[city]] #use a list to store the values and print like 'saida.txt'
        print test
        
#==============================================================================
def nearest(fixedCity):
    nearestCity = "???"
    if fixedCity in cityAndIndex:
        minDistance = float("inf")
        fixedIndex = cityAndIndex[fixedCity]
        
        for index in range(1, len(cityAndIndex) + 1):
            if (min_distances[(fixedIndex, index)] < minDistance):
                minDistance = min_distances[(fixedIndex, index)]
                nearestCity = cities[index]
                
    return nearestCity
#==============================================================================
def farthest(fixedCity):
    farthestCity = "???"
    if fixedCity in cityAndIndex:
        maxDistance = -float("inf")
        fixedIndex = cityAndIndex[fixedCity]
        
        for index in range(1, len(cityAndIndex) + 1):
            if (min_distances[(fixedIndex, index)] > maxDistance):
                maxDistance = min_distances[(fixedIndex, index)]
                farthestCity = cities[index]
            
    return farthestCity
#main==========================================================================
def limitList(origin, lim):
    if origin in cityAndIndex:
        citiesList = []
        fixedIndex = cityAndIndex[origin]
        
        for index in range(1, len(cityAndIndex) + 1):
            if index == fixedIndex:
                continue
            if (min_distances[(fixedIndex, index)] <= lim):
                citiesList.append(cities[index])
        return citiesList
    else:
        return None
#main==========================================================================


def main():
    
    global capacities
    global cities
    global distances
    global readCities
    global cityAndIndex
    global min_distances
    
    inFile = open('distancias.txt') #open file

    lines = [line.strip('\n') for line in inFile] #reads each line without new line

    numberOfCities = int(lines[0])  #numberOfCities
    lines = lines[1::]              #ignores first line from process



    #process lines read from file
    for line in lines:
        words = re.findall('[^\s]+', line)  #user regular expressions to split each line
        if words[2] == 'xx':
            readCities = False              #determines if second part of file is to be processed
            continue
            
        if words[2] == '-1':                #determines if file process ends
            break
        
        if readCities == True:
            cities[int(words[0])] = words[2] #associate each city with a number
            cityAndIndex[words[2]] = int(words[0]) #associate each number with a city
            capacities[int(words[0])] = int(words[1]) #get each city capacity
        else:
            distances[(int(words[0]), int(words[1]))] = int(words[2]) #read distances between cities
            distances[(int(words[1]), int(words[0]))] = int(words[2]) #dist(A,B) == dist(B,A)       

    #calculates minumum distances between each pair of cities and put in a dictionary        
    min_distances = calcMinDist(distances, numberOfCities)
    #calculates the total distribution cost for each city and put in a dictionary
    cost = calcCost(capacities, min_distances, numberOfCities) 

    #printCost(cities, capacities, cost)
    #print "melhor ponto:", cities[min(cost, key=cost.get)], "custo:", min(cost.values())
    #print "maior custo:", cities[max(cost, key=cost.get)], "custo:", max(cost.values())

    #print "mais proxima: ", nearest('Campinas')
    #print "mais distante: ", farthest('Campinas')
    #print "limitList:" , limitList("Campinas", 9000), len(limitList("Campinas", 9000))
    
    inFile.close() #close file

#main()