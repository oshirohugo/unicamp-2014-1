package exemploXSerial;

/**
 * Exemplo de uso da inteface XSerial.
 * Representa uma 'lista de alunos'
 */

import java.util.LinkedList;
import java.util.List;

import xserial.XSerial;

public class ListaAlunos implements XSerial {

	List<Aluno> lista;
	
	
	public ListaAlunos(){
		lista = new LinkedList<Aluno>();
	}
	
	/**
	 * Associa a este objeto um atributo da tag xml que deu
	 * origem ao mesmo (neste caso, nada a fazer)
	 */
	@Override
	public void setAttrib(String name, String value) {
		// Nada a fazer
	}

	/**
	 * Associa a este objeto o objeto oriundo de uma tag filha
	 * (neste caso o objeto da tag filha deve ser um objeto Aluno,
	 * que será agregado à lista)
	 */
	@Override
	public void setObject(XSerial obj) {
		if(obj instanceof Aluno) lista.add((Aluno)obj);
		else System.err.println("ListaAlunos.setObject: objeto não é Aluno");
	}

	
	/**
	 * Associa a este objeto o texto contido na tag xml que deu
	 * origem ao mesmo (neste caso, nada a fazer)
	 */
	@Override
	public void setText(char[] chars, int start, int length) {
		// Nada a fazer
	}
	
	public List<Aluno> getLista() { return lista; }

}
