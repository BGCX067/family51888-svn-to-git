package accp.exception;

public class IfMaximumExceeded extends RuntimeException {

	private String message;
	
	public IfMaximumExceeded(String message){
		super(message);
		this.message=message;
		
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	


}
