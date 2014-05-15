package prodPlan;

import xserial.XFactory;
import xserial.XSerial;

public class MyFactory implements XFactory {

	@Override
	public XSerial makeObject(String name, XSerial upperObj) {
		if("lista".equals(name ))    
			return new Lista(); 
		if("item".equals(name))
			return new Item();
		if("parteEspecifica".equals(name))
			return new ParteEspecifica();
		if("parteComposta".equals(name))
			return new ParteComposta();
		if("motor".equals(name))
			return new Motor();
		if("parafuso".equals(name))
			return new Parafuso();
		if("caracteristica".equals(name))
			return new Caracteristica();
		System.err.println("MyFactory.makeObject(): tag desconhecida:" + name);
		return null;
	}

	
}
