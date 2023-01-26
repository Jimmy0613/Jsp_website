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
<title>마당</title>
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
<link rel="stylesheet" href="css/m_6.css">
</head>
<body>
	<%
	Charac character = new Charac();
	CharacterDTO player = (CharacterDTO) session.getAttribute("player");
	character.characterUpdate(player);
	session.setAttribute("player", player);
	session.setAttribute("m_id", "m_6");
	String mode = request.getParameter("mode");
	Map map = new Map();
	Log log = new Log();
	MapDTO m6 = map.getMap("m_6");
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
						<!-- m_5 거실 -->
						<button id="ns_btn" onclick="location.href='m_5.jsp?mode=move'">거실</button>
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
							map.move(m6, player);
						case "normal":
							if (player.getStory() < 8) {
								log.send(player.getName() + "🗣 \"돈이다! \"", "speech");
						%>
						<div id="sp1">
							<img src="img/sp_m6_1.jpg">
						</div>
						<div id="wall">
							<img src="img/wall.png">
						</div>
						<div id="player">
							<img src="img/human6.jpg">
						</div>
						<div id="coin">
							<img src="img/coin.jpg">
							<button onclick="location.href='m_6.jsp?mode=action1'">줍기</button>
						</div>

						<%
						} else if (player.getStory() == 8) {
						log.send(player.getName() + "🗣 \"깜짝이야! 누구세요?! \"", "speech");
						%>
						<div id="sp3">
							<img src="img/sp_m6_3.jpg">
						</div>
						<div id="wall2">
							<img src="img/wallhuman.png">
							<button onclick="location.href='m_6.jsp?mode=action2'">다가가기</button>
						</div>
						<div id="player">
							<img src="img/human6.jpg">
						</div>

						<%
						} else {
						%>
						<div id="wall">
							<img src="img/wall.png">
						</div>
						<div id="player">
							<img src="img/humannormal.jpg">
						</div>
						<%
						}
						break;
						case "action1":
						player.setStory(8);
						player.setExp(player.getExp() + 5);
						player.setCoin(player.getCoin() + 5);
						log.send(player.getName() + "🗣 \"아싸! \"", "speech");
						log.send("🎉 새로운 이야기를 완료했습니다. (경험치 +5, 금화 +5)", "story");
						%>
						<div id="sp2">
							<img src="img/sp_m6_2.jpg">
						</div>
						<div id="wall">
							<img src="img/wall.png">
						</div>
						<div id="player2">
							<img src="img/humancoin.png">
						</div>
						<%
						break;
						case "action2":
							player.setStory(9);
							log.send(player.getName() + "🗣 \"사라졌다?! \"", "speech");
							log.send("🎉 새로운 이야기를 완료했습니다. (경험치 +10)", "story");
							log.send("🏃‍♂️ 새로운 지역이 열렸습니다. (집 앞)", "map");
						%>

						<div id="sp4">
							<img src="img/sp_m6_4.jpg">
						</div>
						<div id="wall">
							<img src="img/wall.png">
						</div>
						<div id="player">
							<img src="img/humansurprised.jpg">
						</div>
						<%
						}
						}
						%>
					</div>
					<!------------------스크린 ------------------>
					<div id="e">
						<!-- m_7 집 앞 -->
						<%
						if (player.getStory() >= 9) {
						%>
						<button id="we_btn" onclick="location.href='m_7.jsp?mode=move'">집
							앞</button>
						<%
						}
						%>
					</div>
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