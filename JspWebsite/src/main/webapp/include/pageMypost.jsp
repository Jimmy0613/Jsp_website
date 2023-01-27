<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.cre.w.dto.MemberDTO"%>
<%@page import="com.cre.w.Board"%>
<%@page import="com.cre.w.Page"%>
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
	String md = request.getParameter("mode");
	int cPage1 = (Integer)request.getAttribute("page");
	int tp1 = (Integer)request.getAttribute("totalPage");
	int tpb = (Integer)request.getAttribute("totalPb");
	int pb = (Integer)request.getAttribute("currentPb");
	//(처음) 관련================================================
	if (cPage1 > 1) {
	%>
	<a href="/board/mypost?page=1&mode=<%=md%>"
		style="font-weight: bolder; font-size: 0.8em;">처음</a>
	<%
	} else {
	%>
	<a style="font-weight: bolder; font-size: 0.8em; cursor:default;">처음</a>
	<%
	}
	//========================================================
	//(이전) 관련================================================
	if (cPage1 > 1) { 
	if (cPage1 % Page.PAGE_BLOCK == 1) { 
	%>
	<a
		href="/board/mypost?page=<%=((pb - 1) * Page.PAGE_BLOCK)%>&mode=<%=md%>"
		style="font-weight: bolder; font-size: 0.8em;">이전</a>
	<%
	} else if (cPage1 > 1) {
	%>
	<a href="/board/mypost?page=<%=(cPage1 - 1)%>&mode=<%=md%>"
		style="font-weight: bolder; font-size: 0.8em;">이전</a>
	<%
	}
	} else {
	%>
	<a style="font-weight: bolder; font-size: 0.8em; cursor:default;">이전</a>
	<%
	}
	//=========================================================
	for (int i = (pb - 1) * Page.PAGE_BLOCK + 1; i < ((pb - 1) * Page.PAGE_BLOCK + Page.PAGE_BLOCK + 1) && i <= tp1; i++) {
	%>
	<%
	if (i == cPage1) {
	%>
	<a style="font-weight: bolder;"
		href="/board/mypost?page=<%=i%>&mode=<%=md%>"><%=i%></a>
	<%
	} else {
	%>
	<a href="/board/mypost?page=<%=i%>&mode=<%=md%>"><%=i%></a>
	<%
	}
	}

	//(다음) 관련 ===============================================
	if (cPage1 % Page.PAGE_BLOCK == 0) {
	%>
	<a href="/board/mypost?page=<%=(pb * Page.PAGE_BLOCK + 1)%>&mode=<%=md%>"
		style="font-weight: bolder; font-size: 0.8em;">다음</a>
	<%
	} else if (cPage1 < tp1) { 
	%>
	<a href="/board/mypost?page=<%=cPage1 + 1%>&mode=<%=md%>"
		style="font-weight: bolder; font-size: 0.8em;">다음</a>
	<%
	} else {
	%>
	<a style="font-weight: bolder; font-size: 0.8em; cursor:default;">다음</a>
	<%
	}
	//===========================================================
	//(마지막) 관련================================================
	if (cPage1 < tp1) {
	%>
	<a href="/board/mypost?page=<%=tp1%>&mode=<%=md%>"
		style="font-weight: bolder; font-size: 0.8em;">마지막</a>
	<%
	} else { 
	%>
	<a style="font-weight: bolder; font-size: 0.8em; cursor:default;">마지막</a>
	<%
	}
	//========================================================
	%>
</body>
</html>