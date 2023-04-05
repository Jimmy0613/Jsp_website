package com.cre.w.dao;

import java.util.ArrayList;

import com.cre.w.db.Db;
import com.cre.w.dto.UserDTO;
import com.cre.w.dto.PostDTO;
import com.cre.w.dto.ReplyDTO;

public class BoardDAO extends DAO {

	public void update(String sql) {
		try {
			connection();
			st.executeUpdate(sql);
			close();
		} catch (Exception e) {
		}
	}

	public PostDTO selectPost(String postNum) {
		PostDTO dto = null;
		String sql = String.format("SELECT * FROM %s where post_num = %s;", Db.TABLE_BOARD, postNum);
		try {
			connection();
			result = st.executeQuery(sql);
			while (result.next()) {
				int pNum = result.getInt("post_num");
				String category = result.getString("category");
				String writer_id = result.getString("writer_id");
				String writer = result.getString("writer");
				String title = result.getString("title");
				String content = result.getString("content");
				String date = result.getString("post_date");
				int reply = result.getInt("reply");
				int views = result.getInt("views");
				int heart = result.getInt("heart");

				dto = new PostDTO(pNum, category, writer_id, writer, title, content, date, reply, views, heart);
			}
			close();
		} catch (Exception e) {
		}
		return dto;
	}

	public ArrayList<PostDTO> selectList(String sql) {
		ArrayList<PostDTO> dtos = new ArrayList<>();
		try {
			connection();
			result = st.executeQuery(sql);
			while (result.next()) {
				int pNum = result.getInt("post_num");
				String category = result.getString("category");
				String writer_id = result.getString("writer_id");
				String writer = result.getString("writer");
				String title = result.getString("title");
				String content = result.getString("content");
				String date = result.getString("post_date");
				int reply = result.getInt("reply");
				int views = result.getInt("views");
				int heart = result.getInt("heart");

				PostDTO dto = new PostDTO(pNum, category, writer_id, writer, title, content, date, reply, views, heart);
				dtos.add(dto);
			}
			close();
		} catch (Exception e) {
		}
		return dtos;
	}


	public int getCount(String where) {
		int postCount = 0;
		
		String sql = String.format("SELECT count(*) FROM %s %s;", Db.TABLE_BOARD, where);
		try {
			connection();
			result = st.executeQuery(sql);
			while (result.next()) {
				postCount = result.getInt("count(*)");
			}
			close();
		} catch (Exception e) {
		}
		return postCount;
	}
	
	public int getMypostCount(UserDTO loginUser) {
		int postCount = 0;
		String sql = String.format("SELECT count(*) FROM %s where writer_id='%s';", Db.TABLE_BOARD, loginUser.getId());
		try {
			connection();
			result = st.executeQuery(sql);
			while (result.next()) {
				postCount = result.getInt("count(*)");
			}
			close();
		} catch (Exception e) {
		}
		return postCount;
	}
	
	public int getMyreplyCount(UserDTO loginUser) {
		int postCount = 0;
		String sql = String.format("SELECT count(*) FROM %s where writer_id='%s';", Db.TABLE_REPLY, loginUser.getId());
		try {
			connection();
			result = st.executeQuery(sql);
			while (result.next()) {
				postCount = result.getInt("count(*)");
			}
			close();
		} catch (Exception e) {
		}
		return postCount;
	}


	public ArrayList<ReplyDTO> selectReply(String sql) {
		ArrayList<ReplyDTO> dtos = new ArrayList<>();
		try {
			connection();
			result = st.executeQuery(sql);
			while (result.next()) {
				int pNum = result.getInt("post_num");
				int rNum = result.getInt("reply_num");
				String writer = result.getString("writer");
				String content = result.getString("content");
				String date = result.getString("reply_date");

				ReplyDTO dto = new ReplyDTO(pNum, rNum, writer, content, date);

				dtos.add(dto);
			}
			close();
		} catch (Exception e) {
		}
		return dtos;

	}

}
