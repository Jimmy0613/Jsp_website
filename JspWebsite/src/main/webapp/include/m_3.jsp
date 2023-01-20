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
<title>주방</title>
<link rel="stylesheet" href="css/m_3.css">

</head>
<body>
	<%
	Map map3 = new Map();
	Log log = new Log();
	String id3 = request.getParameter("m_id");
	MapDTO m3 = map3.getMap(id3);
	CharacterDTO p3 = (CharacterDTO)session.getAttribute("player");
	String mode = request.getParameter("mode");
	%>
	<div id="t">
		<%@include file="title.jsp"%>
	</div>
	<div id="n"></div>
	<div id="w"></div>
	<!------------------스크린 ------------------>
	<div id="screen_c">
		<%
		switch (mode) {
		case "move":
			map3.move(m3, p3);
		case "normal":
		%>
		<div id="fridge">
			<img src="img/fridge.jpg" id="fridgeimg">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<button
				onclick="location.href='game.jsp?m_id=<%=m3.getMapId()%>&mode=action1'">열기</button>
		</div>
		<div id="player">
			<img src="img/humannormal.jpg" id="playerimg">
		</div>
		<%
		break;
		case "action1":
			if (p3.getStory() < 4) {
				p3.setStory(4);
				p3.setExp(p3.getExp() + 5);
				Log.turnCount++;
				log.send("[ " + Log.turnCount + " ] 냉장고를 열었습니다.", "normal");
				log.send("🎉 새로운 이야기를 완료했습니다. (경험치 +5)", "story");
				log.send("🎉 새로운 지역이 열렸습니다. (다용도실)", "map");
				log.send("💡 냉장고에는 음식 아이템을 넣을 수 있습니다.", "tip");
			}
		%>
		<button id="f_btn"
			onclick="location.href='game.jsp?m_id=<%=m3.getMapId()%>&mode=normal'">닫기</button>
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
				<%@include file="bag_food.jsp"%>
			</div>
		</div>
		<%
		break;

		}
		%>
	</div>
	<!------------------스크린 ------------------>
	<div id="e"><!-- m_2 복도 -->
		<button id="we_btn"
			onclick="location.href='game.jsp?m_id=m_2&mode=move'">복도</button>
	</div>
	<div id="s"><!-- m_4 다용도실 -->
		<%
		if (p3.getStory() >= 4) {
		%>
		<button id="we_btn"
			onclick="location.href='game.jsp?m_id=m_4&mode=move'">다용도실</button>
		<%
		}
		%>
	</div>
</body>
</html>