package prodPlan;

import xserial.XSerial;

/**
	 Classe auxiliar para ser utilizada apenas durante 
	 o 'parsing' do arquivo xml para manter as partes
	 representadas no mesmo
**/

public class Lista extends ParteComposta implements XSerial{

	public Lista() {
		super();	
	    // nada a fazer
	}

	@Override
	public void setObject(XSerial obj) {
		if(obj instanceof Item)
			try{
				this.agregaItem(((Item) obj).parte, ((Item) obj).quantidade);
			} catch (Exception e) {
				// TODO: handle exception
			}		
	}

	@Override
	public void setAttrib(String name, String value) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void setText(char[] chars, int start, int length) {
		// TODO Auto-generated method stub
		
	}
	
	
	

}
