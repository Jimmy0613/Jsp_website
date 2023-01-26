package com.cre.w.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;

import com.cre.w.dao.RpsDAO;
import com.cre.w.dto.MemberDTO;
import com.cre.w.dto.RpsDTO;
import com.cre.w.sys.Member;

@WebServlet("/ServletRps")
public class ServletRps extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		RpsDTO dto = null;
		Member member = new Member();
		String input = request.getParameter("input");
		RpsDAO rps = new RpsDAO();
		int random = (int) Math.floor(Math.random() * 3) + 1;
		String com = "r";
		switch (random) {
		case 1:
			com = "s";
			break;
		case 2:
			com = "p";
			break;
		case 3:
			com = "r";
			break;
		}
		String inputStr = rps.switchRps(input);
		String comStr = rps.switchRps(com);
		String alert = "나: " + inputStr + "\\n컴퓨터: " + comStr;
		String result = rps.rps(input, com);
		switch (result) {
		case "win":
			loginMember.setHeart(loginMember.getHeart() + 2);
			alert += "\\n우와! 이겼습니다!";
			break;
		case "draw":
			alert += "\\n앗! 비겼습니다~";
			break;
		case "lose":
			loginMember.setHeart(loginMember.getHeart() - 1);
			alert += "\\n으악! 졌습니다ㅠ";
			break;
		}
		member.memberUpdate(loginMember);
		dto = new RpsDTO(loginMember.getId(), result);
		rps.update(dto);
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();

		out.print("<script>alert('" + alert + "')</script>");
		out.print("<script>location.href='index.jsp'</script>");
		out.close();
	}
}
