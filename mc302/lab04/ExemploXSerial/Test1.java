package exemploXSerial;


import xserial.XParser;

public class Test1 {

	/**
	 * @param args
	 * @throws SAXException 
	 * @throws ParserConfigurationException 
	 * @throws Exception 
	 */
	public static void main(String[] args) throws Exception {
		XParser xp = new XParser(new MyFactory());
		ListaAlunos lista = (ListaAlunos) xp.parse("alunos.xml");
		for(Aluno a: lista.getLista()){
			System.out.print("aluno:"+a.nome+" ra:"+a.ra+" curso:"+a.curso+" cursadas: ");
			for(String dis:a.disciplinas) System.out.print(dis+" ");
			System.out.println();
		}
	    System.out.println("FIM");
	}

}
