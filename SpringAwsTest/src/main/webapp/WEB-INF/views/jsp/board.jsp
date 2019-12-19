<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<title>W3.CSS</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<body>

	<div class="w3-container">
		<h2>${board.BOARD_TITLE }</h2>

		<table class="w3-table w3-bordered">
			<tr>
				<th>작성자: ${board.BOARD_WRITER }</th>
				<th>작성일: ${board.BOARD_DATE }</th>
			</tr>
			<tr>
				<td colspan="3">${board.BOARD_CONTENT }</td>
			</tr>
		</table>
		<c:if test="${sessionScope.login_id eq board.BOARD_WRITER}">
			<div style="padding-left: 93.3%;">
				<button
					onclick="location.href='/delete_board?no=${board.BOARD_NO}'"
					class="w3-button w3-green w3-large">삭제</button>
			</div>
		</c:if>
		<a href="/">목록보기</a>
	</div>

</body>
</html>
