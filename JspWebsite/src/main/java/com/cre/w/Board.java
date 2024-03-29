package com.cre.w;

import java.util.ArrayList;

import com.cre.w.dao.BoardDAO;
import com.cre.w.db.Db;
import com.cre.w.dto.PostDTO;
import com.cre.w.dto.ReplyDTO;

public class Board extends BoardDAO {
	public String switchCategory(String category) {
		String cg = "자유";
		switch (category) {
		case "general":
			break;
		case "popular":
			cg = "인기글";
			break;
		case "anonym":
			cg = "익명";
			break;
		case "notice":
			cg = "공지";
			break;
		case "report":
			cg = "신고";
			break;
		case "all":
			cg = "전체";
			break;
		}
		return cg;
	}

	public ArrayList<PostDTO> homeNotice() {
		String sql = String.format("select * from %s where category='notice' limit 0, 3;", Db.TABLE_BOARD);
		return selectList(sql);
	}

	public ArrayList<PostDTO> homePopular() {
		String sql = String.format(
				"select * from %s where(category = 'general' or category = 'anonym') order by heart desc, views desc limit 0, 5;",
				Db.TABLE_BOARD);
		return selectList(sql);
	}

	public ArrayList<PostDTO> getList(String category, int page) {
		ArrayList<PostDTO> arr = null;
		switch (category) {
		case "popular":
			arr = popular();
			break;
		default:
			arr = list(category, page);
			break;
		}
		return arr;
	}

	public ArrayList<PostDTO> popular() {
		String sql = String.format(
				"SELECT * FROM %s where(category = 'general' or category = 'anonym') order by heart desc, views desc limit 0, 10;",
				Db.TABLE_BOARD);
		return selectList(sql);
	}

	public ArrayList<PostDTO> list(String cg, int currentPage) {
		String sql = String.format("SELECT * FROM %s where category='%s' order by post_num desc limit %d, %d;",
				Db.TABLE_BOARD, cg, (currentPage - 1) * Page.PER_PAGE, Page.PER_PAGE);
		return selectList(sql);
	}

	public ArrayList<PostDTO> searchList(String where, int currentPage) {
		String sql = String.format("select * from %s %s order by post_num desc limit %d, %d;", Db.TABLE_BOARD, where,
				(currentPage - 1) * Page.PER_PAGE, Page.PER_PAGE);
		return selectList(sql);
	}

	public ArrayList<PostDTO> mypost(String myId, int currentPage) {
		String sql = String.format("SELECT * FROM %s where writer_id='%s' order by post_num desc limit %d, %d;",
				Db.TABLE_BOARD, myId, (currentPage - 1) * Page.PER_PAGE, Page.PER_PAGE);
		return selectList(sql);
	}

	public ArrayList<ReplyDTO> myreply(String myId, int currentPage) {
		String sql = String.format("SELECT * FROM %s where re_writer_id='%s' order by reply_num desc limit %d, %d;",
				Db.TABLE_REPLY, myId, (currentPage - 1) * Page.PER_PAGE, Page.PER_PAGE);
		return selectReply(sql);
	}

	public ArrayList<ReplyDTO> reply(String postNum) {
		String sql = String.format("select * from %s where post_num = %s;", Db.TABLE_REPLY, postNum);
		return selectReply(sql);
	}

	public void edit(String postNum, String title, String content) {
		String sql = String.format("update %s set title='%s', content='%s' where post_num=%s", Db.TABLE_BOARD, title,
				content, postNum);
		update(sql);
	}

	public void delete(String postNum) {
		String sql = "delete from board where post_num = " + postNum + ";";
		update(sql);
	}

	public void deleteReply(String reNum) {
		String sql = "delete from reply where reply_num = " + reNum + ";";
		update(sql);
	}

	public void view(String postNum) {
		String sql = "update board set views = views + 1 where post_num=" + postNum;
		update(sql);
	}

	public void heart(String postNum) {
		String sql = "update board set heart=heart+1 where post_num=" + postNum;
		update(sql);
	}

	public void postCount(String writer_id, String value) {
		String sql = String.format("update %s set post_count = post_count %s where writer_id=%s", Db.TABLE_BOARD, value, writer_id);
		update(sql);
	}
	
	public void replyCount(String postNum, String value) {
		String sql = String.format("update %s set reply = reply %s where post_num=%s", Db.TABLE_BOARD, value, postNum);
		update(sql);
	}

	public void newPost(String writer_id, String writer, String title, String content, String cg) {
		String sql = String.format(
				"insert into %s (writer_id, writer, title, content, category) values('%s', '%s','%s','%s','%s')",
				Db.TABLE_BOARD, writer_id, writer, title, content, cg);
		update(sql);
	}

	public void newReply(String writer_id, String writer, String content, String postNum) {
		String sql = String.format("insert into %s(post_num,re_writer_id,writer,content) values(%s,'%s','%s','%s');",
				Db.TABLE_REPLY, postNum, writer_id, writer, content);
		update(sql);
	}
}
