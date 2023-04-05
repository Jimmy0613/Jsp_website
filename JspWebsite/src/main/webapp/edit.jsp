<%@page import="com.cre.w.dto.UserDTO"%>
<%@page import="com.cre.w.Board"%>
<%@page import="com.cre.w.User"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.File"%>
<%@page import="com.cre.w.dto.PostDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.cre.w.dao.BoardDAO"%>
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
	String postNum = request.getParameter("postNum");
		String category = request.getParameter("category");
		Board board = new Board();
		PostDTO post = board.selectPost(postNum);
		String content = post.getContent().replace("<br>", "\r\n");
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
				<span style="font-size: 1.2em;">수정</span>
				<form action="/board/edit">
					<input type="hidden" name="postNum" value="<%=postNum%>">
					<input type="hidden" name="category" value="<%=category%>">
					<input id="title" placeholder="제목" name="title"
						value="<%=post.getTitle()%>"> <input id="writer"
						placeholder="<%=post.getWriter()%>" readonly><br>
					<textarea id="content" name="content"><%=content%></textarea>
					<button id="write_button" type="submit">글쓰기</button>
				</form>
			</div>
		</div>
	</div>
</body>
</html>