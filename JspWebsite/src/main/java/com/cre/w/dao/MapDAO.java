package com.cre.w.dao;

import com.cre.w.Charac;
import com.cre.w.db.Db;
import com.cre.w.dto.MapDTO;

public class MapDAO extends DAO {

	LogDAO log = new LogDAO();
	Charac ch = new com.cre.w.Charac();

	public MapDTO getMap(String mapId) {
		MapDTO dto = null;
		String sql = String.format("select * from %s where map_id = '%s';", Db.TABLE_MAP, mapId);
		try {
			connection();
			result = st.executeQuery(sql);
			while (result.next()) {
				String map_id = result.getString("MAP_ID");
				String m_name = result.getString("M_NAME");
				String m_desc = result.getString("M_DESC");
				int open_story = result.getInt("OPEN_STORY");
				String m_east = result.getString("M_E");
				String m_west = result.getString("M_W");
				String m_south = result.getString("M_S");
				String m_north = result.getString("M_N");

				dto = new MapDTO(map_id, m_name, m_desc, open_story, m_east, m_west, m_south, m_north);
			}
			close();
		} catch (Exception e) {
		}
		return dto;
	}

}
