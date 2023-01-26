<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.cre.w.dto.MemberDTO"%>
<%@page import="com.cre.w.sys.Board"%>
<%@page import="com.cre.w.sys.Page"%>
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
	String md = request.getParameter("mode");
	int cPage1 = (Integer)request.getAttribute("page");
	int tp1 = (Integer)request.getAttribute("totalPage");
	int tpb = (Integer)request.getAttribute("totalPb");
	int pb = (Integer)request.getAttribute("currentPb");
	//(처음) 관련================================================
	if (cPage1 > 1) {//이건 단순히 첫페이지로 가면 되는거라 쉬움.
	%>
	<a href="/web/mypage?page=1&mode=<%=md%>"
		style="font-weight: bolder; font-size: 0.8em;">처음</a>
	<%
	} else { //첫페이지면 안눌리게
	%>
	<a style="font-weight: bolder; font-size: 0.8em;">처음</a>
	<%
	}
	//========================================================
	//(이전) 관련================================================
	if (cPage1 > 1) { //(이전)은 항상 표시는 됨. 근데 1페이지면 안눌림.
	if (cPage1 % Page.PAGE_BLOCK == 1) { //현재 페이지가 각 페이지 블럭의 첫 페이지면(1,6,11 같은 페이지) 이전 블럭으로 넘어감
	%>
	<a
		href="/web/mypage?page=<%=((pb - 1) * Page.PAGE_BLOCK)%>&mode=<%=md%>"
		style="font-weight: bolder; font-size: 0.8em;">이전</a>
	<%
	} else if (cPage1 > 1) { //아니면 그냥 이전 페이지. 근데 2페이지까지만 1페이지면 이전 페이지가 없으니까ㅣ.
	%>
	<a href="/web/mypage?page=<%=(cPage1 - 1)%>&mode=<%=md%>"
		style="font-weight: bolder; font-size: 0.8em;">이전</a>
	<%
	}
	} else {
	%>
	<a style="font-weight: bolder; font-size: 0.8em;">이전</a>
	<%
	}
	//=========================================================
	for (int i = (pb - 1) * Page.PAGE_BLOCK + 1; i < ((pb - 1) * Page.PAGE_BLOCK + Page.PAGE_BLOCK + 1) && i <= tp1; i++) {
	%>
	<%
	if (i == cPage1) {//그냥 현재 페이지면 찐하게 표시하는거.
	%>
	<a style="font-weight: bolder;"
		href="/web/mypage?page=<%=i%>&mode=<%=md%>"><%=i%></a>
	<%
	} else {
	%>
	<a href="/web/mypage?page=<%=i%>&mode=<%=md%>"><%=i%></a>
	<%
	}
	}

	//(다음) 관련 ===============================================
	if (cPage1 % Page.PAGE_BLOCK == 0) {//현재 페이지가 각 페이지 블럭의 마지막 페이지이면 다음 페이지로 넘어감
	%>
	<a href="/web/mypage?page=<%=(pb * Page.PAGE_BLOCK + 1)%>&mode=<%=md%>"
		style="font-weight: bolder; font-size: 0.8em;">다음</a>
	<%
	} else if (cPage1 < tp1) { //그게 아니고 && 마지막 페이지보다 작으면 그냥 다음페이지로 넘어감
	%>
	<a href="/web/mypage?page=<%=cPage1 + 1%>&mode=<%=md%>"
		style="font-weight: bolder; font-size: 0.8em;">다음</a>
	<%
	} else { //이것도 저것도 아니면 그냥 표시만 되고 눌리진 않음.
	%>
	<a style="font-weight: bolder; font-size: 0.8em;">다음</a>
	<%
	}
	//===========================================================
	//(마지막) 관련================================================
	if (cPage1 < tp1) {//이건 단순히 첫페이지로 가면 되는거라 쉬움.
	%>
	<a href="/web/mypage?page=<%=tp1%>&mode=<%=md%>"
		style="font-weight: bolder; font-size: 0.8em;">마지막</a>
	<%
	} else { //마지막페이지면 안눌리게
	%>
	<a style="font-weight: bolder; font-size: 0.8em;">마지막</a>
	<%
	}
	//========================================================
	%>
</body>
</html>