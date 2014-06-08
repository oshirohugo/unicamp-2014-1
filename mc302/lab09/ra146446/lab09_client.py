#import xmlrpclib

#def test():
    #proxy = xmlrpclib.ServerProxy('http://xaveco.lab.ic.unicamp.br:9001')
    #print "ping:", proxy.ping()
    #print "ra:", proxy.ra()
    #print "nome:", proxy.nome()
    #print "Nearest:", proxy.maisProxima("Campinas") 
    #print "Nearest:", proxy.maisProxima("---")
    #print "Farthest:", proxy.maisDistante("Campinas")
    #print "Farthest:", proxy.maisDistante("---")
    #print "Lista: ", proxy.listaNumLimite("Campinas",45)
    #print "Lista: ", proxy.listaNumLimite("---",45)
    
#print "Test started:"

#test()

from testLab09 import test

test('localhost', 9013)
