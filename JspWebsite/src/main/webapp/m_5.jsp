<%@page import="com.cre.w.dto.CharacterDTO"%>
<%@page import="com.cre.w.dto.MapDTO"%>
<%@page import="com.cre.w.Map"%>
<%@page import="com.cre.w.Log"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>거실</title>
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
<link rel="stylesheet" href="css/m_5.css">
</head>
<body>
	<%
	Charac character = new Charac();
		CharacterDTO player = (CharacterDTO) session.getAttribute("player");
		character.characterUpdate(player);
		session.setAttribute("player", player);
		session.setAttribute("m_id", "m_5");
		String mode = request.getParameter("mode");
		Map map = new Map();
		Log log = new Log();
		MapDTO m5 = map.getMap("m_5");
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
						<!-- m_2 복도 -->
						<button id="we_btn" onclick="location.href='/m_2.jsp?mode=move'">복도</button>
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
											map.move(m5, player);
										case "normal":
						%>
						<div id="desk">
							<img src="/img/desk.png" id="deskimg">
							<button onclick="location.href='/m_5.jsp?mode=action1'">서랍
								열기</button>
						</div>
						<div id="player">
							<img src="/img/humannormal.jpg" id="playerimg">
						</div>
						<%
						break;
										case "action1":
											if (player.getStory() < 6) {
												player.setStory(6);
												player.setExp(player.getExp() + 5);
												Log.turnCount++;
												log.send("[ " + Log.turnCount + " ] 서랍을 열었습니다.", "normal");
												log.send(player.getName() + "🗣 \"지도다! \"", "speech");
												log.send("👜 이제 지도를 사용할 수 있습니다.", "good");
												log.send("🎉 새로운 이야기를 완료했습니다. (경험치 +5)", "story");
												log.send("💡 ''방으로'' 아이콘을 누르면 즉시 \'나의 방\'으로 이동할 수 있습니다.", "tip");
						%>
						<div id="desk">
							<img src="/img/desk.png" id="deskimg">
						</div>
						<div id="player">
							<img src="/img/humanmap.png" id="playerimg2">
						</div>
						<%
						} else {
										Log.turnCount++;
										log.send("[ " + Log.turnCount + " ] 서랍을 열었습니다. 아무것도 없습니다.", "normal");
						%>
						<jsp:forward page="/m_5.jsp">
							<jsp:param value="normal" name="mode" />
						</jsp:forward>
						<%
						}
										break;
										}
										}
						%>
					</div>
					<!------------------스크린 ------------------>
					<div id="e"></div>
					<div id="s">
						<!-- m_6 마당 -->
						<%
						if (player.getStory() >= 7) {
						%>
						<button id="ns_btn" onclick="location.href='/m_6.jsp?mode=move'">마당</button>
						<%
						}
						%>
					</div>
				</div>
				<div id="system">
					<%@ include file="/include/sys_game.jsp"%>
				</div>
			</div>
		</div>
	</div>
</body>
</html>