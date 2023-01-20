package com.cre.w.sys;

import com.cre.w.dao.BoardDAO;
import com.cre.w.dto.MemberDTO;

public class Page extends BoardDAO {
	public final static int PER_PAGE = 10;
	public final static int PAGE_BLOCK = 5;
	Board board = new Board();
	
	public int getTotalPage(String where) {
		int postCount = getCount(where);
		int totalPage = 0;
		if (postCount % PER_PAGE == 0) {
			totalPage = postCount / PER_PAGE;
		} else {
			totalPage = (postCount / PER_PAGE) + 1;
		}
		return totalPage;
	}
	
	public int getMypostPage(MemberDTO loginMember) {
		int postCount = getMypostCount(loginMember);
		int totalPage = 0;
		if (postCount % PER_PAGE == 0) {
			totalPage = postCount / PER_PAGE;
		} else {
			totalPage = (postCount / PER_PAGE) + 1;
		}
		return totalPage;
	}
	
	public int getMyreplyPage(MemberDTO loginMember) {
		int postCount = getMyreplyCount(loginMember);
		int totalPage = 0;
		if (postCount % PER_PAGE == 0) {
			totalPage = postCount / PER_PAGE;
		} else {
			totalPage = (postCount / PER_PAGE) + 1;
		}
		return totalPage;
	}
	public static boolean isInteger(String str) {
		try {
		Integer.parseInt(str);
		return true;
		} catch (NumberFormatException e){
		return false;
		}
	}
}
