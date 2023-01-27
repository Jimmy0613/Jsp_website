package com.cre.w.controller;

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

import com.cre.w.Board;
import com.cre.w.Member;
import com.cre.w.Page;
import com.cre.w.dto.MemberDTO;
import com.cre.w.dto.PostDTO;
import com.cre.w.dto.ReplyDTO;

@WebServlet("/board/*")
public class BoardCntrler extends HttpServlet {
	Board board = new Board();
	Member member = new Member();
	Page pp = new Page();
	HttpSession session;
	PrintWriter out;

	String forward;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String where = "";
		String category;
		String path;
		String cgk;
		String postNum;
		String location;
		MemberDTO loginMember;
		ArrayList<PostDTO> list;
		ArrayList<ReplyDTO> reply;
		PostDTO post;
		String pageStr;
		int page = 1;
		int totalPage;
		int totalPb;
		int currentPb;
		session = request.getSession();
		out = response.getWriter();
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		loginMember = (MemberDTO) session.getAttribute("loginMember");
		path = request.getPathInfo();
		category = request.getParameter("category");
		if (category == null) {
			category = "popular";
		}
		cgk = board.switchCategory(category);
		pageStr = request.getParameter("page");
		if (pageStr != null) {
			page = Integer.parseInt(pageStr);
		}
		request.setAttribute("page", page);
		request.setAttribute("category", category);
		request.setAttribute("cgKorean", cgk);

		postNum = request.getParameter("postNum");
		if (postNum != null) {
			request.setAttribute("postNum", postNum);
		}
		location = request.getParameter("location");
		if (location == null) {
			location = "/index.jsp";
		}
		if (path != null) {
			switch (path) {
			case "/write":
				String conWrite = request.getParameter("content");
				conWrite = conWrite.replace("\r\n", "<br>");
				loginMember.setHeart(loginMember.getHeart() + 3);
				loginMember.setPCount(loginMember.getPCount() + 1);
				member.memberUpdate(loginMember);
				session.setAttribute("loginMember", loginMember);
				String writerName = loginMember.getName();
				if(category.equals("anonym")) {
					writerName="익명";
				}
				board.newPost(loginMember.getId(), writerName, request.getParameter("title"), conWrite,
						category);
				response.sendRedirect("/board/board?category=" + category + "&page=" + page);
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
				response.sendRedirect("/board/read?category=" + category + "&postNum=" + postNum + "&page=" + page);
				return;
			case "/board":
				list = board.getList(category, page);
				request.setAttribute("list", list);
				where = "where category = '" + category + "'";
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

			case "/search":
				String key = request.getParameter("key");
				if (key == null) {
					key = "title";
				}
				String keyword = request.getParameter("keyword");
				if (keyword == null) {
					keyword = "";
				}
				request.setAttribute("key", key);
				request.setAttribute("keyword", keyword);
				switch (category) {
				case "general":
				case "anonym":
					where = String.format("where %s like '%%%s%%' and category = '%s'", key, keyword, category);
					break;
				default:
					where = String.format("where %s like '%%%s%%'", key, keyword);
				}
				list = board.searchList(where, page);
				request.setAttribute("list", list);
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
				forward = "/search.jsp";
				break;
			case "/read":
				board.view(postNum);
				post = board.selectPost(postNum);
				request.setAttribute("post", post);
				reply = board.reply(postNum);
				request.setAttribute("reply", reply);
				forward = "/read.jsp";
				break;
			case "/mypost":
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
				forward = "/mypost.jsp";
				break;
			case "/myreply":
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
				forward = "/myreply.jsp";
				break;
			case "/edit":
				String conEdit = request.getParameter("content");
				conEdit = conEdit.replace("\r\n", "<br>");
				board.edit(postNum, request.getParameter("title"), conEdit);
				response.sendRedirect("/board/read?category=" + category + "&page=" + page + "&postNum=" + postNum);
				return;
			case "/heart":
				post = board.selectPost(postNum);
				if (loginMember.getHeart() < 1) {
					out.println("<script>alert('하트가 부족합니다..')</script>");
					out.println("<script>location.href='/board/read?category=" + category + "&postNum=" + postNum
							+ "&page=" + page + "'</script>");
					return;
				} else {
					MemberDTO writer = member.getMember(post.getWr_id());
					if (writer != null) {
						if (loginMember.getId().equals(post.getWr_id())) {
							out.println("<script>alert('내가 쓴 글에는 할 수 없습니다.')</script>");
							out.println("<script>location.href='/board/read?category=" + category + "&postNum=" + postNum
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
									"/board/read?category=" + category + "&postNum=" + postNum + "&page=" + page);
							return;
						}
					} else {
						out.println("<script>alert('작성자 탈퇴 등의 이유로 해당 글에는 할 수 없습니다.')</script>");
						out.println("<script>location.href='/board/read?category=" + category + "&postNum=" + postNum
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
				response.sendRedirect("/board/board?category=" + category + "&page=" + page);
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
				response.sendRedirect("/board/read?category=" + category + "&postNum=" + postNum + "&page=" + page);
				return;
			}

			RequestDispatcher dispatcher = request.getRequestDispatcher(forward);
			dispatcher.forward(request, response);
			out.close();

		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
