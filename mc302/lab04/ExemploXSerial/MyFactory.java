package exemploXSerial;

/**
 * Exemplo de uso da interface XSerial.
 * Esta classe implementa o método makeObject, definido na interface XFactory,
 * e que é o responsável pela criação dos objetos à medida em que é feito o 
 * processamento do texto xml pelo objeto XParser.
 */

import xserial.XFactory;
import xserial.XSerial;

public class MyFactory implements XFactory {

	/**
	 * Cria um objeto a ser associado a uma tag xml.
	 * Os parâmetros são o nome da tag e a referência ao último objeto
	 * criado durante o processamento do documento xml.
	 */
	@Override
	public XSerial makeObject(String name, XSerial upperObj) {
		if("alunos".equals(name ))    return new ListaAlunos(); 
		if("aluno".equals(name))      return new Aluno();
		if("cursadas".equals(name))   return new ListaAux(upperObj);
		if("disciplina".equals(name)) return new ListaAux(upperObj);
		System.err.println("MyFactory.makeObject(): tag desconhecida:" + name);
		return null;
	}
}


/**
 * Classe auxiliar usada apenas para manter os dados das tags do documento xml 
 * para as quais não existe um objeto associado na estrutura de objetos resultante 
 * do processamento.
 *
 */
class ListaAux implements XSerial{
	private XSerial objetoPai;  // referência ao objeto ao qual este objeto será associado
	
	public ListaAux(XSerial pai){
		this.objetoPai = pai;
	}
	
	/**
	 * Neste caso, o problema de associar o atributo é transferido ao objeto pai.
	 */
	@Override
	public void setAttrib(String name, String value) {
		objetoPai.setAttrib(name, value);		
	}

	/**
	 * Neste caso também, o problema é transferido ao objeto pai
	 */
	@Override
	public void setObject(XSerial obj) {
		objetoPai.setObject(obj);	
	}

	/**
	 * Neste caso, idem ...
	 */
	@Override
	public void setText(char[] chars, int start, int length) {
		objetoPai.setText(chars, start, length);	
	}
}

