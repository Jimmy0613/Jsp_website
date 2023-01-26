<%@page import="com.cre.w.dto.MemberDTO"%>
<%@page import="com.cre.w.sys.Page"%>
<%@page import="java.net.URLDecoder"%>
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
	MemberDTO loginMember = (MemberDTO)session.getAttribute("loginMember");
	Page p2 = new Page();
	String cp2 = request.getParameter("page");
	int cup2 = 1;
	if (cp2 != null) {
		cup2 = Integer.parseInt(cp2);
	}
	String cg2 = request.getParameter("category");
	if (cg2 == null) {
		cg2 = "general";
	}
	int totalPage = p2.getTotalPage(cg2);
	if (loginMember != null) {
		if (cg2.equals("notice")) {
			if (loginMember.getId().equals("manager")) {
	%>
	<button
		onclick="location.href='write.jsp?category=<%=cg2%>&page=<%=cup2%>'">글쓰기</button>
	<%
	}
	} else {
	%>
	<button
		onclick="location.href='write.jsp?category=<%=cg2%>&page=<%=cup2%>'">글쓰기</button>
	<%
	}
	}
	%>
</body>
</html>