package com.cre.w.dto;

public class PostDTO {
	private int pNum;
	private String category;
	private String writer_id;
	private String writer;
	private String title;
	private String content;
	private String pDate;
	private int reply;
	private int views;
	private int heart;

	// read,list..
	public PostDTO(int pNum, String category, String wr_id, String writer, String title, String content, String pDate, int reply,
			int views, int heart) {
		this.pNum = pNum;
		this.category = category;
		this.writer_id = wr_id;
		this.writer = writer;
		this.title = title;
		this.content = content;
		this.pDate = pDate;
		this.reply = reply;
		this.views = views;
		this.heart = heart;
	}
	
	// write
	public PostDTO(String wr_id, String writer, String title, String content) {
		this.writer_id = wr_id;
		this.writer = writer;
		this.title = title;
		this.content = content;
	}
	
	public String getWriter_id() {
		return writer_id;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getReply() {
		return reply;
	}

	public void setReply(int reply) {
		this.reply = reply;
	}

	public int getViews() {
		return views;
	}

	public void setViews(int views) {
		this.views = views;
	}

	public int getHeart() {
		return heart;
	}

	public void setHeart(int heart) {
		this.heart = heart;
	}

	public int getpNum() {
		return pNum;
	}

	public String getWriter() {
		return writer;
	}

	public String getpDate() {
		return pDate;
	}

}
