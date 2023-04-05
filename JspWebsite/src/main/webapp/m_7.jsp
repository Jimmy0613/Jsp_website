<%@page import="com.cre.w.dto.CharacterDTO"%>
<%@page import="com.cre.w.dto.MapDTO"%>
<%@page import="com.cre.w.Log"%>
<%@page import="com.cre.w.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>집 앞</title>
<%
/* CSS/JS 파일 캐시 방지 */
String styleCss = application.getRealPath("/css/common_rpg.css");
File style = new File(styleCss);
Date lastModifiedStyle = new Date(style.lastModified());
SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMddhhmmssSSS");
%>
<link rel="stylesheet"
	href="/css/common.css?ver=<%=fmt.format(lastModifiedStyle)%>">
<link rel="stylesheet"
	href="/css/screen.css?ver=<%=fmt.format(lastModifiedStyle)%>">
<link rel="stylesheet"
	href="/css/system.css?ver=<%=fmt.format(lastModifiedStyle)%>">
<link rel="stylesheet"
	href="/css/sys_game.css?ver=<%=fmt.format(lastModifiedStyle)%>">
<link rel="stylesheet"
	href="/css/map.css?ver=<%=fmt.format(lastModifiedStyle)%>">
<link rel="stylesheet" href="css/m_6.css">
</head>
<body>
	<%
	Charac character = new Charac();
		CharacterDTO player = (CharacterDTO) session.getAttribute("player");
		character.characterUpdate(player);
		session.setAttribute("player", player);
		session.setAttribute("m_id", "m_7");
		String mode = request.getParameter("mode");
		Map map = new Map();
		Log log = new Log();
		MapDTO m7 = map.getMap("m_7");
	%>
	<div class="container">
		<div class="header">
			<div class="title">Jsp Website</div>
			<div class="menu">
				<%@include file="/include/menuTop.jsp"%>
			</div>
		</div>
		<div class="content">
			<div id="gamebox">
				<div id="screen">
					<div id="t">
						<%@include file="/include/title.jsp"%>
					</div>
					<div id="n"></div>
					<div id="w">
						<!-- m_6 마당 -->
						<button id="we_btn" onclick="location.href='/m_6.jsp?mode=move'">마당</button>
					</div>
					<!------------------스크린 ------------------>
					<div id="screen_c">
						<%
						if (mode.equals("bag")) {
						%>
						<%@ include file="/include/bag.jsp"%>
						<%
						} else if (mode.equals("map")) {
						%>
						<%@ include file="/include/map.jsp"%>
						<%
						} else if (mode.equals("return") || player.getPower() <= 0) {
						%>
						<%@ include file="/include/return.jsp"%>
						<%
						} else {
										switch (mode) {
										case "move":
											map.move(m7, player);
										case "normal":
											out.println("준비중 ㅎㅎ");
											break;
										case "action1":

											break;
										case "action2":

										}
										}
						%>
					</div>
					<!------------------스크린 ------------------>
					<div id="e"></div>
					<div id="s"></div>
				</div>
				<div id="system">
					<%@ include file="/include/sys_game.jsp"%>
				</div>
			</div>
		</div>
	</div>
</body>
</html>