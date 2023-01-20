<%@page import="com.cre.w.dto.CharacterDTO"%>
<%@page import="com.cre.w.dto.MapDTO"%>
<%@page import="com.cre.w.sys.Log"%>
<%@page import="com.cre.w.sys.Map"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.File"%>
<%@page import="com.cre.w.sys.Charac"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>복도</title>
<link rel="stylesheet" href="css/m_2.css">

</head>
<body>
	<%
	Map map2 = new Map();
	Log log = new Log();
	String id2 = request.getParameter("m_id");
	MapDTO m2 = map2.getMap(id2);
	CharacterDTO p2 = (CharacterDTO)session.getAttribute("player");
	String mode = request.getParameter("mode");
	%>
	<div id="t">
		<%@include file="title.jsp"%>
	</div>
	<div id="n"></div>
	<div id="w"><!-- m_3 주방 -->
		<%
		if (p2.getStory() >= 3) {
		%>
		<button id="we_btn"
			onclick="location.href='game.jsp?m_id=m_3&mode=move'">주방</button>
		<%
		}
		%>
	</div>
	<div id="screen_c">
		<!------------------스크린 ------------------>
		<%
		switch (mode) {
		case "move":
			map2.move(m2, p2);
		case "normal":
			if (p2.getStory() < 1) {
				log.send(p2.getName() + "🗣 \"으악 쥐다!\"", "speech");
				Log.turnCount++;
				log.send("[ " + Log.turnCount + " ] 쥐를 보고 놀라 힘이 빠졌습니다. (힘 -2)", "normal");
				log.send("🎉 새로운 이야기를 완료했습니다. (경험치 +5) ", "story");
				p2.setExp(p2.getExp() + 5);
				p2.setPower(p2.getPower() - 2);
				p2.setStory(1);
		%>
		<jsp:forward page="game.jsp">
			<jsp:param value="action1" name="mode" />
			<jsp:param value="<%=m2.getMapId()%>" name="m_id" />
		</jsp:forward>
		<%
		} else if (p2.getStory() < 2) {
		%>
		<jsp:forward page="game.jsp">
			<jsp:param value="action1" name="mode" />
			<jsp:param value="<%=m2.getMapId()%>" name="m_id" />
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
			<button
				onclick="location.href='game.jsp?m_id=<%=m2.getMapId()%>&mode=action2'">쫓아내기</button>
			<img src="img/mice.png" id="miceimg">
		</div>
		<%
		break;
		case "action2":
			if (p2.getStory() < 2) {
				Log.turnCount++;
				p2.setPower(p2.getPower() - 1);
				log.send("[ " + Log.turnCount + " ] 쥐가 도망갔습니다. (힘 -1)", "normal");
				p2.setStory(2);
				p2.setExp(p2.getExp() + 20);
				log.send("🎉 새로운 이야기를 완료했습니다. (경험치 +20)", "story");
				log.send("💡 침대에서 자면 힘을 회복할 수 있습니다.", "tip");
			}
		%>
		<jsp:forward page="game.jsp">
			<jsp:param value="action3" name="mode" />
			<jsp:param value="<%=m2.getMapId()%>" name="m_id" />
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
		%>
	</div>
	<!---------------------------------------------------------------------------------------------------------------------------->
	<div id="e"><!-- m_5 거실 -->
		<%
		if (p2.getStory() >= 5) {
		%>
		<button id="we_btn"
			onclick="location.href='game.jsp?m_id=m_1&mode=move'">거실</button>
		<%
		}
		%>
	</div>
	<div id="s"><!-- m_1 나의 방 -->
		<button id="ns_btn"
			onclick="location.href='game.jsp?m_id=m_1&mode=move'">나의 방</button>
	</div>
</body>
</html>