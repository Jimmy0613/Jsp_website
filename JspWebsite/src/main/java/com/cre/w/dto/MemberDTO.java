package com.cre.w.dto;

public class MemberDTO {
	private String id;
	private String pw;
	private String name;
	private String email;
	private String jDate;
	private int pCount;
	private int rCount;
	private int heart;
	private String character1;
	private String character2;
	private String info;

	public MemberDTO(String id, String pw, String name, String email, String jDate, int pCount, int rCount, int heart, String character1, String character2) {
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.email = email;
		this.jDate = jDate;
		this.pCount = pCount;
		this.rCount = rCount;
		this.heart = heart;
		this.character1 = character1;
		this.character2 = character2;
		this.setInfo();
	}
	public void setInfo() {
		this.info = "🙂 " + id + "(" + name + ") 님";
	}
	public String getInfo() {
		return info;
	}
	public String getCharacter1() {
		return character1;
	}

	public void setCharacter1(String character1) {
		this.character1 = character1;
	}

	public String getCharacter2() {
		return character2;
	}

	public void setCharacter2(String character2) {
		this.character2 = character2;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getjDate() {
		return jDate;
	}
	public int getPCount() {
		return pCount;
	}
	public void setPCount(int post_count) {
		this.pCount = post_count;
	}
	public int getRCount() {
		return rCount;
	}
	public void setRCount(int reply_count) {
		this.rCount = reply_count;
	}
	public int getHeart() {
		return heart;
	}
	public void setHeart(int heart) {
		this.heart = heart;
	}
	public String getId() {
		return id;
	}
	public String getPw() {
		return pw;
	}
	public String getName() {
		return name;
	}
	public String getEmail() {
		return email;
	}
	
}
