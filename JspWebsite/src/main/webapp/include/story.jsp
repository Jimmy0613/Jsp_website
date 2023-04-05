<%@page import="com.cre.w.dto.CharacterDTO"%>
<%@page import="com.cre.w.Charac"%>
<%@page import="com.cre.w.dto.StoryDTO"%>
<%@page import="com.cre.w.Story"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.File"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지난 이야기</title>
<%
String styleCss = application.getRealPath("/css/common.css");
File style = new File(styleCss);
Date lastModifiedStyle = new Date(style.lastModified());
SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMddhhmmssSSS");
%>
<link rel="stylesheet"
	href="/css/popup.css?ver=<%=fmt.format(lastModifiedStyle)%>">
</head>
<body>
	<%
	Story story = new Story();
	CharacterDTO player = (CharacterDTO) session.getAttribute("player");
	ArrayList<StoryDTO> dtos = story.select();
	ArrayList<StoryDTO> dtosP = story.load(player);

	if (dtosP.size() > 1) {
		for (StoryDTO s : dtosP) {
			if (s.getStNum() != -1) {
	%>
	<span><%=s.getStNum()%>.<%=s.getTitle()%>: <%=s.getDesc()%></span>
	<br>
	<%
	}
	}
	if (dtos.get(dtos.size() - 1).getStNum() == player.getStory()) {
	%>
	<br>
	<span> 🎊 모든 이야기를 완료했습니다!</span>
	<br>
	<%
	}
	} else {
	%>
	<span> ❌ 아직 완료한 이야기가 없습니다.</span>
	<br>
	<%
	}
	%>
</body>
</html>