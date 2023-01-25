package com.cre.w.dto;

import java.text.SimpleDateFormat;
import java.util.Date;

public class RpsDTO {
	private String member_id;
	private String result;

	public RpsDTO(String member_id, String result) {
		this.member_id = member_id;
		this.result = result;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}
}
