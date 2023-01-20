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
<title>나의 방</title>
<link rel="stylesheet" href="css/m_1.css">
</head>
<body>
	<%
	//나의방
	Map map1 = new Map();
	Log log = new Log();
	String id1 = request.getParameter("m_id");
	MapDTO m1 = map1.getMap(id1);
	CharacterDTO p1 = (CharacterDTO)session.getAttribute("player");
	String mode = request.getParameter("mode");
	%>

	<div id="t">
		<%@include file="title.jsp"%>
	</div>
	<div id="n"><!-- m_2 복도 -->
		<%
		if (p1.getStory() >= 0) {
		%>
		<button id="ns_btn"
			onclick="location.href='game.jsp?m_id=m_2&mode=move'">복도</button>
		<%
		}
		%>
	</div>
	<div id="w"></div>
	<!---------------------------------------------------스크린 --------------------------------------------------->
	<div id="screen_c">
		<%
		String msg = "";
		switch (mode) {
		case "move":
			map1.move(m1, p1);
		case "normal":
		%>
		<div id="bed">
			<button
				onclick="location.href='game.jsp?m_id=<%=m1.getMapId()%>&mode=action1'">잠자기</button>
			<img src="img/bed.jpg" id="bedimg">
		</div>
		<div id="player">
			<img src="img/humannormal.jpg" id="playerimg">
		</div>
		<%
		break;
		case "action1":
			if (p1.getPower() == p1.getMaxPower()) {
				log.send(p1.getName() + "🗣 \"지금은 잘 필요가 없는 것 같은데?\"", "speech");
				if (p1.getStory() < 0) {
			p1.setStory(0);
			p1.setExp(p1.getExp() + 5);
			log.send("🎉 새로운 이야기를 완료했습니다. (경험치 +5)", "story");
			log.send("💡 ''지난 이야기 보기''를 통해 완료한 이야기 목록을 볼 수 있습니다.", "tip");
			log.send("🏃‍♂️ 새로운 지역이 열렸습니다. (복도)", "map");
		%>
		<jsp:forward page="game.jsp">
			<jsp:param value="normal" name="mode" />
			<jsp:param value="<%=m1.getMapId()%>" name="m_id" />
		</jsp:forward>
		<%
		}
		%>
		<div id="bed">
			<button
				onclick="location.href='game.jsp?m_id=<%=m1.getMapId()%>&mode=action1'">잠자기</button>
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
			<button
				onclick="location.href='game.jsp?m_id=<%=m1.getMapId()%>&mode=action2'">일어나기</button>
			<img src="img/sleeping.jpg" id="bedimg">
		</div>
		<%
		}
		break;
		case "action2":
		Log.turnCount++;
		p1.setPower(p1.getMaxPower());
		log.send("[ " + Log.turnCount + " ] 힘을 회복했습니다.", "normal");
		if (p1.getStory() < 3) {
		p1.setStory(3);
		p1.setExp(p1.getExp() + 10);
		log.send("🎉 새로운 이야기를 완료했습니다. (경험치 +10)", "story");
		log.send("🏃‍♂️ 새로운 지역이 열렸습니다. (주방)", "map");
		}
		%>
		<jsp:forward page="game.jsp">
			<jsp:param value="action3" name="mode" />
			<jsp:param value="<%=m1.getMapId()%>" name="m_id" />
		</jsp:forward>
		<%
		case "action3":
		%>
		<div id="bed">
			<button
				onclick="location.href='game.jsp?m_id=<%=m1.getMapId()%>&mode=action1'">잠자기</button>
			<img src="img/bed.jpg" id="bedimg">
		</div>
		<div id="player">
			<img src="img/humanPower.png" id="playerimg">
		</div>
		<%
		break;

		}
		%>
	</div>
	<!----------------------------------------------------------------------------------------------------------------->
	<div id="e"></div>
	<div id="s"></div>
</body>
</html>