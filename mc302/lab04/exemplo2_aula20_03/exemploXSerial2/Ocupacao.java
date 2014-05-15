package exemploXSerial2;

import java.util.LinkedHashSet;
import java.util.Set;
import xserial.XSerial;

public class Ocupacao implements XSerial{
	
	String codigo;          // código da ocupação (CBO)
	String descricao;       // descrição textual da ocupação
	Set<String> sinonimos;  // conjunto de sinonimos
  	
	/**
	 * Construtor
	 */
	public Ocupacao(){
		codigo = null;
		descricao = null;
		sinonimos = new LinkedHashSet<String> ();
	}
	
	/**
	 * Gera uma representação da ocupação como String
	 */
	public String toString(){
		String delim = "";
		String res =  "ocupacao: "+codigo + " " + descricao +" { ";
		for(String sin: sinonimos) {
			res += delim + sin;
			delim = ", ";
		}
		return res+" }";
	}
	
	@Override
	public void setObject(XSerial obj) {
		if(obj instanceof Sinonimo) sinonimos.add(((Sinonimo)obj).getText());	
	}
	
	@Override
	public void setAttrib(String name, String value) {
		if("cod".equals(name)) this.codigo = value; else
		if("descricao".equals(name)) this.descricao = value; 
		else System.err.println("Erro em Ocupacao.setAttrib() - atributo invalido:"+name);	
	}
	
	@Override
	public void setText(char[] chars, int start, int length) {
		// Nada a fazer (A tag <ocupacao> não contém texto).
	}

}
