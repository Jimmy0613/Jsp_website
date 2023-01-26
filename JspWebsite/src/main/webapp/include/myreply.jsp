<%@page import="com.cre.w.dto.ReplyDTO"%>
<%@page import="com.cre.w.dto.MemberDTO"%>
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
	MemberDTO me2 = (MemberDTO) session.getAttribute("loginMember");
	ArrayList<ReplyDTO> myreply = (ArrayList<ReplyDTO>)session.getAttribute("reply");
	%>
	<span id="t">내가 쓴 댓글</span>
	<br>
	<div class="list">
		<div class="list_m">
			<div class="list_n" style="background-color: white;">
				<div></div>
				<div>게시판</div>
				<div>내용</div>
				<div>♡</div>
				<div>글번호</div>
				<hr>
			</div>
			<div class="list_z">
				<%
				if (myreply.size() != 0) {
					Board bo2 = new Board();
					for (ReplyDTO r : myreply) {
						String pNum = r.getpNum() + "";
						PostDTO po = bo2.selectPost(pNum);
						String category = "";
						if (po == null) {
					category = " ?? ";
						} else {
					category = bo2.switchCategory(po.getCategory());
						}
						String content = "";
						if (r.getContent().length() > 16) {
					content = r.getContent().substring(0, 16) + "...";
						} else {
					content = r.getContent();
						}
				%>
				<div class="list_n">
					<div></div>
					<div><%=category%></div>
					<div style="text-align: left;">
						<%
						if (po == null) {
						%>
						<a title="삭제된 글입니다."><%=r.getContent()%></a>
						<%
						} else {
						%>
						<a
							href="/web/read?postNum=<%=r.getpNum()%>&category=<%=po.getCategory()%>&page=1"><%=r.getContent()%></a>
						<%
						}
						%>
					</div>
					<div></div>
					<div><%=pNum%></div>
				</div>
				<%
				}
				%>
				<br>
				<%
				} else {
				%>
				<div>작성한 댓글이 없습니다.</div>
				<%
				}
				%>
			</div>
			<div class="page">
				<%@ include file="pageMypage.jsp"%>
			</div>
		</div>
	</div>
</body>
</html>