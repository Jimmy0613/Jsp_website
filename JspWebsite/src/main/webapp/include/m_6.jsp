<%@page import="com.cre.w.dto.CharacterDTO"%>
<%@page import="com.cre.w.dto.MapDTO"%>
<%@page import="com.cre.w.sys.Log"%>
<%@page import="com.cre.w.sys.Charac"%>
<%@page import="com.cre.w.sys.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마당</title>
<link rel="stylesheet" href="css/m_6.css">

</head>
<body>
	<%
	Map map6 = new Map();
	Log log = new Log();
	String id6 = request.getParameter("m_id");
	MapDTO m6 = map6.getMap(id6);
	CharacterDTO p6 = (CharacterDTO)session.getAttribute("player");
	String mode = request.getParameter("mode");
	%>
	<div id="t">
		<%@include file="title.jsp"%>
	</div>
	<div id="n"><!-- m_5 거실 -->
		<button id="ns_btn"
			onclick="location.href='game.jsp?m_id=m_5&mode=move'">거실</button>
	</div>
	<div id="w"></div>
	<!------------------스크린 ------------------>
	<div id="screen_c">
		<%
		switch (mode) {
		case "move":
			map6.move(m6, p6);
		case "normal":
			if (p6.getStory() < 8) {
				log.send(p6.getName() + "🗣 \"돈이다! \"", "speech");
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
			<button
				onclick="location.href='game.jsp?m_id=<%=m6.getMapId()%>&mode=action1'">줍기</button>
		</div>

		<%
		} else if (p6.getStory() == 8) {
		log.send(p6.getName() + "🗣 \"깜짝이야! 누구세요?! \"", "speech");
		%>
		<div id="sp3">
			<img src="img/sp_m6_3.jpg">
		</div>
		<div id="wall2">
			<img src="img/wallhuman.png">
			<button
				onclick="location.href='game.jsp?m_id=<%=m6.getMapId()%>&mode=action2'">다가가기</button>
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
		p6.setStory(8);
		p6.setExp(p6.getExp() + 5);
		p6.setCoin(p6.getCoin() + 5);
		log.send(p6.getName() + "🗣 \"아싸! \"", "speech");
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
			p6.setStory(9);
			log.send(p6.getName() + "🗣 \"사라졌다?! \"", "speech");
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
		%>
	</div>
	<!------------------스크린 ------------------>
	<div id="e"><!-- m_7 집 앞 -->
		<%
		if (p6.getStory() >= 9) {
		%>
		<button id="we_btn"
			onclick="location.href='game.jsp?m_id=m_7&mode=move'">집 앞</button>
		<%
		}
		%>
	</div>
	<div id="s"></div>
</body>
</html>