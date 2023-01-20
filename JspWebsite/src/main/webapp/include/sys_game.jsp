<%@page import="com.cre.w.dto.MapDTO"%>
<%@page import="com.cre.w.dto.MemberDTO"%>
<%@page import="com.cre.w.dto.CharacterDTO"%>
<%@page import="com.cre.w.sys.Map"%>
<%@page import="com.cre.w.sys.Charac"%>
<%@page import="com.cre.w.sys.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	Map map = new Map();
	MapDTO ms = map.getMap(request.getParameter("m_id"));
	MemberDTO loginMember = (MemberDTO)session.getAttribute("loginMember");
	CharacterDTO ps = (CharacterDTO)session.getAttribute("player");
	%>
	<script>
		function showLog() {
			window.open("include/log.jsp", "지난 로그",
					"width=500, height=700, top=200, left=100");
		}
		function showStory() {
			window.open("include/story.jsp", "지난 이야기",
					"width=500, height=300, top=200, left=100");
		}
	</script>

	<div id="s_info">
		<div><%=ps.getInfo()%></div>
	</div>
	<div id="s_menu_right_t">메뉴</div>
	<div id="s_content">
		<div id="exp">
			경험치 [
			<%=ps.getExp()%>
			/
			<%=ps.getMaxExp()%>
			]
		</div>

		<div id="map_info">
			현재 위치:
			<%=ms.getInfo()%>
		</div>
		<div id="msgbox">
			<%@include file="logTen.jsp"%>
		</div>
		<div id="show">
			<button onclick="showLog();">지난 기록 보기</button>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<button onclick="showStory();">지난 이야기 보기</button>
		</div>
	</div>
	<div id="s_menu_right">
		<div class="icon" id="icon1">
			<a href="game.jsp?m_id=<%=ms.getMapId()%>&mode=return"><img
				src="img/returnhome.png"></a>
		</div>
		<b class="icon_t" id="icon1_t">방으로</b>

		<div class="icon" id="icon2">
			<a href="game.jsp?m_id=<%=ms.getMapId()%>&mode=map"><img
				src="img/map.png" id="mapimg"></a>
		</div>
		<b class="icon_t" id="icon2_t">지도</b>

		<div class="icon" id="icon3">
			<a href="game.jsp?m_id=<%=ms.getMapId()%>&mode=bag"><img
				src="img/bag.png" id="bagimg"></a>
		</div>
		<b class="icon_t" id="icon3_t">가방</b>

		<div class="icon" id="icon4">
			<a href="character.jsp"><img src="img/charac.png"></a>
		</div>
		<b class="icon_t" id="icon4_t">캐릭터</b>

	</div>
	<div id="s_banner_bot">
		<%=loginMember.getInfo()%>
	</div>
</body>
</html>