package com.strongit.framework.model;

import java.io.Serializable;

/**
 * 基本Model
 * @author lanjh
 *
 */
public interface Model extends Serializable{
	
	public int getVersion();
	public void setUuid(int uuid);

}
