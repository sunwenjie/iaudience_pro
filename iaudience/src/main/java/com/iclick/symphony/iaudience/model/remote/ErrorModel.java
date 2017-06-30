package com.iclick.symphony.iaudience.model.remote;

import com.alibaba.fastjson.JSON;


public class ErrorModel {
	
	public ErrorInfo error;
	public ErrorModel(int code) {
		error = new ErrorInfo(code, "invalid", "Invalid parameter value");
	}

	public ErrorModel(int code,String reason,String message) {
		error = new ErrorInfo(code, reason, message);
	}
	
	public static class ErrorInfo {
		
		public int code;
		public String reason;
		public String message;
		
		public ErrorInfo(int code,String reason,String message) {
			this.code = code;
			this.reason = reason;
			this.message = message;
		}
	}
	
	public static void main(String[] args) {
		System.out.println(JSON.toJSONString(new ErrorModel(200, "haha", "123123123123")));
	}
}
