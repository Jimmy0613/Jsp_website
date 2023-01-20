<%@page import="com.cre.w.dto.LogDTO"%>
<%@page import="com.cre.w.sys.Log"%>
<%@page import="java.util.ArrayList"%>
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
	Log log = new Log();
	ArrayList<LogDTO> dtos = log.select();
	String str = "";
	String cls = "";
	int lastNum = dtos.size();
	if (dtos.size() != 0) {
		for (LogDTO l : dtos) {
			if (l.getLog_num() > lastNum - 9) {
		str = l.getLog();
		cls = l.getCls();
		switch (cls) {
		case "normal":
	%>
	<span><%=str%></span>
	<%
	break;
	case "story":
	%>
	<span style="color: skyblue"><%=str%></span>
	<%
	break;
	case "map":
	%>
	<span style="color: orange"><%=str%></span>
	<%
	break;
	case "good":
	%>
	<span style="color: lightgreen"><%=str%></span>
	<%
	break;
	case "tip":
	%>
	<span style="color: yellow"><%=str%></span>
	<%
	break;
	case "bad":
	%>
	<span style="color: brown"><%=str%></span>
	<%
	break;
	case "speech":
	%>
	<span style="color: pink"><%=str%></span>
	<%
	break;
	}
	%>
	<br>
	<%
	}
	}
	}
	%>
</body>
</html>