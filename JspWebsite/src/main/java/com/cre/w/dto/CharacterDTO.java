package com.cre.w.dto;

public class CharacterDTO {
	private String userId;
	private String name;
	private String location;
	private int story;
	private int level;
	private int exp;
	private int maxExp;
	private int power;
	private int maxPower;
	private int coin;
	private String info;
	private String profile;

	public CharacterDTO(String mem_id, String name, String location, int story, int level, int exp, int max_exp,
			int power, int max_power, int coin) {
		this.userId = mem_id;
		this.name = name;
		this.location = location;
		this.story = story;
		this.level = level;
		this.exp = exp;
		this.maxExp = max_exp;
		this.power = power;
		this.maxPower = max_power;
		this.coin = coin;
		this.setInfo();
		this.setProfile();
	}

	public String getProfile() {
		return profile;
	}

	public void setProfile() {
		this.profile = "👤 " + name + " 👤 ✨레벨( " + level + " )";
	}

	public String getInfo() {
		return info;
	}

	public void setInfo() {
		this.info = "👤 " + name + " 👤 ✨레벨( " + level + " ) 💪힘( " + power + " / " + maxPower
				+ " ) 💰금화 ( " + coin + " 개)";
	}

	public String getMemberId() {
		return userId;
	}

	public String getLocation() {
		return location;
	}

	public String getName() {
		return name;
	}

	public int getStory() {
		return story;
	}

	public int getLevel() {
		return level;
	}

	public int getExp() {
		return exp;
	}

	public int getMaxExp() {
		return maxExp;
	}

	public int getPower() {
		return power;
	}

	public int getMaxPower() {
		return maxPower;
	}

	public int getCoin() {
		return coin;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public void setStory(int story) {
		this.story = story;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	public void setExp(int exp) {
		this.exp = exp;
	}

	public void setMaxExp(int maxExp) {
		this.maxExp = maxExp;
	}

	public void setPower(int power) {
		this.power = power;
	}

	public void setMaxPower(int maxPower) {
		this.maxPower = maxPower;
	}

	public void setCoin(int coin) {
		this.coin = coin;
	}
}
