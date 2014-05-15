package prodPlan;

/**
 * Class to represent an Item
 * 
 * @author ra146446
 * 
 */
public class Item {
	protected Parte parte;
	protected int quantidade;

	/**
	 * 
	 * @param part
	 * @param quantity
	 */
	public Item(Parte part, int quantity) {
		this.parte = part;
		this.quantidade = quantity;
	}

	/**
	 * Return the total value of item, which means: unity value * quantity
	 * 
	 * @return a float value representing total value of item, which means unity
	 *         value * quantity
	 */
	public float calculaValor() {
		return this.parte.valor * this.quantidade;
	}

	/**
	 * @return String representation of all components of an Item
	 */
	public String toString() {
		return "cod:" + this.parte.cod + " nome:" + this.parte.nome
				+ " quantidade:" + this.quantidade + " valor unitário:"
				+ this.parte.valor + " valor:" + this.parte.valor
				* this.quantidade;
	}

}
