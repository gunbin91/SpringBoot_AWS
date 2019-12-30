<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<title>W3.CSS</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<!-- jQuery -->
<script src="//code.jquery.com/jquery.min.js"></script>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<body>

	<div class="w3-container">
		<h2>${board.board_title }</h2>

		<table class="w3-table w3-bordered">
			<tr>
				<th>작성자: ${board.board_writer }</th>
				<th>작성일: ${board.board_date }</th>
			</tr>
			<tr>
				<td colspan="3" style="white-space: pre;"><c:out
						value="${board.board_content }" /></td>
			</tr>
		</table>
		<c:if test="${sessionScope.login_id eq board.board_writer}">
			<div style="padding-left: 93.3%;">
				<button onclick="location.href='/delete_board?no=${board.board_no}'"
					class="btn btn-danger">삭제</button>
			</div>
		</c:if>
		<a href="/">목록보기</a>
	</div>

</body>
</html>
