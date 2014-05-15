package prodPlan;

import xserial.XSerial;

/**
 * Class to represent an Item
 * 
 * @author ra146446
 * 
 */
public class Item implements XSerial {
	protected Parte parte;
	protected int quantidade;

	/**
	 * Defaults constructor
	 */
	public Item() {
		
	}

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

	@Override
	public void setObject(XSerial obj) {
		if(obj instanceof Parafuso)
			this.parte = (Parafuso)obj;
		else if (obj instanceof Motor)
			this.parte = (Motor)obj;
		else if (obj instanceof ParteEspecifica)
			this.parte = (ParteEspecifica)obj;
		else if (obj instanceof ParteComposta)
			this.parte = (ParteComposta)obj;
	}

	@Override
	public void setAttrib(String name, String value) {
		if("quantidade".equals(name))
			this.quantidade = Integer.parseInt(value);
		else
	        System.err.println("Item - atributo desconhecido nome:" + name + " valor:" + value);		
	}

	@Override
	public void setText(char[] chars, int start, int length) {
		// TODO Auto-generated method stub
		
	}

}
