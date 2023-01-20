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
	String[] delList = request.getParameterValues("delmypost");
	if (delList != null) {
		session.setAttribute("delList", delList);
	%>
	<script>
		var ok = confirm('선택한 글을 모두 삭제하시겠습니까?');
		if (ok) {
			location.href = 'proc/delMypostProc.jsp';
		} else {
			location.href = 'mypage.jsp';
		}
	</script>
	<%
	} else {
	%>
	<script>
		location.href = 'mypage.jsp'
	</script>
	<%
	}
	%>
</body>
</html>