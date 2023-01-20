<%@page import="com.cre.w.dto.PostDTO"%>
<%@page import="com.cre.w.dto.MemberDTO"%>
<%@page import="com.cre.w.sys.Member"%>
<%@page import="com.cre.w.sys.Board"%>
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
	String category = request.getParameter("category");
	String currentPage = request.getParameter("page");
	%>
	<script>
	var ok = confirm("정말 삭제하시겠습니까?");
	if(ok){
		location.href="proc/deleteReProc.jsp?reNum=<%=reNum%>&postNum=<%=postNum%>&page=<%=currentPage%>&category=<%=category%>";		
	} else {
		location.href="read.jsp?postNum=<%=postNum%>&page=<%=currentPage%>&category=<%=category%>";	
	}
	</script>
</body>
</html>