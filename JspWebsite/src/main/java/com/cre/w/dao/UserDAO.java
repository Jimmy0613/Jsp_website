package com.cre.w.dao;


import com.cre.w.db.Db;
import com.cre.w.dto.UserDTO;

public class UserDAO extends DAO {
	
	public boolean is(String obj, String input) {
		boolean is = false;
		String sql = String.format("select count(*) from %s where %s = '%s';", Db.TABLE_USER, obj, input);
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

	public UserDTO getUser(String id) {
		UserDTO member = null;
		String sql = String.format("select * from %s where user_id = '%s';", Db.TABLE_USER,id);
		try {
			connection();
			result = st.executeQuery(sql);
			while (result.next()) {
				String pw = result.getString("password");
				String name = result.getString("user_name");
				String email = result.getString("email");
				String jDate = result.getString("join_date");
				int pCount = result.getInt("post_count");
				int rCount = result.getInt("reply_count");
				int heart = result.getInt("heart_count");
				String character1 = result.getString("character1");
				String character2 = result.getString("character2");

				member = new UserDTO(id, pw, name, email, jDate, pCount, rCount, heart, character1, character2);
			}
			close();
		} catch (Exception e) {
		} 

		return member;
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
