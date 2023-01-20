<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.ArrayList"%>
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
	String ky = request.getParameter("key");
	String kw = request.getParameter("keyword");
	String str = request.getParameter("page");
	int cPage1 = 1; //현재페이지
	if (str != null) {
		cPage1 = Integer.parseInt(str);
	}
	String wh = "";
	String cg1 = request.getParameter("category");
	switch (cg1) {
	case "general":
	case "anonym":
		wh = String.format("& category='%s'",cg1);
		break;
	default:
		wh = "";
	}
	Page p1 = new Page();
	String sql = String.format("where %s like '%%%s%%' %s", ky, kw, wh);
	int tp1 = p1.getTotalPage(sql); //총 페이지수
	int tpb = 0;//총 페이지블럭 수(1,2,3,4,5) (6,7,8,9,10) 이런 게 블럭..
	int pb = 0; //몇번째 페이지블럭인지 1~5페이지면 첫번째블럭, 6~10페이지면 두번째 블럭..

	if (cPage1 % Page.PAGE_BLOCK == 0) { //현재 페이지를 페이지블럭 단위(지금은 5)로 나눴을때 떨어지면(==현재 페이지가 각 페이지 블럭의 마지막 페이지이면==5, 10, 15 이런 애들)
		pb = cPage1 / Page.PAGE_BLOCK; //현재 페이지 블럭은 pb번째 블럭이다.
		tpb = tp1 / Page.PAGE_BLOCK; //전체 페이지 블럭 수는 이거다. 이거 토탈페이지 수 구하는 거랑 원리가 같음
	} else {
		pb = cPage1 / Page.PAGE_BLOCK + 1;
		tpb = tp1 / Page.PAGE_BLOCK + 1;
	}
	//(처음) 관련================================================
	if (cPage1 > 1) {//이건 단순히 첫페이지로 가면 되는거라 쉬움.
	%>
	<a href="search.jsp?page=1&category=<%=cg1%>&key=<%=ky %>&keyword=<%=kw %>"
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
		href="search.jsp?page=<%=((pb - 1) * Page.PAGE_BLOCK)%>&category=<%=cg1%>&key=<%=ky %>&keyword=<%=kw %>"
		style="font-weight: bolder; font-size: 0.8em;">이전</a>
	<%
	} else if (cPage1 > 1) { //아니면 그냥 이전 페이지. 근데 2페이지까지만 1페이지면 이전 페이지가 없으니까ㅣ.
	%>
	<a href="search.jsp?page=<%=(cPage1 - 1)%>&category=<%=cg1%>&key=<%=ky %>&keyword=<%=kw %>"
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
		href="search.jsp?page=<%=i%>&category=<%=cg1%>&key=<%=ky %>&keyword=<%=kw %>"><%=i%></a>
	<%
	} else {
	%>
	<a href="search.jsp?page=<%=i%>&category=<%=cg1%>&key=<%=ky %>&keyword=<%=kw %>"><%=i%></a>
	<%
	}
	}

	//(다음) 관련 ===============================================
	if (cPage1 % Page.PAGE_BLOCK == 0) {//현재 페이지가 각 페이지 블럭의 마지막 페이지이면 다음 페이지로 넘어감
	%>
	<a
		href="search.jsp?page=<%=(pb * Page.PAGE_BLOCK + 1)%>&category=<%=cg1%>&key=<%=ky %>&keyword=<%=kw %>"
		style="font-weight: bolder; font-size: 0.8em;">다음</a>
	<%
	} else if (cPage1 < tp1) { //그게 아니고 && 마지막 페이지보다 작으면 그냥 다음페이지로 넘어감
	%>
	<a href="search.jsp?page=<%=cPage1 + 1%>&category=<%=cg1%>&key=<%=ky %>&keyword=<%=kw %>"
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
	<a href="search.jsp?page=<%=tp1%>&category=<%=cg1%>&key=<%=ky %>&keyword=<%=kw %>"
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