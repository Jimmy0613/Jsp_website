package com.cre.w.dto;

public class RpsDTO {
	private String user_id;
	private String result;

	public RpsDTO(String user_id, String result) {
		this.user_id = user_id;
		this.result = result;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}
}