package qq.entity;

import java.io.*;

public class Response implements Serializable{
	private RequestType type;//响应类型
	private Serializable value;//响应的值
	private static final long serialVersionUID = 12071113985L;
	
	public Response(RequestType type){
		this.type=type;
	}
	public void setData(Serializable value){
		this.value=value;
	}
	public Serializable getData(){
		return value;
	}
	public RequestType getType(){
		return type;
	}
}
