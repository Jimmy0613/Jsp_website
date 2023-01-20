package com.cre.w.dto;

import com.cre.w.sys.Map;

public class MapDTO {
	Map map = new Map();
	
	private String mapId;
	private String name;
	private String desc;
	private int openStory;
	private String m_e;
	private String m_w;
	private String m_s;
	private String m_n;
	private String info;
	
	public MapDTO(String map_id, String name, String desc, int open_story, String m_e, String m_w,
			String m_s, String m_n) {
		super();
		this.mapId = map_id;
		this.name = name;
		this.desc = desc;
		this.openStory = open_story;
		this.m_e = m_e;
		this.m_w = m_w;
		this.m_s = m_s;
		this.m_n = m_n;
		setInfo();
	}
	
	public String getM_e() {
		return m_e;
	}

	public String getM_w() {
		return m_w;
	}

	public String getM_s() {
		return m_s;
	}

	public String getM_n() {
		return m_n;
	}

	public void setInfo() {
		this.info = "[ " + name + " ] " + desc;
	}
	public String getInfo() {
		return info;
	}
	public String getMapId() {
		return mapId;
	}

	public String getName() {
		return name;
	}

	public String getDesc() {
		return desc;
	}

	public int getOpenStory() {
		return openStory;
	}


}
