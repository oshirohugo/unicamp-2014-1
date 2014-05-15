package prodPlan;

import xserial.XSerial;

/**
 * Class to abstract Caracteristicas
 * @author ra146446
 *
 */
public class Caracteristica implements XSerial{
	String nome;
	String conteudo;
	
	public Caracteristica() {
		
	}
	/**
	 * 
	 * @param name
	 * @param content
	 */
	public Caracteristica(String name, String content) {
		this.nome = name;
		this.conteudo = content;
	}
	@Override
	public void setObject(XSerial obj) {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void setAttrib(String name, String value) {
		if("nome".equals(name))
			this.nome = value;      
		else if("conteudo".equals(name))       
			this.conteudo = value;   
		else
	        System.err.println("Caracteristica - atributo desconhecido nome:" + name + " valor:" + value);	
	}
	@Override
	public void setText(char[] chars, int start, int length) {
		// TODO Auto-generated method stub
		
	}

}
