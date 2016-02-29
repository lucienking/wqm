package com.wqm.common.util.json;

public class MessageObject {

	public static final String SUCCESS_CODE="1";
	public static final String ERROR_CODE="0";
	
	public String message;
	public String code;
	
	public MessageObject(){
		
	}
	
	public MessageObject(String message,String code){
		this.message=message;
		this.code=code;
	}
	
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
}
