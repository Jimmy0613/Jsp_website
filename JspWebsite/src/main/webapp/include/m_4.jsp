<%@page import="com.cre.w.dto.CharacterDTO"%>
<%@page import="com.cre.w.dto.MapDTO"%>
<%@page import="com.cre.w.sys.Map"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.File"%>
<%@page import="com.cre.w.sys.Log"%>
<%@page import="com.cre.w.sys.Charac"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>다용도실</title>
<link rel="stylesheet" href="css/m_4.css">

</head>
<body>
	<%
	Map map4 = new Map();
	Log log = new Log();
	String id4 = request.getParameter("m_id");
	MapDTO m4 = map4.getMap(id4);
	CharacterDTO p4 = (CharacterDTO)session.getAttribute("player");
	String mode = request.getParameter("mode");
	%>
	<div id="t">
		<%@include file="title.jsp"%>
	</div>
	<div id="n"><!-- m_3 주방 -->
		<button id="ns_btn"
			onclick="location.href='game.jsp?m_id=m_3&mode=move'">주방</button>
	</div>
	<div id="w"></div>
	<!------------------스크린 ------------------>
	<div id="screen_c">
		<%
		switch (mode) {
		case "move":
			map4.move(m4, p4);
		case "normal":
			if (p4.getStory() < 5) {
		%>
		<div id="bag">
			<img src="img/bag.png" id="bagimg">
			<button
				onclick="location.href='game.jsp?m_id=<%=m4.getMapId()%>&mode=action1'">살펴보기</button>
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
			p4.setStory(5);
			p4.setExp(p4.getExp() + 5);
			log.send(p4.getName() + "🗣 \"가방이다! \"","speech");
			log.send("👜 이제 가방을 사용할 수 있습니다.","good");
			log.send("🎉 새로운 이야기를 완료했습니다. (경험치 +5)","story");
			log.send("🏃‍♂️ 새로운 지역이 열렸습니다. (거실)","map");
		%>
		<div id="player">
			<img src="img/humanbag.png" id="playerimg2">
		</div>
		<%
		break;

		}
		%>
	</div>
	<!------------------스크린 ------------------>
	<div id="e"></div>
	<div id="s"></div>
</body>
</html>