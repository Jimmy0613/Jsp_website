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
import com.cre.w.dto.PostDTO;
import com.cre.w.sys.Board;
import com.cre.w.sys.Member;

@WebServlet("/ServletDelete")
public class ServletDelete extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String postNum = request.getParameter("postNum");
		String category = request.getParameter("category");
		Board board = new Board();
		Member member = new Member();
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		PostDTO delPost = board.selectPost(postNum);
		loginMember.setHeart(loginMember.getHeart() - delPost.getHeart());
		loginMember.setHeart(loginMember.getHeart() - 3);
		loginMember.setPCount(loginMember.getPCount() - 1);
		member.memberUpdate(loginMember);
		session.setAttribute("loginMember", loginMember);
		board.delete(postNum);
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<script>alert('삭제되었습니다.');</script>");
		out.println("<script>location.href='board.jsp?category=" + category + "'</script>");
		out.close();

	}
}
