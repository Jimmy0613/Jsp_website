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
<title>나의 방</title>
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
<link rel="stylesheet" href="css/m_1.css">
</head>
<body>
	<%
	//나의방
	Charac character = new Charac();
	CharacterDTO player = (CharacterDTO) session.getAttribute("player");
	character.characterUpdate(player);
	session.setAttribute("player", player);
	session.setAttribute("m_id", "m_1");
	String mode = request.getParameter("mode");
	Map map = new Map();
	Log log = new Log();
	MapDTO m1 = map.getMap("m_1");
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
				<!---------------------------------------------------스크린 --------------------------------------------------->
				<div id="screen">
					<div id="t">
						<%@include file="include/title.jsp"%>
					</div>
					<div id="n">
						<!-- m_2 복도 -->
						<%
						if (player.getStory() >= 0) {
						%>
						<button id="ns_btn" onclick="location.href='m_2.jsp?mode=move'">복도</button>
						<%
						}
						%>
					</div>
					<div id="w"></div>
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
						String msg = "";
						switch (mode) {
						case "move":
							map.move(m1, player);
						case "normal":
						%>
						<div id="bed">
							<button onclick="location.href='m_1.jsp?mode=action1'">잠자기</button>
							<img src="img/bed.jpg" id="bedimg">
						</div>
						<div id="player">
							<img src="img/humannormal.jpg" id="playerimg">
						</div>
						<%
						break;
						case "action1":
							if (player.getPower() == player.getMaxPower()) {
								log.send(player.getName() + "🗣 \"지금은 잘 필요가 없는 것 같은데?\"", "speech");
								if (player.getStory() < 0) {
							player.setStory(0);
							player.setExp(player.getExp() + 5);
							log.send("🎉 새로운 이야기를 완료했습니다. (경험치 +5)", "story");
							log.send("💡 ''지난 이야기 보기''를 통해 완료한 이야기 목록을 볼 수 있습니다.", "tip");
							log.send("🏃‍♂️ 새로운 지역이 열렸습니다. (복도)", "map");
						%>
						<jsp:forward page="m_1.jsp">
							<jsp:param value="normal" name="mode" />
						</jsp:forward>
						<%
						}
						%>
						<div id="bed">
							<button onclick="location.href='m_1.jsp?mode=action1'">잠자기</button>
							<img src="img/bed.jpg" id="bedimg">
						</div>
						<div id="player">
							<img src="img/humannormal.jpg" id="playerimg">
						</div>
						<%
						} else {
						Log.turnCount++;
						log.send("[ " + Log.turnCount + " ] 🛏 침대에 누웠습니다..", "normal");
						%>
						<div id="bed">
							<button onclick="location.href='m_1.jsp?mode=action2'">일어나기</button>
							<img src="img/sleeping.jpg" id="bedimg">
						</div>
						<%
						}
						break;
						case "action2":
						Log.turnCount++;
						player.setPower(player.getMaxPower());
						log.send("[ " + Log.turnCount + " ] 힘을 회복했습니다.", "normal");
						if (player.getStory() < 3) {
						player.setStory(3);
						player.setExp(player.getExp() + 10);
						log.send("🎉 새로운 이야기를 완료했습니다. (경험치 +10)", "story");
						log.send("🏃‍♂️ 새로운 지역이 열렸습니다. (주방)", "map");
						}
						%>
						<jsp:forward page="m_1.jsp">
							<jsp:param value="action3" name="mode" />
						</jsp:forward>
						<%
						case "action3":
						%>
						<div id="bed">
							<button onclick="location.href='m_1.jsp?mode=action1'">잠자기</button>
							<img src="img/bed.jpg" id="bedimg">
						</div>
						<div id="player">
							<img src="img/humanPower.png" id="playerimg">
						</div>
						<%
						break;
						}
						}
						%>
					</div>
					<div id="e"></div>
					<div id="s"></div>
				</div>
				<!----------------------------------------------------------------------------------------------------------------->
				<div id="system">
					<%@ include file="include/sys_game.jsp"%>
				</div>
			</div>
		</div>
	</div>

</body>
</html>