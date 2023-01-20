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
<title>거실</title>
<link rel="stylesheet" href="css/m_5.css">

</head>
<body>
	<%
	Map map5 = new Map();
	Log log = new Log();
	String id5 = request.getParameter("m_id");
	MapDTO m5 = map5.getMap(id5);
	CharacterDTO p5 = (CharacterDTO)session.getAttribute("player");
	String mode = request.getParameter("mode");
	%>
	<div id="t">
		<%@include file="title.jsp"%>
	</div>
	<div id="n"></div>
	<div id="w"><!-- m_2 복도 -->
		<button id="we_btn"
			onclick="location.href='game.jsp?m_id=m_2&mode=move'">복도</button>
	</div>
	<!------------------스크린 ------------------>
	<div id="screen_c">
		<%
		switch (mode) {
		case "move":
			map5.move(m5, p5);
		case "normal":
		%>
		<div id="desk">
			<img src="img/desk.png" id="deskimg">
			<button
				onclick="location.href='game.jsp?m_id=<%=m5.getMapId()%>&mode=action1'">서랍
				열기</button>
		</div>
		<div id="player">
			<img src="img/humannormal.jpg" id="playerimg">
		</div>
		<%
		break;
		case "action1":
			if (p5.getStory() < 6) {
				p5.setStory(6);
				p5.setExp(p5.getExp() + 5);
				Log.turnCount++;
				log.send("[ " + Log.turnCount + " ] 서랍을 열었습니다.", "normal");
				log.send(p5.getName() + "🗣 \"지도다! \"", "speech");
				log.send("👜 이제 지도를 사용할 수 있습니다.", "good");
				log.send("🎉 새로운 이야기를 완료했습니다. (경험치 +5)", "story");
				log.send("💡 ''방으로'' 아이콘을 누르면 즉시 \'나의 방\'으로 이동할 수 있습니다.", "tip");
		%>
		<div id="desk">
			<img src="img/desk.png" id="deskimg">
		</div>
		<div id="player">
			<img src="img/humanmap.png" id="playerimg2">
		</div>
		<%
		} else {
		Log.turnCount++;
		log.send("[ " + Log.turnCount + " ] 서랍을 열었습니다. 아무것도 없습니다.", "normal");
		%>
		<jsp:forward page="game.jsp">
			<jsp:param value="normal" name="mode" />
			<jsp:param value="<%=m5.getMapId()%>" name="m_id" />
		</jsp:forward>
		<%
		}
		break;

		}
		%>
	</div>
	<!------------------스크린 ------------------>
	<div id="e"></div>
	<div id="s"><!-- m_6 마당 -->
		<%
		if (p5.getStory() >= 7) {
		%>
		<button id="ns_btn"
			onclick="location.href='game.jsp?m_id=m_6&mode=move'">마당</button>
		<%
		}
		%>
	</div>
</body>
</html>