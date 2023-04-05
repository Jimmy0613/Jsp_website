<%@page import="com.cre.w.Board"%>
<%@page import="com.cre.w.dto.UserDTO"%>
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
String styleCss = application.getRealPath("/css/mypage.css");
File style = new File(styleCss);
Date lastModifiedStyle = new Date(style.lastModified());
SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMddhhmmssSSS");
%>
<link rel="stylesheet"
	href="/css/common.css?ver=<%=fmt.format(lastModifiedStyle)%>">
<link rel="stylesheet"
	href="/css/mypage.css?ver=<%=fmt.format(lastModifiedStyle)%>">
</head>
<body>
	<%
	UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
		if (loginUser == null) {
			out.println("<script>alert('로그인 후 이용 가능한 페이지입니다.')</script>");
	%>
	<jsp:forward page="index.jsp"></jsp:forward>
	<%
	}
		int cup;
		if (request.getParameter("page") == null) {
		cup = 1;
		} else {
		cup = Integer.parseInt(request.getParameter("page"));
		}
	%>
	<div class="container">
		<div class="header">
			<div class="title"></div>
			<div class="menu">
				<%@include file="/include/menuTop.jsp"%>
			</div>
		</div>
		<div class="content">
			<div class="mypage">
				<%@include file="/include/myinfo.jsp" %>
				<div id="x">
					<%
					String mode = request.getParameter("mode");
								if (mode == null) {
									mode = "mypost";
								}
								switch (mode) {
								case "mypost":
									response.sendRedirect("/board/mypost");
									break;
								case "myreply":
									response.sendRedirect("/board/myreply");
									break;
								case "myemail":
					%>
					<%@ include file="/include/myemail.jsp"%>
					<%
					break;
					}
					%>

				</div>
			</div>
		</div>
	</div>
</body>
</html>