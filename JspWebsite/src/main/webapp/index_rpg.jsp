<%@page import="com.cre.w.dto.UserDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jsp_rpg_v0.0.4</title>
<%
/* CSS/JS 파일 캐시 방지 */
String styleCss = application.getRealPath("/css/common_rpg.css");
File style = new File(styleCss);
Date lastModifiedStyle = new Date(style.lastModified());
SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMddhhmmssSSS");
%>
<link rel="stylesheet"
	href="/css/common.css?ver=<%=fmt.format(lastModifiedStyle)%>">
<link rel="stylesheet"
	href="/css/screen.css?ver=<%=fmt.format(lastModifiedStyle)%>">
<link rel="stylesheet"
	href="/css/system.css?ver=<%=fmt.format(lastModifiedStyle)%>">
</head>
<body>
	<div class="container">
		<div class="header">
			<div class="title"></div>
			<div class="menu">
				<%@include file="/include/menuTop.jsp"%>
			</div>
		</div>
		<div class="content">
			<div id="gamebox">
				<div id="screen">
					<%@ include file="/include/sc_index.jsp"%>
				</div>
				<div id="system">
					<%
					UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
								String loginInfo = "🙂 먼저 로그인해주세요.";
								if (loginUser != null) {
									loginInfo = "🙂 " + loginUser.getId() + "(" + loginUser.getName() + ") 님";
								}
					%>
					<div id="s_info">
						<div id="c_mode">&nbsp;&nbsp;🍀 홈</div>
					</div>
					<div id="s_menu_right_t">메뉴</div>
					<div id="s_content"></div>

					<%
					if (loginUser == null) {
					%>
					<div id="s_menu_right">
						<div class="icon" id="icon1">
							<a href="/index_rpg.jsp"><img src="/img/home.png"></a>
						</div>
						<b class="icon_t" id="icon1_t">홈</b>
						<div class="icon" id="icon2">
							<a href="/join.jsp?location=/index_rpg.jsp"><img
								src="/img/join.png"></a>
						</div>
						<b class="icon_t" id="icon2_t">가입</b>

						<div class="icon" id="icon3">
							<a href="/login.jsp?location=/index_rpg.jsp"><img
								src="/img/login.png"></a>
						</div>
						<b class="icon_t" id="icon3_t">로그인</b>
					</div>
					<div id="s_banner_bot"><%=loginInfo%></div>
					<%
					} else {
					%>
					<div id="s_menu_right">
						<div class="icon" id="icon1">
							<a href="/index_rpg.jsp"><img src="/img/home.png"></a>
						</div>
						<b class="icon_t" id="icon1_t">홈</b>
						<div class="icon" id="icon2">
							<a href="/character.jsp"><img src="/img/charac.png"></a>
						</div>
						<b class="icon_t" id="icon2_t">캐릭터</b>

						<div class="icon" id="icon3">
							<a href="/user/logout?location=/index_rpg.jsp"><img
								src="/img/logout.png"></a>
						</div>
						<b class="icon_t" id="icon3_t">로그아웃</b>
					</div>
					<div id="s_banner_bot">
						<%=loginInfo%>
					</div>
					<%
					}
					%>
				</div>
			</div>
		</div>
	</div>
</body>
</html>