package com.strongit.framework.model;

import java.lang.reflect.Field;
/**
 * 抽象模型
 * @author lanjh
 *
 */
public abstract class AbstractModel implements Model{

	@Override
	public String toString() {
		StringBuffer buffer = new StringBuffer();
		
		buffer.append(this.getClass().getName()+":");
		for(Field field:this.getClass().getDeclaredFields()){
			final String name = field.getName();
			field.setAccessible(true);
			try {
				final Object value = field.get(this);
				buffer.append(name+"="+value+",");
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return buffer.toString();

	}

}
