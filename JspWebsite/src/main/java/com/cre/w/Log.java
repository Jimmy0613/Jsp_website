package com.cre.w;

import com.cre.w.dao.LogDAO;
import com.cre.w.db.Db;

public class Log extends LogDAO {
	public static int turnCount;

	public void load() {
		turnCount = 0;
		String sql = "DROP TABLE LOG;";
		update(sql);
		sql = "create table log(log_num int primary key auto_increment, log char(255), class char(20));";
		update(sql);
	}

	public void send(String log, String cl) {
		String sql = String.format("INSERT INTO %s(LOG, CLASS) VALUES('%s','%s');", Db.TABLE_LOG, log, cl);
		update(sql);
	}

}
