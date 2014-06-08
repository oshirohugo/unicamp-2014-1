import xmlrpclib

def test(servidor,porta):
    proxy = xmlrpclib.ServerProxy('http://'+servidor+':'+str(porta), allow_none=True)
    nomes = ['Botucatu', 'Ribeirao_Preto', 'Franca', 'Presidente_Prudente', 'Sorocaba', 'Araraquara',
             'Guaratingueta', 'Rio_Claro', 'Piracicaba', 'Capao_Bonito', 'Mogi_das_Cruzes', 'Campinas',
             'Sao_Jose_dos_Campos', 'Assis', 'Itapetininga', 'Taubate', 'Marilia', 'Sao_Jose_do_Rio_Preto',
             'Votuporanga', 'Barretos', 'Aracatuba', 'Ourinhos', 'Santos', 'Americana', 'Bauru', 'Sao_Carlos',
             'Catanduva', 'Jundiai', 'Sao_Paulo', 'Avare', 'Itu', 'Itatiba']
    print 'ping()',proxy.ping()
    print 'ra:',proxy.ra(),'nome:',proxy.nome()
    print
    for cidade in nomes:
        print 'mais proxima a',cidade+':',proxy.maisProxima(cidade)
        print 'mais distante de',cidade+':',proxy.maisDistante(cidade)
        print 'cidades num raio de 150km:',proxy.listaNumLimite(cidade,150)
        print
      

