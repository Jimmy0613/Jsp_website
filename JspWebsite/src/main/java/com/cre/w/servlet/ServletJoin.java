package com.cre.w.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

import com.cre.w.sys.Member;

@WebServlet("/ServletJoin")
public class ServletJoin extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String pwCheck = request.getParameter("pwcheck");
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String location = request.getParameter("location");
		if (location == null) {
			location = "../index.jsp";
		}
		Member member = new Member();

		String alert = member.joinAlert(id, pw, pwCheck, name, email);
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();
		if (alert.equals("")) {
			member.newMember(id, pw, name, email);
			out.println("<script>alert('가입 완료!');</script>");
			out.println("<script>location.href='" + location + "'</script>");
			out.close();
		} else {
			out.println("<script>alert('가입 실패.." + alert + "');</script>");
			out.println("<script>location.href='../join.jsp'</script>");
			out.close();
		}
	}
}
