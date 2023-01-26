package com.cre.w.servlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import com.cre.w.dto.MemberDTO;
import com.cre.w.dto.PostDTO;
import com.cre.w.dto.ReplyDTO;
import com.cre.w.sys.Board;
import com.cre.w.sys.Member;
import com.cre.w.sys.Page;

@WebServlet("/web/*")
public class Controller extends HttpServlet {
	Board board = new Board();
	Member member = new Member();
	Page pp = new Page();
	String forward;

	public Controller() {
		super();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		String path = request.getPathInfo();
		String category = request.getParameter("category");
		if (category == null) {
			category = "popular";
		}
		String cgk = board.switchCategory(category);
		String p = request.getParameter("page");
		int page = 1;
		if (p != null) {
			page = Integer.parseInt(p);
		}
		request.setAttribute("page", page);
		request.setAttribute("category", category);
		request.setAttribute("cgKorean", cgk);

		String postNum = request.getParameter("postNum");
		if (postNum != null) {
			request.setAttribute("postNum", postNum);
		}
		String location = request.getParameter("location");
		if (location == null) {
			location = "/index.jsp";
		}
		ArrayList<PostDTO> list;
		ArrayList<ReplyDTO> reply;
		PostDTO post;
		int totalPage;
		int totalPb;
		int currentPb;

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
			case "/write":
				String conWrite = request.getParameter("content");
				conWrite = conWrite.replace("\r\n", "<br>");
				loginMember.setHeart(loginMember.getHeart() + 3);
				loginMember.setPCount(loginMember.getPCount() + 1);
				member.memberUpdate(loginMember);
				session.setAttribute("loginMember", loginMember);
				board.newPost(loginMember.getId(), loginMember.getName(), request.getParameter("title"), conWrite,
						category);
				response.sendRedirect("/web/board?category=" + category + "&page=" + page);
				return;
			case "/reply":
				post = board.selectPost(postNum);
				if (!post.getWr_id().equals(loginMember.getId())) {
					loginMember.setHeart(loginMember.getHeart() + 1);
				}
				loginMember.setRCount(loginMember.getRCount() + 1);
				member.memberUpdate(loginMember);
				session.setAttribute("loginMember", loginMember);
				board.newReply(loginMember.getId(), loginMember.getName(), request.getParameter("conReply"), postNum);
				board.replyCount(postNum, "+1");
				response.sendRedirect("/web/read?category=" + category + "&postNum=" + postNum + "&page=" + page);
				return;
			case "/board":
				list = board.getList(category, page);
				request.setAttribute("list", list);
				String where = "where category = '" + category + "'";
				totalPage = pp.getTotalPage(where);
				totalPb = 1;
				currentPb = 1;
				if (page % Page.PAGE_BLOCK == 0) {
					currentPb = page / Page.PAGE_BLOCK;
					totalPb = totalPage / Page.PAGE_BLOCK;
				} else {
					currentPb = page / Page.PAGE_BLOCK + 1;
					totalPb = page / Page.PAGE_BLOCK;
				}
				request.setAttribute("totalPage", totalPage);
				request.setAttribute("totalPb", totalPb);
				request.setAttribute("currentPb", currentPb);
				forward = "/board.jsp";
				break;
			case "/mypage":
				String mode = request.getParameter("mode");
				if (mode == null) {
					mode = "mypost";
				}
				request.setAttribute("mode", mode);
				switch (mode) {
				case "mypost":
					list = board.mypost(loginMember.getId(), page);
					request.setAttribute("list", list);
					totalPage = pp.getMypostPage(loginMember);
					if (page % Page.PAGE_BLOCK == 0) {
						currentPb = page / Page.PAGE_BLOCK;
						totalPb = totalPage / Page.PAGE_BLOCK;
					} else {
						currentPb = page / Page.PAGE_BLOCK + 1;
						totalPb = page / Page.PAGE_BLOCK;
					}
					request.setAttribute("totalPage", totalPage);
					request.setAttribute("totalPb", totalPb);
					request.setAttribute("currentPb", currentPb);
					forward = "/mypage.jsp?mode=mypost";
					break;
				case "myreply":
					reply = board.myreply(loginMember.getId(), page);
					request.setAttribute("reply", reply);
					totalPage = pp.getMyreplyPage(loginMember);
					if (page % Page.PAGE_BLOCK == 0) {
						currentPb = page / Page.PAGE_BLOCK;
						totalPb = totalPage / Page.PAGE_BLOCK;
					} else {
						currentPb = page / Page.PAGE_BLOCK + 1;
						totalPb = page / Page.PAGE_BLOCK;
					}
					request.setAttribute("totalPage", totalPage);
					request.setAttribute("totalPb", totalPb);
					request.setAttribute("currentPb", currentPb);
					forward = "/mypage.jsp?mode=myreply";
					break;
				}
				break;
			case "/read":
				board.view(postNum);
				post = board.selectPost(postNum);
				request.setAttribute("post", post);
				reply = board.reply(postNum);
				request.setAttribute("reply", reply);
				forward = "/read.jsp";
				break;
			case "/edit":
				String conEdit = request.getParameter("content");
				conEdit = conEdit.replace("\r\n", "<br>");
				board.edit(postNum, request.getParameter("title"), conEdit);
				response.sendRedirect("/web/read?category=" + category + "&page=" + page + "&postNum=" + postNum);
				return;
			case "/heart":
				post = board.selectPost(postNum);
				if (loginMember.getHeart() < 1) {
					out.println("<script>alert('하트가 부족합니다..')</script>");
					out.println("<script>location.href='/web/read?category=" + category + "&postNum=" + postNum
							+ "&page=" + page + "'</script>");
					return;
				} else {
					MemberDTO writer = member.getMember(post.getWr_id());
					if (writer != null) {
						if (loginMember.getId().equals(post.getWr_id())) {
							out.println("<script>alert('내가 쓴 글에는 할 수 없습니다.')</script>");
							out.println("<script>location.href='/web/read?category=" + category + "&postNum=" + postNum
									+ "&page=" + page + "'</script>");
							return;
						} else {
							board.heart(postNum);
							loginMember.setHeart(loginMember.getHeart() - 1);
							member.memberUpdate(loginMember);
							session.setAttribute("loginMember", loginMember);
							writer.setHeart(writer.getHeart() + 1);
							member.memberUpdate(writer);
							response.sendRedirect(
									"/web/read?category=" + category + "&postNum=" + postNum + "&page=" + page);
							return;
						}
					} else {
						out.println("<script>alert('작성자 탈퇴 등의 이유로 해당 글에는 할 수 없습니다.')</script>");
						out.println("<script>location.href='/web/read?category=" + category + "&postNum=" + postNum
								+ "&page=" + page + "'</script>");
						return;
					}
				}
			case "/delete":
				post = board.selectPost(postNum);
				loginMember.setHeart(loginMember.getHeart() - post.getHeart() - 3);
				loginMember.setPCount(loginMember.getPCount() - 1);
				member.memberUpdate(loginMember);
				session.setAttribute("loginMember", loginMember);
				board.delete(postNum);
				request.removeAttribute("postNum");
				response.sendRedirect("/web/board?category=" + category + "&page=" + page);
				return;
			case "/delReply":
				post = board.selectPost(postNum);
				if (!post.getWr_id().equals(loginMember.getId())) {
					loginMember.setHeart(loginMember.getHeart() - 1);
				}
				loginMember.setRCount(loginMember.getRCount() - 1);
				member.memberUpdate(loginMember);
				session.setAttribute("loginMember", loginMember);
				board.deleteReply(request.getParameter("reNum"));
				board.replyCount(postNum, "-1");
				response.sendRedirect("/web/read?category=" + category + "&postNum=" + postNum + "&page=" + page);
				return;
			}
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher(forward);
		dispatcher.forward(request, response);
		out.close();

	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
