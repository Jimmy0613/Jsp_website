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
<title>다용도실</title>
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
<link rel="stylesheet" href="css/m_4.css">
</head>
<body>
	<%
	Charac character = new Charac();
	CharacterDTO player = (CharacterDTO) session.getAttribute("player");
	character.characterUpdate(player);
	session.setAttribute("player", player);
	session.setAttribute("m_id", "m_4");
	String mode = request.getParameter("mode");
	Map map = new Map();
	Log log = new Log();
	MapDTO m4 = map.getMap("m_4");
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
					<div id="t">
						<%@include file="include/title.jsp"%>
					</div>
					<div id="n">
						<!-- m_3 주방 -->
						<button id="ns_btn" onclick="location.href='m_3.jsp?mode=move'">주방</button>
					</div>
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
							map.move(m4, player);
						case "normal":
							if (player.getStory() < 5) {
						%>
						<div id="bag">
							<img src="img/bag.png" id="bagimg">
							<button onclick="location.href='m_4.jsp?mode=action1'">살펴보기</button>
						</div>
						<%
						}
						%>
						<div id="player">
							<img src="img/humannormal.jpg" id="playerimg">
						</div>
						<%
						break;
						case "action1":
							player.setStory(5);
							player.setExp(player.getExp() + 5);
							log.send(player.getName() + "🗣 \"가방이다! \"", "speech");
							log.send("👜 이제 가방을 사용할 수 있습니다.", "good");
							log.send("🎉 새로운 이야기를 완료했습니다. (경험치 +5)", "story");
							log.send("🏃‍♂️ 새로운 지역이 열렸습니다. (거실)", "map");
						%>
						<div id="player">
							<img src="img/humanbag.png" id="playerimg2">
						</div>
						<%
						break;
						}
						}
						%>
					</div>
					<!------------------스크린 ------------------>
					<div id="e"></div>
					<div id="s"></div>
				</div>
				<div id="system">
					<%@ include file="include/sys_game.jsp"%>
				</div>
			</div>
		</div>
	</div>
</body>
</html>