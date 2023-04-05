<%@page import="com.cre.w.dto.UserDTO"%>
<%@page import="com.cre.w.Board"%>
<%@page import="com.cre.w.User"%>
<%@page import="com.cre.w.dto.PostDTO"%>
<%@page import="com.cre.w.dao.BoardDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.File"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JspWebsite</title>
<%
/* CSS/JS 파일 캐시 방지 */
String styleCss = application.getRealPath("/css/board.css");
File style = new File(styleCss);
Date lastModifiedStyle = new Date(style.lastModified());
SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMddhhmmssSSS");
%>
<link rel="stylesheet"
	href="/css/common.css?ver=<%=fmt.format(lastModifiedStyle)%>">
<link rel="stylesheet"
	href="/css/board.css?ver=<%=fmt.format(lastModifiedStyle)%>">
</head>
<body>
	<%
	String category = request.getParameter("category");
		UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
	%>
	<div class="container">
		<div class="header">
			<div class="title"></div>
			<div class="menu">
				<%@include file="/include/menuTop.jsp"%>
			</div>
		</div>
		<div class="content">
			<div class="menu_left">
				<%@ include file="/include/menuLeft.jsp"%>
			</div>
			<div class="write">
				<span style="font-size: 1.2em;">글쓰기</span>
				<form action="/board/write">
					<input type="hidden" name="category" value="<%=category%>"> <br>
					<input id="title" placeholder="제목" name="title"> 
					<%if(category.equals("anonym")) {%>
					<input id="writer" placeholder="익명" readonly><br>
					<%} else{ %>
					<input id="writer" placeholder="<%=loginUser.getName()%>" readonly><br>
					<%} %>
					<textarea id="content" placeholder="내용" name="content"></textarea>
					<button id="write_button" type="submit">글쓰기</button>
				</form>
			</div>
		</div>
	</div>
</body>
</html>