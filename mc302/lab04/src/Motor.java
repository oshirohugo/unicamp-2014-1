package prodPlan;

import xserial.XSerial;

/**
 * Class to represent a Motor which extends Parte
 * 
 * @author ra146446
 * 
 */
public class Motor extends Parte implements XSerial{
	private float potencia;
	private float corrente;
	private int rpm;

	public Motor() {
		super();
	}
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

	@Override
	public void setObject(XSerial obj) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void setAttrib(String name, String value) {
		
		if("potencia".equals(name))
			this.potencia = Float.parseFloat(value);      
		else if("corrente".equals(name))       
			this.corrente = Float.parseFloat(value);
		else if("rpm".equals(name))       
			this.rpm = Integer.parseInt(value);  
		else
			super.setAttrib(name, value);	
	}

	@Override
	public void setText(char[] chars, int start, int length) {
		// TODO Auto-generated method stub
		
	}
}