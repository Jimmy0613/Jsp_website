<%@page import="com.cre.w.dto.PostDTO"%>
<%@page import="com.cre.w.dto.MemberDTO"%>
<%@page import="com.cre.w.sys.Member"%>
<%@page import="com.cre.w.sys.Board"%>
<%@page import="com.cre.w.dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	String reNum = request.getParameter("reNum");
	String postNum = request.getParameter("postNum");
	String currentPage = request.getParameter("page");
	String category = request.getParameter("category");
	Board board = new Board();
	Member member = new Member();
	PostDTO post = board.selectPost(postNum);
	MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
	MemberDTO writer = member.getMember(post.getWr_id());
	if (!writer.getId().equals(loginMember.getId())) {
		loginMember.setHeart(loginMember.getHeart() - 1);
	}
	loginMember.setRCount(loginMember.getRCount() - 1);
	member.memberUpdate(loginMember);
	session.setAttribute("loginMember", loginMember);
	board.deleteReply(reNum);
	board.replyCount(postNum, "-1");
	out.println("<script>alert('삭제되었습니다.');</script>");
	out.println("<script>location.href='../read.jsp?postNum=" + postNum + "&page=" + currentPage + "&category=" + category + "'</script>");
	%>
</body>
</html>