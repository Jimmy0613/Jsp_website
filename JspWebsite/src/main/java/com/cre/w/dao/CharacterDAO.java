package com.cre.w.dao;

import com.cre.w.db.Db;
import com.cre.w.dto.CharacterDTO;

public class CharacterDAO extends DAO {
	
	public boolean is(String obj, String input) {
		boolean is = false;
		String sql = String.format("select count(*) from %s where %s = '%s';", Db.TABLE_CHARACTER, obj, input);
		try {
			connection();
			result = st.executeQuery(sql);
			while(result.next()) {
				int count = result.getInt("count(*)");
				if(count>0) {
					is = true;
				}
			}
			close();
		} catch (Exception e) {
		} 
		return is;

	}
	public CharacterDTO getCharacter(String c_name) {
		CharacterDTO dto = null;
		String sql = String.format("SELECT * FROM %s where name='%s';", Db.TABLE_CHARACTER,c_name);
		try {
			connection();
			result = st.executeQuery(sql);
			while (result.next()) {
				String user_id = result.getString("USER_ID");
				String name = result.getString("NAME");
				String location = result.getString("LOCATION");
				int story = result.getInt("STORY");
				int level = result.getInt("LEVEL");
				int exp = result.getInt("EXP");
				int max_exp = result.getInt("MAX_EXP");
				int power = result.getInt("POWER");
				int max_power = result.getInt("MAX_POWER");
				int coin = result.getInt("COIN");

				dto = new CharacterDTO(user_id, name, location, story, level, exp, max_exp, power,
						max_power, coin);
			}
			close();
		} catch (Exception e) {
		} 
		return dto;
	}
	
	public void update(String sql) {
		try {
			connection();
			st.executeUpdate(sql);
			close();
		} catch (Exception e) {
		} 
	}

	

}
