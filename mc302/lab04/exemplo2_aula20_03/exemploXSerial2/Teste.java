package exemploXSerial2;

import java.util.ArrayList;
import java.util.List;

import javax.xml.parsers.ParserConfigurationException;

import xserial.XFactory;
import xserial.XParser;
import xserial.XSerial;

public class Teste implements XFactory {

	@Override
	public XSerial makeObject(String name, XSerial Obj) {
		if("ocupacoes".equals(name)) return new Ocupacoes();
		if("ocupacao".equals(name))  return new Ocupacao();
		if("sinonimo".equals(name))  return new Sinonimo();
		System.err.println("Teste.makeObject() - tag desconhecida:"+name);
		return null;
	}

	/**
	 * @param args
	 * @throws Exception 
	 * @throws ParserConfigurationException 
	 */
	public static void main(String[] args) throws Exception {
		XParser xp = new XParser(new Teste());
		Ocupacoes ocupacoes = (Ocupacoes) xp.parse("ocupacoes.xml");
		for(Ocupacao ocp: ocupacoes.getList()){
			System.out.println(ocp.toString());
		}

	}

}

/**
 * Classe auxiliar usada para a construção de objetos Ocupacao
 * a partir de um texto xml.
 *
 */
class Sinonimo implements XSerial {
	
	private String text;         // texto do sinônimo
	
	public Sinonimo(){
		text = null; // por via das dúvidas...
	}
	
	public String getText() { return text; }

	@Override
	public void setObject(XSerial obj) {
		// Nada a fazer (a tag <sinonimo> não contém outras tags)		
	}

	@Override
	public void setAttrib(String name, String value) {
		// Nada a fazer (a tag <sinonimo> não tem atributos)		
	}

	@Override
	public void setText(char[] chars, int start, int length) {
		this.text = new String(chars,start,length).trim();
	}
	
}

/**
 * Mantém a lista de objetos Ocupacao criados a partir do texto xml.
 *
 */
class Ocupacoes implements XSerial {
	
	private List<Ocupacao> list; // 'a' lista de objetos Ocupacao
	
	/**
	 * Construtor
	 */
	public Ocupacoes(){
		list = new ArrayList<Ocupacao>();
	}
	
	/**
	 * Retorna a lista mantida por este objeto
	 * (propositadamente disponibilizada como um método)
	 * @return
	 */
	public List<Ocupacao> getList() { return list; }

	@Override
	public void setObject(XSerial obj) {
		// Agrega um objeto a este objeto (só pode ser da classe Ocupacao)
		if(obj instanceof Ocupacao) list.add((Ocupacao)obj);
		else System.err.println("Ocupacoes.setObject() - objeto de class inválida:"+obj.getClass().getName());
		
	}

	@Override
	public void setAttrib(String name, String value) {
		// Nada a fazer (sabemos que a tag <ocupacoes> não tem atributos)
		
	}

	@Override
	public void setText(char[] chars, int start, int length) {
		// Nada a fazer (a tag <ocupacoes> não contém nenhum texto)		
	}
	
}
