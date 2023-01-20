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

@WebServlet("/ServletEmail")
public class ServletEmail extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String email = request.getParameter("email");
		MemberDTO mem = (MemberDTO) session.getAttribute("loginMember");
		Member mee = new Member();
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		if (mem.getEmail().equals("")) {
			if (mee.isEmail(email)) {
				out.println("<script>alert('이미 등록된 이메일입니다.')</script>");
				out.println("<script>location.href='mypage.jsp?mode=myemail'</script>");
				out.close();
			} else {
				mem.setEmail(email);
				mee.memberUpdate(mem);
				out.println("<script>alert('등록되었습니다.')</script>");
				out.println("<script>location.href='mypage.jsp'</script>");
				out.close();
			}
		} else {
			if (email.equals(mem.getEmail())) {
				out.println("<script>alert('기존과 동일한 이메일입니다.')</script>");
				out.println("<script>location.href='mypage.jsp?mode=myemail'</script>");
				out.close();
			} else if (mee.isEmail(email)) {
				out.println("<script>alert('이미 등록된 이메일입니다.')</script>");
				out.println("<script>location.href='mypage.jsp?mode=myemail'</script>");
				out.close();
			} else {
				mem.setEmail(email);
				mee.memberUpdate(mem);
				out.println("<script>alert('변경되었습니다.')</script>");
				out.println("<script>location.href='../mypage.jsp'</script>");
				out.close();
			}

		}
	}
}
