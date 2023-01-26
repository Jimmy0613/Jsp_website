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
import com.cre.w.sys.Charac;
import com.cre.w.sys.Member;

@WebServlet("/ServletNewChar")
public class ServletNewChar extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Member member = new Member();
		Charac character = new Charac();
		HttpSession session = request.getSession();
		MemberDTO loginMember = (MemberDTO)session.getAttribute("loginMember");
		String loginC1 = loginMember.getCharacter1();
		String input_name = request.getParameter("c_name");
		String alert = character.newAlert(input_name);
		
		PrintWriter out = response.getWriter();
		if (alert.equals("")) {
			character.newCharacter(input_name, loginMember.getId());
			if (loginC1.equals("x")) {
				member.updateCharacter("CHARACTER1", input_name, loginMember.getId());
				loginMember.setCharacter1(input_name);
				member.memberUpdate(loginMember);
			} else {
				member.updateCharacter("CHARACTER2", input_name, loginMember.getId());
				loginMember.setCharacter2(input_name);
				member.memberUpdate(loginMember);
			}
			out.println("<script>location.href='character.jsp'</script>");
			out.close();
		} else {
			out.println("<script>alert('사용할 수 없는 이름입니다. " + alert + "')</script>");
			out.println("<script>location.href='newChar.jsp'</script>");
			out.close();
		}
	}
}
