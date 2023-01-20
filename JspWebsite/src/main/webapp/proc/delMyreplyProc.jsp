<%@page import="java.util.ArrayList"%>
<%@page import="com.cre.w.dto.ReplyDTO"%>
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
	String[] delList = (String[]) session.getAttribute("delreList");
	Board board = new Board();
	Member member = new Member();
	MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
	for (String s : delList) {
		board.deleteReply(s);
		loginMember.setHeart(loginMember.getHeart() - 1);
		loginMember.setRCount(loginMember.getRCount() - 1);
		member.memberUpdate(loginMember);
		session.setAttribute("loginMember", loginMember);
	}
	out.println("<script>alert('삭제되었습니다.')</script>");
	out.println("<script>location.href='../mypage.jsp?mode=myreply'</script>");
	%>
</body>
</html>