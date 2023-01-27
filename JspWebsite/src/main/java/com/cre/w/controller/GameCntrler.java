package com.cre.w.controller;

import java.io.IOException;
import java.io.PrintWriter;

import com.cre.w.Charac;
import com.cre.w.Member;
import com.cre.w.dto.MemberDTO;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/game/*")
public class GameCntrler extends HttpServlet {
	Member member = new Member();
	HttpSession session;
	PrintWriter out;

	String forward;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		session = request.getSession();
		out = response.getWriter();
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		String path = request.getPathInfo();

		if (path != null) {
			switch (path) {
			case "/newChar":
				Charac character = new Charac();
				String loginC1 = loginMember.getCharacter1();
				String input_name = request.getParameter("c_name");
				String alertCh = character.newAlert(input_name);
				if (alertCh.equals("")) {
					character.newCharacter(input_name, loginMember.getId());
					if (loginC1.equals("x")) {
						loginMember.setCharacter1(input_name);
						member.memberUpdate(loginMember);
					} else {
						loginMember.setCharacter2(input_name);
						member.memberUpdate(loginMember);
					}
					session.setAttribute("loginMember", loginMember);
					out.println("<script>location.href='/character.jsp'</script>");
					return;
				} else {
					out.println("<script>alert('사용할 수 없는 이름입니다. " + alertCh + "')</script>");
					out.println("<script>location.href='/newChar.jsp'</script>");
					return;
				}
			}
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher(forward);
		dispatcher.forward(request, response);
		out.close();

	}

}
