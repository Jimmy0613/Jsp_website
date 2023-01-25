package com.cre.w.dao;

import java.text.SimpleDateFormat;
import java.util.Date;

import com.cre.w.db.Db;
import com.cre.w.dto.RpsDTO;

public class RpsDAO extends DAO {
	Date date = new Date();
	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	private String today = format.format(date);

	public int getCountToday(String id) {
		String sql = String.format("select count(*) from %s where date='%s' and member_id='%s'", Db.TABLE_RPS, today,
				id);
		int count = 0;
		try {
			connection();
			result = st.executeQuery(sql);
			while (result.next()) {
				count = result.getInt("count(*)");
			}
			close();
		} catch (Exception e) {
		}

		return count;
	}

	public String rps(String input, String com) {
		String result = "draw";
		switch (input) {
		case "s":
			if (com.equals("r")) {
				result = "lose";
			} else if (com.equals("p")) {
				result = "win";
			}
			break;

		case "r":
			if (com.equals("p")) {
				result = "lose";
			} else if (com.equals("s")) {
				result = "win";
			}
			break;

		case "p":
			if (com.equals("s")) {
				result = "lose";
			} else if (com.equals("r")) {
				result = "win";
			}
			break;
		}

		return result;
	}

	public String switchRps(String str) {
		String s = "";
		switch (str) {
		case "r":
			s = "바위";
			break;
		case "p":
			s = "보";
			break;
		case "s":
			s = "가위";
			break;
		}
		return s;
	}

	public void update(RpsDTO dto) {
		String sql = String.format("insert into %s(member_id,result) values('%s','%s');", Db.TABLE_RPS,
				dto.getMember_id(), dto.getResult());
		try {
			connection();
			st.executeUpdate(sql);
			close();
		} catch (Exception e) {
		}
	}
}
