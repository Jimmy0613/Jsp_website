package com.cre.w.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.cre.w.db.Db;

public class DAO {
	Connection con = null;
	Statement st = null;
	ResultSet result = null;

	DAO() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (Exception e) {
		}
	}

	public void connection() {
		try {
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + Db.DATABASE, "root", "0000");
			st = con.createStatement();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void close() {
		try {
			if (con != null)
				con.close();
			if (st != null)
				st.close();
			if (result != null)
				result.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
