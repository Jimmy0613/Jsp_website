<%@page import="com.cre.w.dto.MapDTO"%>
<%@page import="com.cre.w.dto.CharacterDTO"%>
<%@page import="com.cre.w.Log"%>
<%@page import="com.cre.w.Map"%>
<%@page import="com.cre.w.Charac"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/bag.css">
</head>
<body>
	<%
	Log logb = new Log();
	Map mapb = new Map();
	CharacterDTO pb = (CharacterDTO) session.getAttribute("player");
	String midb = (String) session.getAttribute("m_id");
	String midb_jsp = "/" + midb + ".jsp";
	if (pb.getStory() < 5) {
		logb.send("❌ 가방을 획득한 후 이용할 수 있습니다.", "bad");
	%>
	<jsp:forward page="<%=midb_jsp%>">
		<jsp:param value="normal" name="mode" />
	</jsp:forward>
	<%
	} else {
	Log.turnCount++;
	logb.send("[ " + Log.turnCount + " ] 가방을 열었습니다.", "normal");
	%>
	<button id="b_btn"
		onclick="location.href='<%=midb_jsp%>?mode=normal'">닫기</button>
	<div id="bag_open">
		<div id="tool_t">도구</div>
		<div id="food_t">음식</div>
		<div id="etc_t">기타</div>
		<div id="tool">
			<%@include file="/include/bag_tool.jsp"%>
		</div>
		<div id="food">
			<%@include file="/include/bag_food.jsp"%>
		</div>
		<div id="etc">
			<%@include file="/include/bag_etc.jsp"%>
		</div>
	</div>
	<%
	}
	%>
</body>
</html>