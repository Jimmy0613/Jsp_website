package com.cre.w.dao;


import com.cre.w.db.Db;
import com.cre.w.dto.MemberDTO;

public class MemberDAO extends DAO {
	
	public boolean is(String obj, String input) {
		boolean is = false;
		String sql = String.format("select count(*) from %s where %s = '%s';", Db.TABLE_MEMBER, obj, input);
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

	public MemberDTO getMember(String id) {
		MemberDTO member = null;
		String sql = String.format("select * from %s where member_id = '%s';", Db.TABLE_MEMBER,id);
		try {
			connection();
			result = st.executeQuery(sql);
			while (result.next()) {
				String pw = result.getString("password");
				String name = result.getString("member_name");
				String email = result.getString("email");
				String jDate = result.getString("join_date");
				int pCount = result.getInt("post_count");
				int rCount = result.getInt("reply_count");
				int heart = result.getInt("heart");
				String character1 = result.getString("character1");
				String character2 = result.getString("character2");

				member = new MemberDTO(id, pw, name, email, jDate, pCount, rCount, heart, character1, character2);
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
