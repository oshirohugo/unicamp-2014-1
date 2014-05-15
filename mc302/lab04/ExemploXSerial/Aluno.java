package exemploXSerial;

/**
 * Exemplo de uso da interface XSerial
 * Representa os dados de um 'aluno'
 */

import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.Set;

import xserial.XSerial;

public class Aluno implements XSerial {
	
	String nome;
	String documento;
	String ra;
	String curso;
	Set<String> disciplinas;
	
	public Aluno(){
		disciplinas = new LinkedHashSet<String>();
	}

	/**
	 * Associa a este objeto um atributo da tag xml que deu 
	 * origem ao mesmo.
	 */
	@Override
	public void setAttrib(String name, String value) {
		if("nome".equals(name))      nome = value;      else
		if("doc".equals(name))       documento = value; else
		if("ra".equals(name))        ra = value;        else
		if("curso".equals(name))     curso = value;     else
        System.err.println("Aluno - atributo desconhecido nome:" + name + " valor:" + value);
	}

	/**
	 * Associa a este objeto o objeto oriundo de uma
	 * 'tag filha' (neste caso, nada a fazer)
	 */
	@Override
	public void setObject(XSerial obj) {
        // nada a fazer aqui
		System.out.println("Aluno.setObject() obj.class:"+obj.getClass().getName());
	}

	/**
	 * Associa a este objeto o texto contido na tag que
	 * deu origem ao mesmo (neste caso, nada a fazer)
	 */
	public void setText(char[] chars, int start, int length) {
		// este método pode ser chamado por ListaAux.setText() qdo encontra uma disciplina <cursada> 
		String txt = new String(chars,start,length).trim();
		if(txt.length() > 0) {
			System.out.println("Aluno.setText() text:["+txt+"]");
			disciplinas.add(txt);
		}
	}

}
