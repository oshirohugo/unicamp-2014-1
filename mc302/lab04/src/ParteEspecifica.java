package prodPlan;

import java.util.LinkedList;
import java.util.List;

import xserial.XSerial;

/**
 * Class to represent a Parte Especifica extending Parte
 * 
 * @author ra146446
 * 
 */
public class ParteEspecifica extends Parte implements XSerial {

	/** Stores all characteristics */
	List<Caracteristica> caracteristicas;

	public ParteEspecifica() {
		super();
		this.caracteristicas = new LinkedList<Caracteristica>();
	}

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
		this.caracteristicas = new LinkedList<Caracteristica>();
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

		for (Caracteristica it : this.caracteristicas)
			if (it.nome == nome)
				throw new Exception();

		this.caracteristicas.add(new Caracteristica(nome, conteudo));
	}

	/**
	 * Returns description of one caracteristica
	 * 
	 * @param nome
	 * @return String representation of caracteristica description
	 */
	public String caracteristica(String nome) {
		for (Caracteristica it : this.caracteristicas)
			if (it.nome == nome)
				return it.conteudo;
		return null;
	}

	@Override
	public void setObject(XSerial obj) {
		if (obj instanceof Caracteristica)
			try {
				this.agregaCaracteristica(((Caracteristica) obj).nome,
						((Caracteristica) obj).conteudo);
			} catch (Exception e) {
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
