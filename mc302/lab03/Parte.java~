package prodPlan;

/**
 * Abstract Class to represent Parte
 * 
 * @author ra146446
 * 
 */
public abstract class Parte {
	protected int cod;
	protected String nome;
	protected String descricao;
	protected float valor;

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
}
