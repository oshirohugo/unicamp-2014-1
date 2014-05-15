package prodPlan;

import xserial.XSerial;

/**
 * Abstract Class to represent Parte
 * 
 * @author ra146446
 * 
 */
public abstract class Parte implements XSerial{
	protected int cod;
	protected String nome;
	protected String descricao;
	protected float valor;
	
	public Parte() {
		
	}
	
	/**
	 * 
	 * @param code
	 * @param name
	 * @param description
	 * @param value
	 */
	public Parte(int code, String name, String description, float value) {
		this.cod = code;
		this.nome = name;
		this.descricao = description;
		this.valor = value;
	}

	/**
	 * Method to return Parte value
	 * 
	 * @return the part value
	 */
	public float calculaValor() {
		return this.valor;
	}

	/**
	 * Method to return String representation of a Parte instance
	 * 
	 * @return String representation of all attributes in a Parte instance
	 */
	public String toString() {
		return "codigo:" + this.cod + " nome:" + this.nome + " descrição:"
				+ this.descricao + " valor:" + this.valor;
	}
	
	@Override
	public void setAttrib(String name, String value) {
		if("cod".equals(name))
			this.cod = Integer.parseInt(value);      
		else if("nome".equals(name))       
			this.nome = value;
		else if("descricao".equals(name))       
			this.descricao = value;
		else if("valor".equals(name))       
			this.valor = Float.parseFloat(value); 
		else
	        System.err.println("Parte - atributo desconhecido nome:" + name + " valor:" + value);	
		
	}
	
	
}
