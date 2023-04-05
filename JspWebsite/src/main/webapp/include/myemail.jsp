<%@page import="com.cre.w.dto.UserDTO"%>
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
	UserDTO eme = (UserDTO) session.getAttribute("loginUser");
	%>
	<span id="t">이메일</span>
	<br>
	<div class="email">
		<form action="/user/myemail">
			<%
			if (eme.getEmail().equals("")) {
			%>
			<p>
				<input name="email" type="email" placeholder="ex)abc@123.com"
					required>
				<button type="submit" style="background-color: #d2eed7;">
					등록</button>
			</p>
			<%
			} else {
			%>
			<p>
				<input name="email" type="email" value="<%=eme.getEmail()%>"
					required>
				<button type="submit" style="background-color: #d2eed7;">
					변경</button>
			</p>
			<%
			}
			%>
		</form>
	</div>

</body>
</html>