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

@WebServlet("/ServletHeart")
public class ServletHeart extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		Board board = new Board();
		Member member = new Member();
		String postNum = request.getParameter("postNum");
		String category = request.getParameter("category");
		String currentPage = request.getParameter("page");
		PostDTO post = board.selectPost(postNum);
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		if (loginMember.getHeart() < 1) {
			out.println("<script>alert('하트가 부족합니다..')</script>");
			out.println("<script>location.href='read.jsp?category=" + category + "&postNum=" + postNum + "&page="
					+ currentPage + "'</script>");
			out.close();
		} else {
			MemberDTO writer = member.getMember(post.getWr_id());
			if (writer != null) {

				if (loginMember.getId().equals(writer.getId())) {
					out.println("<script>alert('내가 쓴 글에는 할 수 없습니다.')</script>");
					out.println("<script>location.href='read.jsp?category=" + category + "&postNum=" + postNum
							+ "&page=" + currentPage + "'</script>");
					out.close();
				} else {
					board.heart(postNum);
					loginMember.setHeart(loginMember.getHeart() - 1);
					member.memberUpdate(loginMember);
					writer.setHeart(writer.getHeart() + 1);
					member.memberUpdate(writer);
					session.setAttribute("loginMember", loginMember);
					response.sendRedirect(
							"read.jsp?category=" + category + "&postNum=" + postNum + "&page=" + currentPage);
				}
			} else {
				out.println("<script>alert('작성자 탈퇴 등의 이유로 해당 글에는 할 수 없습니다.')</script>");
				out.println("<script>location.href='read.jsp?category=" + category + "&postNum=" + postNum + "&page="
						+ currentPage + "'</script>");
				out.close();
			}
		}
	}
}
