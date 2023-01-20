package com.cre.w.dao;

import java.util.ArrayList;

import com.cre.w.db.Db;
import com.cre.w.dto.LogDTO;

public class LogDAO extends DAO {

	public ArrayList<com.cre.w.dto.LogDTO> select() {
		ArrayList<LogDTO> dtos = new ArrayList<>();
		String sql = String.format("SELECT * FROM %s", Db.TABLE_LOG);

		try {
			connection();
			result = st.executeQuery(sql);
			while (result.next()) {
				int log_num = result.getInt("LOG_NUM");
				String log = result.getString("LOG");
				String cls = result.getString("CLASS");

				LogDTO dto = new LogDTO(log_num, log, cls);
				dtos.add(dto);
			}
			close();
		} catch (Exception e) {
		}

		return dtos;

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
