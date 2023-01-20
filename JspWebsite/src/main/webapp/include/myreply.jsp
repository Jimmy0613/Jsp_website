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
	<script>
	function selectAll(selectAll)  {
		  const checkboxes = document.getElementsByName("delmyreply");
		  checkboxes.forEach((checkbox) => {
		    checkbox.checked = selectAll.checked;
		  })
	}
</script>
	<form action="delMyreply.jsp">
		<span id="t">내가 쓴 댓글</span> <br>
		<div class="list">
			<div class="list_m">
				<div class="list_n" style="background-color: white;">
					<div>
						<input type="checkbox" name="all" value="selectall"
							onclick="selectAll(this)">
					</div>
					<div>게시판</div>
					<div>내용</div>
					<div>♡</div>
					<div>글번호</div>
					<hr>
				</div>
				<div class="list_z">
					<%
					MemberDTO me2 = (MemberDTO) session.getAttribute("loginMember");
					Board bo2 = new Board();
					int cupm;
					if (request.getParameter("page").equals(null)) {
						cupm = 1;
					} else {
						cupm = Integer.parseInt(request.getParameter("page"));
					}
					ArrayList<ReplyDTO> myreply = bo2.myreply(me2.getId(), cupm);
					if (myreply.size() != 0) {
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
						<div>
							<input type="checkbox" name="delmyreply" value="<%=r.getrNum()%>">
						</div>
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
								href="read.jsp?postNum=<%=r.getpNum()%>&category=<%=po.getCategory()%>&page=1"><%=r.getContent()%></a>
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
					<button type="submit"
						style="width: 40px; height: 25px; font-size: 0.7em; background-color: #d2eed7;">삭제</button>
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
	</form>
</body>
</html>