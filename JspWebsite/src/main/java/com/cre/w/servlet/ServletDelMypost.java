package com.cre.w.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;

import com.cre.w.dto.MemberDTO;
import com.cre.w.sys.Board;
import com.cre.w.sys.Member;

@WebServlet("/ServletDelMypost")
public class ServletDelMypost extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String[] delList = (String[]) request.getParameterValues("delmypost");
		Board board = new Board();
		Member member = new Member();
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		for (String s : delList) {
			board.delete(s);
			loginMember.setHeart(loginMember.getHeart() - 3);
			loginMember.setPCount(loginMember.getPCount() - 1);
			member.memberUpdate(loginMember);
			session.setAttribute("loginMember", loginMember);
		}
		PrintWriter out = response.getWriter();
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		out.println("<script>alert('삭제되었습니다.')</script>");
		out.println("<script>location.href='mypage.jsp'</script>");
		out.close();

	}
}
