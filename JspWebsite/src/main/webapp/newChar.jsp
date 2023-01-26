<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jsp_rpg_v0.0.4</title>
<%
/* CSS/JS 파일 캐시 방지 */
String styleCss = application.getRealPath("/css/common_rpg.css");
File style = new File(styleCss);
Date lastModifiedStyle = new Date(style.lastModified());
SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMddhhmmssSSS");
%>
<link rel="stylesheet"
	href="css/common.css?ver=<%=fmt.format(lastModifiedStyle)%>">
<link rel="stylesheet"
	href="css/screen.css?ver=<%=fmt.format(lastModifiedStyle)%>">
<link rel="stylesheet"
	href="css/system.css?ver=<%=fmt.format(lastModifiedStyle)%>">
<link rel="stylesheet"
	href="css/character.css?ver=<%=fmt.format(lastModifiedStyle)%>">
<link rel="stylesheet"
	href="css/form.css?ver=<%=fmt.format(lastModifiedStyle)%>">
</head>
<body>
	<div class="container">
		<div class="header">
			<div class="title">Jsp Website</div>
			<div class="menu">
				<%@include file="include/menuTop.jsp"%>
			</div>
		</div>
		<div class="content">
			<div id="gamebox">
				<div id="screen">
					<%@ include file="include/sc_index.jsp"%>
				</div>
				<div id="system">
					<%@include file="include/sys_newChar.jsp"%>
				</div>
			</div>
		</div>
	</div>

</body>
</html>