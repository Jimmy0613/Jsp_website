<%@page import="java.util.ArrayList"%>
<%@page import="com.cre.w.dto.ReplyDTO"%>
<%@page import="com.cre.w.dto.MemberDTO"%>
<%@page import="com.cre.w.sys.Board"%>
<%@page import="com.cre.w.dto.PostDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function del_confirm() {
		var ok = confirm("정말 삭제하시겠습니까?");
		var formDelete = document.formDelete;
		var postNum = formDelete.postNum.value;
		var page = formDelete.page.value;
		var category = formDelete.category.value;
		if (ok) {
			formDelete.method = "post";
			formDelete.action = "ServletDelete";
			formDelete.submit();
		} else {
			location.href = "read.jsp?postNum=" + postNum + "&page=" + category
					+ "&category=" + category;
		}
	}
	function delRe_confirm() {
		var ok = confirm("정말 삭제하시겠습니까?");
		var formDelReply = document.formDelReply;
		var reNum = formDelReply.reNum.value;
		var postNum = formDelReply.postNum.value;
		var page = formDelReply.page.value;
		var category = formDelReply.category.value;
		if (ok) {
			formDelReply.method = "post";
			formDelReply.action = "ServletDelReply";
			formDelReply.submit();
		} else {
			location.href = "read.jsp?postNum=" + postNum + "&page=" + category
					+ "&category=" + category + "&reNum=" + renum;
		}
	}
</script>
</head>
<body>
	<%
	String currentPage = request.getParameter("page");
	String postNum = request.getParameter("postNum");
	String category = request.getParameter("category");
	if (category == null) {
		category = "popular";
	}
	Board board = new Board();
	MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
	board.view(postNum);
	PostDTO post = board.selectPost(postNum);
	ArrayList<ReplyDTO> reply = board.reply(postNum);
	%>
	<div class="p">
		<div id="p" style="font-weight: bolder"><%=post.getTitle()%>
		</div>
		<div id="p">
			<%
			if (category.equals("anonym")) {
			%>
			익명
			<%
			} else {
			%>
			<%=post.getWriter()%>
			<%
			}
			%>
			|
			<%=post.getpDate()%>
			| 조회수
			<%=post.getViews()%></div>
		<div id="c"><%=post.getContent()%></div>
		<div id="p">
			<div id="reply">
				<form action="ServletHeart">
					<span
						style="display: grid; grid-template-columns: 150px 100px; align-items: center; justify-content: left;">댓글
						<%=post.getReply()%>개 | 하트 <%=post.getHeart()%>개 <%
					if (loginMember != null) {
					%> <input type="hidden" name="postNum" value="<%=post.getpNum()%>">
						<input type="hidden" name="category" value="<%=category%>">
						<input type="hidden" name="page" value="<%=currentPage%>">
						<button id="heartBtn" type="submit">❤</button>
					</span>
				</form>
				<%
				}
				%>
				<hr>
				<%
				if (reply.size() != 0) {

					for (ReplyDTO r : reply) {
				%>
				<div id="p" style="color: black; font-size: 0.8em;">
					<%
					if (category.equals("anonym")) {
					%>
					익명:
					<%
					} else {
					%>
					<%=r.getWriter()%>:
					<%
					}
					%>
					<%=r.getContent()%>
					(<%=r.getrDate()%>)
					<%
					if (loginMember != null) {
						if (r.getWriter().equals(loginMember.getName())) {
					%>
					<form name="formDelReply" method="post" action="ServletDelReply"
						encType="UTF-8">
						<input type="hidden" name="postNum" value="<%=postNum%>">
						<input type="hidden" name="reNum" value="<%=r.getrNum()%>">
						<input type="hidden" name="category" value="<%=category%>">
						<input type="hidden" name="page" value="<%=currentPage%>">
						<input type="button" onclick="delRe_confirm()" value="(x)">
					</form>
					<%
					}
					}
					%>
				</div>
				<%
				}
				} else {
				%>
				아직 댓글이 없습니다.
				<%
				}
				%>
				<%
				if (loginMember != null) {
				%>
				<form class="reply" action="ServletReply">
					<input type="hidden" value="<%=postNum%>" name="postNum"> <input
						type="hidden" value="<%=category%>" name="category"> <input
						type="hidden" value="<%=currentPage%>" name="page"> <input
						name="reply" placeholder=" (댓글 작성)">
					<button type="submit">등록</button>
				</form>
				<%
				}
				%>
			</div>
		</div>
	</div>

	<%
	if (loginMember != null) {
		if (loginMember.getName().equals(post.getWriter()) || loginMember.getId().equals("manager")) {
	%>
	<button
		onclick="location.href='edit.jsp?postNum=<%=postNum%>&category=<%=category%>&page=<%=currentPage%>'">수정</button>

	<form name="formDelete" method="post" action="ServletDelete"
		encType="UTF-8">
		<input type="hidden" name="postNum" value="<%=postNum%>"> <input
			type="hidden" name="category" value="<%=category%>"> <input
			type="hidden" name="page" value="<%=currentPage%>"> <input
			type="button" onclick="del_confirm()" value="삭제">
	</form>
	<%
	}
	}
	%>
	<button
		onclick="location.href='board.jsp?category=<%=category%>&page=<%=currentPage%>'">목록</button>
</body>
</html>