package com.cre.w.controller;

import java.io.IOException;
import java.io.PrintWriter;

import com.cre.w.Member;
import com.cre.w.dao.RpsDAO;
import com.cre.w.dto.MemberDTO;
import com.cre.w.dto.RpsDTO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/member/*")
public class MemberCntrler extends HttpServlet {
	Member member = new Member();
	RpsDAO rps = new RpsDAO();
	HttpSession session;
	PrintWriter out;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		session = request.getSession();
		out = response.getWriter();
		String path = request.getPathInfo();

		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		String location;
		location = request.getParameter("location");
		if (location == null) {
			location = "/index.jsp";
		}
		if (path != null) {
			switch (path) {
			case "/join":
				String alertJoin = member.joinAlert(request.getParameter("id"), request.getParameter("pw"),
						request.getParameter("pwcheck"), request.getParameter("name"), request.getParameter("email"));
				if (alertJoin.equals("")) {
					member.newMember(request.getParameter("id"), request.getParameter("pw"),
							request.getParameter("name"), request.getParameter("email"));
					out.println("<script>alert('가입 완료!');</script>");
					out.println("<script>location.href='" + location + "'</script>");
					return;
				} else {
					out.println("<script>alert('가입 실패.." + alertJoin + "');</script>");
					out.println("<script>location.href='/join.jsp'</script>");
					return;
				}
			case "/login":
				String alertLogin = member.loginAlert(request.getParameter("id"), request.getParameter("pw"));
				MemberDTO login = member.getMember(request.getParameter("id"));
				if (alertLogin.equals("")) {
					session.setAttribute("loginMember", login);
					out.println("<script>alert('" + login.getId() + "님 안녕하세요!');</script>");
					out.println("<script>location.href='" + location + "'</script>");
					return;
				} else {
					out.println("<script>alert('로그인 실패.. " + alertLogin + "');</script>");
					out.println("<script>location.href='" + location + "'</script>");
					return;
				}
			case "/logout":
				session.removeAttribute("loginMember");
				response.sendRedirect(location);
				return;
			case "/rps":
				String input = request.getParameter("input");
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
				request.setAttribute("loginMember", loginMember);
				RpsDTO rpsDto = new RpsDTO(loginMember.getId(), result);
				rps.update(rpsDto);
				out.print("<script>alert('" + alert + "')</script>");
				out.print("<script>location.href='/index.jsp'</script>");
				return;
			case "/myemail":
				String email = request.getParameter("email");
				if (member.isEmail(email)) {
					out.println("<script>alert('이미 등록된 이메일입니다.')</script>");
					out.println("<script>location.href='/mypage.jsp?mode=myemail'</script>");
					return;
				} else if (loginMember.getEmail().equals("")) {
					loginMember.setEmail(email);
					member.memberUpdate(loginMember);
					session.setAttribute("loginMember", loginMember);
					out.println("<script>alert('등록되었습니다.')</script>");
					out.println("<script>location.href='/mypage.jsp'</script>");
					return;
				} else if (email.equals(loginMember.getEmail())) {
					out.println("<script>alert('기존과 동일한 이메일입니다.')</script>");
					out.println("<script>location.href='/mypage.jsp?mode=myemail'</script>");
					return;
				} else {
					loginMember.setEmail(email);
					member.memberUpdate(loginMember);
					session.setAttribute("loginMember", loginMember);
					out.println("<script>alert('변경되었습니다.')</script>");
					out.println("<script>location.href='/mypage.jsp'</script>");
					return;
				}
			}
		}
		out.close();

	}

}
