<%@page import="com.cre.w.dto.MapDTO"%>
<%@page import="com.cre.w.dto.CharacterDTO"%>
<%@page import="com.cre.w.sys.Log"%>
<%@page import="com.cre.w.sys.Map"%>
<%@page import="com.cre.w.sys.Charac"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/bag.css">
</head>
<body>
	<%
	Log log = new Log();
	Map mapb = new Map();
	CharacterDTO pb = (CharacterDTO)session.getAttribute("player");
	MapDTO mb = mapb.getMap(request.getParameter("m_id"));
	if (pb.getStory() < 5) {
		log.send("❌ 가방을 획득한 후 이용할 수 있습니다.", "bad");
	%>
	<jsp:forward page="game.jsp">
		<jsp:param value="normal" name="mode" />
		<jsp:param value="<%=mb.getMapId()%>" name="m_id" />
	</jsp:forward>
	<%
	} else {
		Log.turnCount++;
		log.send("[ " + Log.turnCount + " ] 가방을 열었습니다.", "normal");
	%>
	<div id="t">
		<%@include file="title.jsp"%>
	</div>
	<div id="n"></div>
	<div id="w"></div>
	<!---------------------------------------------------스크린 --------------------------------------------------->
	<div id="screen_c">
		<button id="b_btn"
			onclick="location.href='game.jsp?m_id=<%=mb.getMapId()%>&mode=normal'">닫기</button>
		<div id="bag_open">
			<div id="tool_t">도구</div>
			<div id="food_t">음식</div>
			<div id="etc_t">기타</div>
			<div id="tool">
				<%@include file="bag_tool.jsp"%>
			</div>
			<div id="food">
				<%@include file="bag_food.jsp"%>
			</div>
			<div id="etc">
				<%@include file="bag_etc.jsp"%>
			</div>
		</div>
	</div>
	<!----------------------------------------------------------------------------------------------------------------->
	<div id="e"></div>
	<div id="s"></div>
	<%
	}
	%>
</body>
</html>