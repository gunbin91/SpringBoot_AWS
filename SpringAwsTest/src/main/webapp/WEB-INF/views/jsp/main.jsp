<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<title>AWS 게시판</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<body>
	<script>
		if ("${join}" == "Y") {
			alert("회원가입 완료");
			location.href = "/";
		}

		if ("${login}" == "F") {
			alert("로그인 실패");
			location.href = "/";
		}

		if ("${write}" == "F") {
			alert("로그인 후 이용가능합니다.");
			location.href = "/";
		}
	</script>

	<div class="w3-container">
		<h1>&nbsp;</h1>
		<c:choose>
			<c:when test="${!empty sessionScope.login_id}">${sessionScope.login_id} 님 로그인 / <a href="/logout">Logout</a></c:when>
			<c:otherwise>
				<button
					onclick="document.getElementById('id01').style.display='block'"
					class="w3-button w3-green w3-large">로그인</button>
				<button
					onclick="document.getElementById('id02').style.display='block'"
					class="w3-button w3-green w3-large">회원가입</button>
			</c:otherwise>
		</c:choose>

		<!-- 로그인 모달 -->
		<form action="/login" method="post">
			<div id="id01" class="w3-modal">
				z
				<div class="w3-modal-content w3-card-4 w3-animate-zoom"
					style="max-width: 600px">

					<div class="w3-center">
						<br> <span
							onclick="document.getElementById('id01').style.display='none'"
							class="w3-button w3-xlarge w3-transparent w3-display-topright"
							title="Close Modal">×</span>
					</div>

					<form class="w3-container" action="/action_page.php">
						<div class="w3-section">
							<label><b>Id</b></label> <input
								class="w3-input w3-border w3-margin-bottom" type="text"
								placeholder="Enter Id" name="id" required> <label><b>Password</b></label>
							<input class="w3-input w3-border" type="text"
								placeholder="Enter Password" name="pass" required>
							<button class="w3-button w3-block w3-green w3-section w3-padding"
								type="submit">Login</button>
						</div>
					</form>

					<div class="w3-container w3-border-top w3-padding-16 w3-light-grey">
						<button
							onclick="document.getElementById('id01').style.display='none'"
							type="button" class="w3-button w3-red">Cancel</button>
					</div>

				</div>
			</div>
		</form>
		<!-- 로그인 모달 -->

		<!-- 회원가입 모달 -->
		<form action="/join" method="post">
			<div id="id02" class="w3-modal">
				<div class="w3-modal-content w3-card-4 w3-animate-zoom"
					style="max-width: 600px">

					<div class="w3-center">
						<br> <span
							onclick="document.getElementById('id02').style.display='none'"
							class="w3-button w3-xlarge w3-transparent w3-display-topright"
							title="Close Modal">×</span>
					</div>

					<form class="w3-container" action="/action_page.php">
						<div class="w3-section">
							<label><b>Id</b></label> <input
								class="w3-input w3-border w3-margin-bottom" type="text"
								placeholder="Enter Id" name="id" required> <label><b>Username</b></label>
							<input class="w3-input w3-border w3-margin-bottom" type="text"
								placeholder="Enter Username" name="name" required> <label><b>Password</b></label>
							<input class="w3-input w3-border" type="text"
								placeholder="Enter Password" name="pass" required>
							<button class="w3-button w3-block w3-green w3-section w3-padding"
								type="submit">Join</button>
						</div>
					</form>

					<div class="w3-container w3-border-top w3-padding-16 w3-light-grey">
						<button
							onclick="document.getElementById('id02').style.display='none'"
							type="button" class="w3-button w3-red">Cancel</button>
					</div>

				</div>
			</div>
		</form>
		<!-- 회원가입 모달 -->
	</div>

	<h3>&nbsp;</h3>

	<!-- 게시판 -->
	<div class="w3-container">
		<h2>게시판</h2>
		<p>The w3-border class adds a border around the table.</p>

		<table class="w3-table w3-striped w3-border">
			<tr>
				<th>No</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
			</tr>
			<c:forEach var="board" items="${board_list }">
				<tr onclick="location.href='/board?no=${board.BOARD_NO}'" style="cursor:pointer;">
					<td>${board.NUM }</td>
					<td>${board.BOARD_TITLE }</td>
					<td>${board.BOARD_WRITER }</td>
					<td>${board.BOARD_DATE }</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<!-- 게시판 -->

	<h3>&nbsp;</h3>

	<!-- 글쓰기 -->
	<div style="padding-left: 93.3%;">
		<button
			onclick="document.getElementById('id03').style.display='block'"
			class="w3-button w3-green w3-large">글쓰기</button>
	</div>
	<!-- 글쓰기 모달 -->
	<form action="/write" method="post">
		<div id="id03" class="w3-modal">
			<div class="w3-modal-content w3-card-4 w3-animate-zoom"
				style="max-width: 600px">

				<div class="w3-center">
					<br> <span
						onclick="document.getElementById('id03').style.display='none'"
						class="w3-button w3-xlarge w3-transparent w3-display-topright"
						title="Close Modal">×</span>
				</div>

				<form class="w3-container" action="/action_page.php">
					<div class="w3-section">
						<label><b>제목</b></label> <input
							class="w3-input w3-border w3-margin-bottom" type="text"
							placeholder="Enter Id" name="title" required> <label><b>내용</b></label>
						<textarea rows="10" cols="66" name="content" required></textarea>
						<button class="w3-button w3-block w3-green w3-section w3-padding"
							type="submit">작성하기</button>
					</div>
				</form>

				<div class="w3-container w3-border-top w3-padding-16 w3-light-grey">
					<button
						onclick="document.getElementById('id03').style.display='none'"
						type="button" class="w3-button w3-red">Cancel</button>
				</div>

			</div>
		</div>
	</form>
	<!-- 글쓰기 모달 -->
	<!-- 글쓰기 -->

</body>
</html>
