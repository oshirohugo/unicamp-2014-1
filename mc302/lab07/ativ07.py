#This module is used read fuel usage and distance 
#data and calc consume statistics from it
#Hugo K. Oshiro

data = {} #dictionary to store data input - 'date' : (volume, kms)
consumes = {} #dictionary to store consumes calc by date - consume : (consume, 'date')           
consumesList = [] #list to store consume
kmsList = [] #list to store distance
consumeWasCalc = False #flag to calc statistics

#function used to store data input in data dictionary
def anota(date, volume, kms):
    global data
    data[date] = (volume, kms)
    
#function used to calc statistics from data
def calcConsume():
    global consumes #needed to alter global value
    global consumesList #needed to alter global value
    
    #calc consume for all dates
    for date in data:
        volume = data[date][0] #get volume from a date
        kms = data[date][1] #get kms from date
        consume = kms / volume #calc consume
        consumes[consume] = (consume, date) #put consume in consume dict
        consumesList.append(consume) #put consume in consume list
 
        kmsList.append(kms) #stores values in kmsList be used in kmMed
        
def consMin():
    global consumeWasCalc #needed to alter global value
    #if statistics wasn't calc yet
    if not consumeWasCalc:
        calcConsume() #calc statistics
        consumeWasCalc = True #inform it
    return consumes[min(consumesList)] #return minor element

def consMax():
    global consumeWasCalc #needed to alter global value
    #if statistics wasn't calc yet
    if not consumeWasCalc:
        calcConsume()  #calc statistics
        consumeWasCalc = True #inform it
    return consumes[max(consumesList)] #return greater element

def consMed():
    global consumeWasCalc #needed to alter global value
    #if statistics wasn't calc yet
    if not consumeWasCalc:
        calcConsume() #calc statistics
        consumeWasCalc = True #inform it
    return sum(consumesList) / len(consumesList) #return consumes list average

def kmMed():
    global consumeWasCalc  #needed to alter global value
    #if statistics wasn't calc yet
    if not consumeWasCalc:
        calcConsume() #calc statistics
        consumeWasCalc = True #inform it
    return sum(kmsList) / len(kmsList) #return kms list average
