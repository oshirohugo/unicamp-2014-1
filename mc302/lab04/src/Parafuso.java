/**
 * Class to represent a Parafuso
 * 
 * @author Hugo Oshiro
 * 
 **/
package prodPlan;

import xserial.XSerial;

public class Parafuso extends Parte implements XSerial{
	private float comprimento;
	private float diametro;
	
	
	public Parafuso() {
		super();
	}
	/**
	 * 
	 * @param code
	 * @param name
	 * @param description
	 * @param value
	 * @param length
	 * @param diameter
	 */
	public Parafuso(int code, String name, String description, float value,
			float length, float diameter) {
		// calls superclass constructor
		super(code, name, description, value);
		// initializes class specific attributes
		this.comprimento = length;
		this.diametro = diameter;
	}

	/**
	 * Method to return Parafuso String representation
	 * @return String representation of all Screw attributes, complementing
	 *         superclass toString()
	 */
	public String toString() {
		return super.toString() + " comprimento:" + this.comprimento
				+ " diametro:" + this.diametro;
	}

	@Override
	public void setObject(XSerial obj) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void setAttrib(String name, String value) {
				
		if("comprimento".equals(name))
			this.comprimento = Float.parseFloat(value);      
		else if("diametro".equals(name))       
			this.diametro = Float.parseFloat(value);  
		else
			super.setAttrib(name, value);
	}

	@Override
	public void setText(char[] chars, int start, int length) {
		// TODO Auto-generated method stub
		
	}
}
