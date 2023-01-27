<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.ArrayList"%>
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
	String ky = (String)request.getAttribute("key");
	String kw = (String)request.getAttribute("keyword");
	int tp1 = (Integer)request.getAttribute("totalPage");
	int cPage1 = (Integer)request.getAttribute("page");
	int pb = (Integer)request.getAttribute("currentPb");
	String cg1 = (String)request.getAttribute("category");
	
	//(처음)
	if (cPage1 > 1) {
	%>
	<a href="/board/search?page=1&category=<%=cg1%>&key=<%=ky %>&keyword=<%=kw %>"
		style="font-weight: bolder; font-size: 0.8em;">처음</a>
	<%
	} else { 
	%>
	<a style="font-weight: bolder; font-size: 0.8em; cursor:default;">처음</a>
	<%
	}
	//======================================================================
	//(이전)
	if (cPage1 > 1) {
	if (cPage1 % Page.PAGE_BLOCK == 1) {
	%>
	<a
		href="/board/search?page=<%=((pb - 1) * Page.PAGE_BLOCK)%>&category=<%=cg1%>&key=<%=ky %>&keyword=<%=kw %>"
		style="font-weight: bolder; font-size: 0.8em;">이전</a>
	<%
	} else if (cPage1 > 1) {
	%>
	<a href="/board/search?page=<%=(cPage1 - 1)%>&category=<%=cg1%>&key=<%=ky %>&keyword=<%=kw %>"
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
		href="/board/search?page=<%=i%>&category=<%=cg1%>&key=<%=ky %>&keyword=<%=kw %>"><%=i%></a>
	<%
	} else {
	%>
	<a href="/board/search?page=<%=i%>&category=<%=cg1%>&key=<%=ky %>&keyword=<%=kw %>"><%=i%></a>
	<%
	}
	}

	//(다음)
	if (cPage1 % Page.PAGE_BLOCK == 0) {
	%>
	<a
		href="/board/search?page=<%=(pb * Page.PAGE_BLOCK + 1)%>&category=<%=cg1%>&key=<%=ky %>&keyword=<%=kw %>"
		style="font-weight: bolder; font-size: 0.8em;">다음</a>
	<%
	} else if (cPage1 < tp1) { 
	%>
	<a href="/board/search?page=<%=cPage1 + 1%>&category=<%=cg1%>&key=<%=ky %>&keyword=<%=kw %>"
		style="font-weight: bolder; font-size: 0.8em;">다음</a>
	<%
	} else { 
	%>
	<a style="font-weight: bolder; font-size: 0.8em; cursor:default;">다음</a>
	<%
	}
	//===========================================================
	//(마지막) 
	if (cPage1 < tp1) {
	%>
	<a href="/board/search?page=<%=tp1%>&category=<%=cg1%>&key=<%=ky %>&keyword=<%=kw %>"
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