<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가입</title>
<%
/* CSS/JS 파일 캐시 방지 */
String styleCss = application.getRealPath("/css/join.css");
File style = new File(styleCss);
Date lastModifiedStyle = new Date(style.lastModified());
SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMddhhmmssSSS");
%>
<link rel="stylesheet"
	href="css/common.css?ver=<%=fmt.format(lastModifiedStyle)%>">
<link rel="stylesheet"
	href="css/join.css?ver=<%=fmt.format(lastModifiedStyle)%>">
</head>
<body>
	<%
	String location = request.getParameter("location");
	if(location==null){
		location="/index.jsp";
	}
	%>
	<div class="container">
		<div class="header">
			<div class="title"></div>
			<div class="menu"><%@include file="include/menuTop.jsp"%></div>
		</div>
		<div class="content">
			<div class="join">
				<span style="font-size: 1.2em;">로그인</span>
				<div class="join_m">
					<form class="login" action="/web/login">
						<p>
							<input type="hidden" name="location" value="<%=location%>">
							아이디<br> <input name="id"><br>비밀번호<br> <input
								name="pw" type="password"> <br>
							<button id="login_button" type="submit">로그인</button>
							<a href="join.jsp?location=/login.jsp"> 회원가입 </a>
						</p>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>