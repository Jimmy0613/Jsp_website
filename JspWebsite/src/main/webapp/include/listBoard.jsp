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
	Board board = new Board();
	ArrayList<PostDTO> list = new ArrayList<>();
	int cupb;
	if (request.getParameter("page")==null) {
		cupb = 1;
	} else {
		cupb = Integer.parseInt(request.getParameter("page"));
	}
	String cgb = request.getParameter("category");
	list = board.list(cgb, cupb);
	String cgb2 = board.switchCategory(cgb);
	%>
	<div style="font-size: 1.2em; font-weight: bolder; color: black;"><%=cgb2%>게시판
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
				if (cgb.equals("anonym")) {
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
					if (b.getTitle().length() > 14) {
						title = b.getTitle().substring(0, 14) + "...";
					} else {
						title = b.getTitle();
					}
					%>
					<a title="<%=b.getTitle()%>"
						href="read.jsp?postNum=<%=b.getpNum()%>&page=<%=cupb%>&category=<%=cgb%>"><%=title%>
						<%
						if (b.getReply() > 0) {
						%> (<%=b.getReply()%>) <%
						}
						%></a>
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
	<!-- 페이징 부분 -->
	<div class="page">
		<%@ include file="pageBoard.jsp"%>
	</div>
	<!-- 페이징 부분 -->
	<div>
		<%@ include file="writeButton.jsp"%>
	</div>

</body>
</html>