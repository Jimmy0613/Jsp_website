package com.cre.w.dto;

public class LogDTO {
	private int log_num;
	private String log;
	private String cls;
	
	public LogDTO(int log_num, String log, String cl) {
		this.log_num = log_num;
		this.log = log;
		this.cls = cl;
	}

	public int getLog_num() {
		return log_num;
	}

	public String getLog() {
		return log;
	}

	public String getCls() {
		return cls;
	}
	
}
