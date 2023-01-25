<%@page import="com.cre.w.dto.CharacterDTO"%>
<%@page import="com.cre.w.dto.MapDTO"%>
<%@page import="com.cre.w.sys.Map"%>
<%@page import="com.cre.w.sys.Log"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주방</title>
<%
/* CSS/JS 파일 캐시 방지 */
String styleCss = application.getRealPath("/css/common.css");
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
<link rel="stylesheet" href="css/m_3.css">
</head>
<body>
	<%
	Charac character = new Charac();
	CharacterDTO player = (CharacterDTO) session.getAttribute("player");
	character.characterUpdate(player);
	session.setAttribute("player", player);
	session.setAttribute("m_id", "m_3");
	String mode = request.getParameter("mode");
	Map map = new Map();
	Log log = new Log();
	MapDTO m3 = map.getMap("m_3");
	%>
	<div class="container">
		<div class="header">
			<div class="title"></div>
			<div class="menu">
				<%@include file="include/menuTop.jsp"%>
			</div>
		</div>
		<div class="content">
			<div id="gamebox">
				<div id="screen">
					<div id="t">
						<%@include file="include/title.jsp"%>
					</div>
					<div id="n"></div>
					<div id="w"></div>
					<!------------------스크린 ------------------>
					<div id="screen_c">
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
						switch (mode) {
						case "move":
							map.move(m3, player);
						case "normal":
						%>
						<div id="fridge">
							<img src="img/fridge.jpg" id="fridgeimg">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<button onclick="location.href='m_3.jsp?mode=action1'">열기</button>
						</div>
						<div id="player">
							<img src="img/humannormal.jpg" id="playerimg">
						</div>
						<%
						break;
						case "action1":
							if (player.getStory() < 4) {
								player.setStory(4);
								player.setExp(player.getExp() + 5);
								Log.turnCount++;
								log.send("[ " + Log.turnCount + " ] 냉장고를 열었습니다.", "normal");
								log.send("🎉 새로운 이야기를 완료했습니다. (경험치 +5)", "story");
								log.send("🎉 새로운 지역이 열렸습니다. (다용도실)", "map");
								log.send("💡 냉장고에는 음식 아이템을 넣을 수 있습니다.", "tip");
							}
						%>
						<button id="f_btn" onclick="location.href='m_3.jsp?mode=normal'">닫기</button>
						<div id="f_open">
							<div id="content_t">냉장고</div>
							<div id="content_t">가방(음식)</div>
							<div id="f_inside">
								<div id="item">1</div>
								<div id="item">2</div>
								<div id="item">3</div>
								<div id="item">4</div>
								<div id="item">5</div>
								<div id="item">6</div>
								<div id="item">1</div>
								<div id="item">2</div>
								<div id="item">3</div>
								<div id="item">4</div>
								<div id="item">5</div>
								<div id="item">6</div>
							</div>
							<div id="f_b_food">
								<%@include file="include/bag_food.jsp"%>
							</div>
						</div>
						<%
						break;
						}
						}
						%>
					</div>
					<!------------------스크린 ------------------>
					<div id="e">
						<!-- m_2 복도 -->
						<button id="we_btn" onclick="location.href='m_2.jsp?mode=move'">복도</button>
					</div>
					<div id="s">
						<!-- m_4 다용도실 -->
						<%
						if (player.getStory() >= 4) {
						%>
						<button id="ns_btn" onclick="location.href='m_4.jsp?mode=move'">다용도실</button>
						<%
						}
						%>
					</div>
				</div>
				<div id="system">
					<%@ include file="include/sys_game.jsp"%>
				</div>
			</div>
		</div>
	</div>
</body>
</html>