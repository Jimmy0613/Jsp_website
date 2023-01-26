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

@WebServlet("/ServletDelReply")
public class ServletDelReply extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String reNum = request.getParameter("reNum");
		String postNum = request.getParameter("postNum");
		String currentPage = request.getParameter("page");
		String category = request.getParameter("category");
		Board board = new Board();
		Member member = new Member();
		PostDTO post = board.selectPost(postNum);
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		MemberDTO writer = member.getMember(post.getWr_id());
		if (!writer.getId().equals(loginMember.getId())) {
			loginMember.setHeart(loginMember.getHeart() - 1);
		}
		loginMember.setRCount(loginMember.getRCount() - 1);
		member.memberUpdate(loginMember);
		session.setAttribute("loginMember", loginMember);
		board.deleteReply(reNum);
		board.replyCount(postNum, "-1");
		PrintWriter out = response.getWriter();
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		out.println("<script>alert('삭제되었습니다.');</script>");
		out.println("<script>location.href='read.jsp?postNum=" + postNum + "&page=" + currentPage + "&category=" + category + "'</script>");
		out.close();
	}
}
