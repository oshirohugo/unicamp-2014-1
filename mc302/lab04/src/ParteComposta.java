package prodPlan;

import java.util.LinkedList;
import java.util.List;
import java.util.Set;
import java.util.LinkedHashSet;

import xserial.XSerial;

/**
 * Class to represent a Parte Composta extending Parte
 * 
 * @author ra146446
 * 
 */
public class ParteComposta extends Parte implements XSerial{

	/** Stores all itens that composes a ParteComposta instance */
	Set<Item> itens;

	public ParteComposta() {
		super();
		this.itens = new LinkedHashSet<Item>();
		// TODO Auto-generated constructor stub
	}
	
	/**
	 * 
	 * @param code
	 * @param name
	 * @param description
	 * @param value
	 */
	public ParteComposta(int code, String name, String description, float value) {
		super(code, name, description, value);
		this.itens = new LinkedHashSet<Item>();
		// TODO Auto-generated constructor stub
	}

	/**
	 * Insert an item to compose ParteComposta instance, adding one item to its
	 * Set<Item> itens attribute
	 * 
	 * @param parte
	 * @param quantidade
	 * @throws Exception
	 */
	public void agregaItem(Parte parte, int quantidade) throws Exception {
		
		if (quantidade <= 0 || parte == null) {
			throw new Exception();
		}
		if (!this.itens.isEmpty()) {
			for (Item it : this.itens) {
				if(it.parte.cod == parte.cod)
					throw new Exception();
			}	
		}
		this.itens.add(new Item(parte, quantidade));
		this.valor += parte.valor * quantidade;
	}

	/**
	 * Lists all itens that are in a ParteComposta instance
	 * 
	 * @return a List representation of itens that compose ParteComposta
	 *         instance
	 */
	List<Item> listaDeItens() {
		// converts itens in a Linked List representation
		return new LinkedList<Item>(this.itens);
	}

	/**
	 * overwrites Parte's calculaValor and return the total value of all itens
	 * in ParteComposta instance
	 * 
	 * @return a float with total value of all itens that compose a
	 *         ParteComposta instance
	 */
	public float calculaValor() {
		return this.valor;
	}

	/**
	 * returns string representation of ParteComposta, using Parte's toString
	 * method
	 */
	public String toString() {
		return super.toString();
	}

	@Override
	public void setObject(XSerial obj) {
		if(obj instanceof Item)
			try {
				this.agregaItem( ((Item) obj).parte, ((Item) obj).quantidade);
			}catch (Exception e) {
				// TODO: handle exception
			}
	}

	@Override
	public void setAttrib(String name, String value) {
		super.setAttrib(name, value);
	}

	@Override
	public void setText(char[] chars, int start, int length) {
		// TODO Auto-generated method stub
		
	}

}
