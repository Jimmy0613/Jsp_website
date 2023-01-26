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
import com.cre.w.sys.Member;

@WebServlet("/ServletLogin")
public class ServletLogin extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		Member member = new Member();
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String location = request.getParameter("location");
		if (location == null) {
			location = "../index.jsp";
		}

		String alert = member.loginAlert(id, pw);
		MemberDTO loginMember = member.getMember(id);
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		if (alert.equals("")) {
			session.setAttribute("loginMember", loginMember);
			out.println("<script>alert('" + id + "님 안녕하세요!');</script>");
			out.println("<script>location.href='" + location + "'</script>");
			out.close();
		} else {
			out.println("<script>alert('로그인 실패.. " + alert + "');</script>");
			out.println("<script>location.href='../login.jsp'</script>");
			out.close();
		}
	}
}
