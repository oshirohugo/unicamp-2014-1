package prodPlan;

import java.util.HashMap;
import java.util.Map;

/**
 * Class to represent a Parte Especifica extending Parte
 * 
 * @author ra146446
 * 
 */
public class ParteEspecifica extends Parte {

	/** Stores all characteristics */
	Map<String, String> caracteristicas;

	/**
	 * 
	 * @param code
	 * @param name
	 * @param description
	 * @param value
	 */
	public ParteEspecifica(int code, String name, String description,
			float value) {
		/** calls superclass constructor */
		super(code, name, description, value);
		/** initializes caracteristicas with an empty HashMap */
		this.caracteristicas = new HashMap<String, String>();
		// TODO Auto-generated constructor stub
	}

	/**
	 * Inserts a characteristic inside attribute Map<String, String>
	 * caracteristicas if it isn't inside it yet
	 * 
	 * @param nome
	 * @param conteudo
	 * @throws Exception
	 *             , if nome == null, content == null, or if the characteristic
	 *             has been already inserted
	 */
	public void agregaCaracteristica(String nome, String conteudo)
			throws Exception {
		if (nome == null || conteudo == null)
			throw new Exception();
		if (this.caracteristicas.containsKey(nome))
			throw new Exception();

		this.caracteristicas.put(nome, conteudo);
	}

	/**
	 * Returns description of one caracteristica
	 * @param nome
	 * @return String representation of caracteristica description
	 */
	public String caracteristica(String nome) {
		return this.caracteristicas.get(nome);
	}
}
