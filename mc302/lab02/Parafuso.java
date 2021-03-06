
package prodPlan;
/**
 * Class to represent a Parafuso
 * 
 * @author ra146446
 * 
 **/
public class Parafuso extends Parte {
	private float comprimento;
	private float diametro;

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
}
