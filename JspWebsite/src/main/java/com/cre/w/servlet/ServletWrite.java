package com.cre.w.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.cre.w.dto.MemberDTO;
import com.cre.w.sys.Board;
import com.cre.w.sys.Member;

@WebServlet("/ServletWrite")
public class ServletWrite extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		Board board = new Board();
		Member member = new Member();
		String content = request.getParameter("content");
		content = content.replace("\r\n", "<br>");
		String category = request.getParameter("category");
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		loginMember.setHeart(loginMember.getHeart() + 3);
		loginMember.setPCount(loginMember.getPCount() + 1);
		member.memberUpdate(loginMember);
		session.setAttribute("loginMember", loginMember);
		board.newPost(loginMember.getId(), loginMember.getName(), request.getParameter("title"), content, category);
		response.sendRedirect("board.jsp?category=" + category);
	}
}
