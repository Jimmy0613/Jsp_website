package com.cre.w.dto;

public class StoryDTO {
	private int stNum;
	private String title;
	private String desc;

	private String mapOpen;

	public StoryDTO(int st_num, String title, String desc, String map_open) {
		this.stNum = st_num;
		this.title = title;
		this.desc = desc;
		this.mapOpen = map_open;
	}

	public int getStNum() {
		return stNum;
	}

	public String getTitle() {
		return title;
	}

	public String getDesc() {
		return desc;
	}

	public String getMapOpen() {
		return mapOpen;
	}
}
