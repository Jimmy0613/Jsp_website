<%@page import="com.cre.w.dto.MemberDTO"%>
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
	MemberDTO member = (MemberDTO) session.getAttribute("loginMember");
	%>
	<div class="member_info">
		<%
		if (member == null) {
		%>
		<%@ include file="login.jsp"%>
		<%
		} else {
		%>
		<div class="login_info">
			<div><%=member.getInfo()%>
			</div>
			<div id="f">
				<button id="memberinfo" onclick="location.href='mypage.jsp'">회원정보</button>
				<form id="logout" action="ServletLogout">
					<input type="hidden" name="location" value="../index.jsp">
					<button type="submit">로그아웃</button>
				</form>
			</div>
		</div>
		<%
		}
		%>
		<hr>
	</div>

</body>
</html>