package com.cre.w.dto;

public class ReplyDTO {
	private int pNum;
	private int rNum;
	private String writer;
	private String content;
	private String rDate;
	public ReplyDTO(int pNum, int rNum, String writer, String content, String rDate) {
		super();
		this.pNum = pNum;
		this.rNum = rNum;
		this.writer = writer;
		this.content = content;
		this.rDate = rDate;
	}
	
	public ReplyDTO(int rNum, String writer, String content, String rDate) {
		super();
		this.rNum = rNum;
		this.writer = writer;
		this.content = content;
		this.rDate = rDate;
	}

	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getpNum() {
		return pNum;
	}
	public int getrNum() {
		return rNum;
	}
	public String getWriter() {
		return writer;
	}
	public String getrDate() {
		return rDate;
	}

}
