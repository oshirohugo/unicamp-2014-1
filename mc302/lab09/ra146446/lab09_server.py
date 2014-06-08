from SimpleXMLRPCServer import SimpleXMLRPCServer
import distributionCenter

def ping():
    return True

def ra():
    return "146446"

def nome():
    return "Hugo Kiyodi Oshiro"

def maisProxima(cidade):
    return distributionCenter.nearest(cidade)

def maisDistante(cidade):
    return distributionCenter.farthest(cidade)

def listaNumLimite(cidadeOrigem,limite):
    return distributionCenter.limitList(cidadeOrigem, limite)

server = SimpleXMLRPCServer(('localhost', 9013), logRequests=True, allow_none=True)

server.register_function(ping)
server.register_function(ra)
server.register_function(nome)
server.register_function(maisProxima)
server.register_function(maisDistante)
server.register_function(listaNumLimite)

distributionCenter.main() #call distributionCenter main

try:
   print 'Press Ctrl+C to finish'
   server.serve_forever()
except KeyboardInterrupt:
   print 'Server Ended'
    