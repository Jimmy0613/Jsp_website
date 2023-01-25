<%@page import="com.cre.w.dto.PostDTO"%>
<%@page import="com.cre.w.sys.Board"%>
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
	String key = request.getParameter("key");
	String keyword = request.getParameter("keyword");
	String category = request.getParameter("category");
	if (category == null) {
		category = "all";
	}
	int cups;
	if (request.getParameter("page") == null) {
		cups = 1;
	} else {
		cups = Integer.parseInt(request.getParameter("page"));
	}
	Board board = new Board();
	String where = "";
	switch (category) {
		case "all" :
			where = String.format("order by post_num desc limit %d, %d", (cups - 1) * Page.PER_PAGE, Page.PER_PAGE);
			break;
		case "general" :
		case "anonym" :
			where = String.format("where category = '%s' order by post_num desc limit %d, %d", category,
			(cups - 1) * Page.PER_PAGE, Page.PER_PAGE);
			break;
	}
	ArrayList<PostDTO> searchList = board.searchList(key, keyword, where);
	%>
	<div style="font-size: 1.2em; font-weight: bolder; color: black;">검색
	</div>
	<br>
	<div id="search">
		<form>
			<span> <select name="key">
					<option value="title">제목</option>
					<option value="content">내용</option>
					<option value="writer">작성자</option>
			</select> <select name="category">
					<option value="all">전체</option>
					<option value="general">자유</option>
					<option value="anonym">익명</option>
			</select> <input name="keyword" value="<%=keyword%>">
				<button type="submit">검색</button>
			</span>
		</form>
	</div>
	<div class="list_s">
		<div class="list_n" style="color: black;">
			<div>게시판</div>
			<div>작성자</div>
			<div>제목</div>
			<div>♡</div>
			<div>조회수</div>
			<hr>
		</div>
		<div class="list_z">
			<%
			if (searchList.size() != 0) {
				for (PostDTO p : searchList) {
			%>
			<div class="list_n" style="background-color: white;">
				<%
				if (p.getCategory().equals("anonym")) {
				%>
				<div>익명</div>
				<div>익명</div>
				<%
				} else {
				%>
				<div>자유</div>
				<div><%=p.getWriter()%></div>
				<%
				}
				%>
				<div id="t">
					<%
					String title = "";
					if (p.getTitle().length() > 10) {
						title = p.getTitle().substring(0, 10) + "...";
					} else {
						title = p.getTitle();
					}
					%>
					<script>
						function openPost(url){
							window.open(url, "_blank", "left=100px, width=1000, height=1000");
						}
					</script>
					<a style="cursor:pointer;" title="<%=p.getTitle()%>"
						onclick="openPost('/read.jsp?postNum=<%=p.getpNum()%>&page=1&category=<%=p.getCategory()%>')" ><%=title%>
						<%
						if (p.getReply() > 0) {
						%> (<%=p.getReply()%>) <%
						}
						%></a>
				</div>
				<div><%=p.getHeart()%></div>
				<div><%=p.getViews()%></div>
			</div>
			<%
			}
			} else {
			%>
			검색 결과가 없습니다.
			<%
			}
			%>
		</div>
	</div>
	<!-- 페이징 부분 -->
	<div class="page">
		<%@ include file="pageSearch.jsp"%>
	</div>
	<!-- 페이징 부분 -->

</body>
</html>