package prodPlan;

/**
 * Class to represent a Motor which extends Parte
 * 
 * @author ra146446
 * 
 */
public class Motor extends Parte {
	private float potencia;
	private float corrente;
	private int rpm;

	/**
	 * 
	 * @param code
	 * @param name
	 * @param description
	 * @param value
	 * @param power
	 * @param current
	 * @param freq
	 */
	public Motor(int code, String name, String description, float value,
			float power, float current, int freq) {
		// calls superclass constructor to initialize inherited attributes
		super(code, name, description, value);
		// initializes all Motor specific attributes
		this.potencia = power;
		this.corrente = current;
		this.rpm = freq;
	}

	/**
	 * return String representation of Motor, completing and overwriting
	 * toString method of Parte class
	 * 
	 * @return String representations of Motor class
	 */
	public String toString() {
		return super.toString() + " potencia:" + this.potencia + " corrente:"
				+ this.corrente + " rpm:" + this.rpm;
	}
}
