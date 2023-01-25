<%@page import="com.cre.w.dto.CharacterDTO"%>
<%@page import="com.cre.w.dto.MapDTO"%>
<%@page import="com.cre.w.sys.Log"%>
<%@page import="com.cre.w.sys.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>복도</title>
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
<link rel="stylesheet" href="css/m_2.css">
</head>
<body>
	<%
	Charac character = new Charac();
	CharacterDTO player = (CharacterDTO) session.getAttribute("player");
	character.characterUpdate(player);
	session.setAttribute("player", player);
	session.setAttribute("m_id", "m_2");
	String mode = request.getParameter("mode");
	Map map = new Map();
	Log log = new Log();
	MapDTO m2 = map.getMap("m_2");
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
					<div id="w">
						<!-- m_3 주방 -->
						<%
						if (player.getStory() >= 3) {
						%>
						<button id="we_btn" onclick="location.href='m_3.jsp?mode=move'">주방</button>
						<%
						}
						%>
					</div>
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
							map.move(m2, player);
						case "normal":
							if (player.getStory() < 1) {
								log.send(player.getName() + "🗣 \"으악 쥐다!\"", "speech");
								Log.turnCount++;
								log.send("[ " + Log.turnCount + " ] 쥐를 보고 놀라 힘이 빠졌습니다. (힘 -2)", "normal");
								log.send("🎉 새로운 이야기를 완료했습니다. (경험치 +5) ", "story");
								player.setExp(player.getExp() + 5);
								player.setPower(player.getPower() - 2);
								player.setStory(1);
						%>
						<jsp:forward page="m_2.jsp">
							<jsp:param value="action1" name="mode" />
						</jsp:forward>
						<%
						} else if (player.getStory() < 2) {
						%>
						<jsp:forward page="m_2.jsp">
							<jsp:param value="action1" name="mode" />
						</jsp:forward>
						<%
						}
						%>
						<div id="player">
							<img src="img/humannormal.jpg" id="playerimg">
						</div>
						<%
						break;
						case "action1":
						%><div id="player">
							<img src="img/humansurprised.jpg" id="playerimg">
						</div>
						<div id="mice">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<button onclick="location.href='m_2.jsp?mode=action2'">쫓아내기</button>
							<img src="img/mice.png" id="miceimg">
						</div>
						<%
						break;
						case "action2":
							if (player.getStory() < 2) {
								Log.turnCount++;
								player.setPower(player.getPower() - 1);
								log.send("[ " + Log.turnCount + " ] 쥐가 도망갔습니다. (힘 -1)", "normal");
								player.setStory(2);
								player.setExp(player.getExp() + 20);
								log.send("🎉 새로운 이야기를 완료했습니다. (경험치 +20)", "story");
								log.send("💡 침대에서 자면 힘을 회복할 수 있습니다.", "tip");
							}
						%>
						<jsp:forward page="m_2.jsp">
							<jsp:param value="action3" name="mode" />
						</jsp:forward>
						<%
						case "action3":
						%>
						<div id="player">
							<img src="img/humanactive.jpg" id="playerimg">
						</div>
						<%
						break;

						}
						}
						%>
					</div>
					<!---------------------------------------------------------------------------------------------------------------------------->
					<div id="e">
						<!-- m_5 거실 -->
						<%
						if (player.getStory() >= 5) {
						%>
						<button id="we_btn" onclick="location.href='m_5.jsp?mode=move'">거실</button>
						<%
						}
						%>
					</div>
					<div id="s">
						<!-- m_1 나의 방 -->
						<button id="ns_btn" onclick="location.href='m_1.jsp?mode=move'">나의
							방</button>
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