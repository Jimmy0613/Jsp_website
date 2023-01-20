<%@page import="com.cre.w.dto.MapDTO"%>
<%@page import="com.cre.w.sys.Map"%>
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
	href="css/sys_game.css?ver=<%=fmt.format(lastModifiedStyle)%>">
<link rel="stylesheet"
	href="css/map.css?ver=<%=fmt.format(lastModifiedStyle)%>">
</head>
<body>

	<%
	Charac character = new Charac();
	CharacterDTO player = (CharacterDTO)session.getAttribute("player");
	character.characterUpdate(player);
	session.setAttribute("player", player);
	String m_id = request.getParameter("m_id");
	String mode = request.getParameter("mode");
	String map_jsp = "include/" + m_id + ".jsp";
	%>
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
					<%
					if (mode.equals("bag")) {
					%>
					<%@ include file="include/bag.jsp"%>
					<%
					} else if (mode.equals("map")) {
					%>
					<%@ include file="include/map.jsp"%>
					<%
					} else if (mode.equals("return") || player.getPower() <= 0) {
					%>
					<%@ include file="include/return.jsp"%>
					<%
					} else {
					%>
					<jsp:include page="<%=map_jsp%>">
						<jsp:param value="<%=mode%>" name="mode" />
						<jsp:param value="<%=m_id%>" name="m_id" />
					</jsp:include>
					<%
					}
					%>
				</div>
				<div id="system">
					<%@ include file="include/sys_game.jsp"%>
				</div>
			</div>
		</div>
	</div>
</body>
</html>