package com.cre.w.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.cre.w.dto.MemberDTO;
import com.cre.w.dto.PostDTO;
import com.cre.w.sys.Board;
import com.cre.w.sys.Member;

@WebServlet("/ServletReply")
public class ServletReply extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		Board board = new Board();
		Member member = new Member();
		String reply = request.getParameter("reply");
		String postNum = request.getParameter("postNum");
		String category = request.getParameter("category");
		String currentPage = request.getParameter("page");
		PostDTO post = board.selectPost(postNum);
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		MemberDTO writer = member.getMember(post.getWr_id());
		if (!writer.getId().equals(loginMember.getId())) {
			loginMember.setHeart(loginMember.getHeart() + 1);
		}
		loginMember.setRCount(loginMember.getRCount() + 1);
		member.memberUpdate(loginMember);
		session.setAttribute("loginMember", loginMember);
		board.newReply(loginMember.getId(), loginMember.getName(), reply, postNum);
		board.replyCount(postNum, "+1");
		response.sendRedirect("read.jsp?category=" + category + "&postNum=" + postNum + "&page=" + currentPage);
	}
}
