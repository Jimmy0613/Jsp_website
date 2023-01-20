package com.cre.w.dao;

import java.util.ArrayList;

import com.cre.w.db.Db;
import com.cre.w.dto.StoryDTO;

public class StoryDAO extends DAO {
	
	public ArrayList<StoryDTO> select() {
		ArrayList<StoryDTO> dtos = new ArrayList<>();

		String sql = String.format("SELECT * FROM %s ORDER BY ST_NUM;", Db.TABLE_STORY);

		try {
			connection();
			result = st.executeQuery(sql);
			while (result.next()) {
				int st_num = result.getInt("ST_NUM");
				String title = result.getString("ST_TITLE");
				String desc = result.getString("ST_DESC");
				String map_open = result.getString("MAP_OPEN");

				StoryDTO dto = new StoryDTO(st_num, title, desc, map_open);

				dtos.add(dto);
			}
			close();
		} catch (Exception e) {
		}

		return dtos;

	}
}
