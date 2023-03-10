<%@page import="com.cre.w.Board"%>
<%@page import="com.cre.w.dto.PostDTO"%>
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
	ArrayList<PostDTO> list = (ArrayList<PostDTO>)request.getAttribute("list");
	%>
	<div style="font-size: 1.2em; font-weight: bolder; color: black;">인기글
	</div>
	<br>
	<div class="list_m">
		<div class="list_n" style="color: black;">
			<div>작성자</div>
			<div>제목</div>
			<div>♡</div>
			<div>조회수</div>
			<hr>
		</div>
		<div class="list_z">
			<%
			if (list.size() != 0) {
				for (PostDTO b : list) {
			%>
			<div class="list_n" style="background-color: white;">
				<%
				if (b.getCategory().equals("anonym")) {
				%>
				<div>익명</div>
				<%
				} else {
				%>
				<div><%=b.getWriter()%></div>
				<%
				}
				%>
				<div id="t">
					<%
					String title = "";
					if (b.getTitle().length() > 16) {
						title = b.getTitle().substring(0, 16) + "...";
					} else {
						title = b.getTitle();
					}
					%>
					<a title="<%=b.getTitle()%>"
						href="/board/read?postNum=<%=b.getpNum()%>"><%=title%>
						<%if(b.getReply()>0){ %>
						(<%=b.getReply() %>)
						<%} %>
						</a>
				</div>
				<div><%=b.getHeart()%></div>
				<div><%=b.getViews()%></div>
			</div>
			<%
			}
			} else {
			%>
			아직 글이 없습니다.
			<%
			}
			%>
		</div>
	</div>
</body>
</html>