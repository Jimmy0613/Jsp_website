<%@page import="com.cre.w.dto.MapDTO"%>
<%@page import="com.cre.w.dto.CharacterDTO"%>
<%@page import="com.cre.w.sys.Map"%>
<%@page import="com.cre.w.sys.Log"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/map.css">
</head>
<body>
	<%
	Map mapm = new Map();
	CharacterDTO pm = (CharacterDTO) session.getAttribute("player");
	String midm = (String)session.getAttribute("m_id");
	String midm_jsp = midm + ".jsp";
	Log logm = new Log();
	if (pm.getStory() < 6) {
		logm.send("❌ 지도를 획득한 후 이용할 수 있습니다.", "bad");
	%>
	<jsp:forward page="<%=midm_jsp%>">
		<jsp:param value="normal" name="mode" />
	</jsp:forward>
	<%
	} else {
		logm.send("[ " + Log.turnCount + " ] 지도를 펼쳤습니다.", "normal");
	if (pm.getStory() < 7) {
		pm.setStory(7);
		pm.setExp(pm.getExp() + 5);
		logm.send("🎉 새로운 이야기를 완료했습니다. (경험치 +5)", "story");
		logm.send("🏃‍♂️ 새로운 지역이 열렸습니다. (마당)", "map");
	}
	Log.turnCount++;
	%>
	<button id="m_btn"
		onclick="location.href='<%=midm_jsp%>?mode=normal'">접기</button>
	<div id="map_open">
		<%@include file="map_house.jsp"%>
	</div>
	<%
	}
	%>
</body>
</html>