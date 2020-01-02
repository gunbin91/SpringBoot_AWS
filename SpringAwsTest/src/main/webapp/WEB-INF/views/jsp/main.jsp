<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<title>AWS 게시판</title>
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

		if ("${S3}" != "") {
			alert("S3버킷전송 성공[ ${S3} ]");
			location.href = "/";
		}
	</script>

	<div class="w3-container">
		<h1>&nbsp;</h1>
		<c:choose>
			<c:when test="${!empty sessionScope.login_id}">${sessionScope.login_id} 님 로그인 / <a
					href="/logout">Logout</a>
			</c:when>
			<c:otherwise>
				<button
					onclick="document.getElementById('id01').style.display='block'"
					class="btn btn-primary">로그인</button>
				<button
					onclick="document.getElementById('id02').style.display='block'"
					class="btn btn-primary">회원가입</button>
			</c:otherwise>
		</c:choose>

		<!-- 로그인 모달 -->
		<div class="container">
			<form action="/login" method="post">
				<div id="id01" class="w3-modal">
					<div class="w3-modal-content w3-card-4 w3-animate-zoom"
						style="max-width: 600px">

						<div class="w3-center">
							<br> <span
								class="w3-xlarge w3-transparent w3-display-topleft">Login</span>
							<span
								onclick="document.getElementById('id01').style.display='none'"
								class="w3-button w3-xlarge w3-transparent w3-display-topright"
								title="Close Modal">×</span>
						</div>
						<div class="w3-section" style="padding: 3%;">
							<div class="form-group">
								<label><b>Id</b></label> <input class="form-control" type="text"
									placeholder="Enter Id" name="id" required>
							</div>
							<div class="form-group">
								<label><b>Password</b></label> <input class="form-control"
									type="text" placeholder="Enter Password" name="pass" required>
							</div>
						</div>

						<div
							class="w3-container w3-border-top w3-padding-16 w3-light-grey">
							<div style="float: right;">
								<button class="btn btn-primary" type="submit">Login</button>
								<button
									onclick="document.getElementById('id01').style.display='none'"
									type="button" class="btn btn-danger">Cancel</button>
							</div>
						</div>

					</div>
				</div>
			</form>
		</div>
		<!-- 로그인 모달 -->

		<!-- 회원가입 모달 -->
		<div class="container">
			<form action="/join" method="post">
				<div id="id02" class="w3-modal">
					<div class="w3-modal-content w3-card-4 w3-animate-zoom"
						style="max-width: 600px">

						<div class="w3-center">
							<br> <span
								class="w3-xlarge w3-transparent w3-display-topleft">Join</span>
							<span
								onclick="document.getElementById('id02').style.display='none'"
								class="w3-button w3-xlarge w3-transparent w3-display-topright"
								title="Close Modal">×</span>
						</div>
						<div class="w3-section" style="padding: 3%;">
							<div class="form-group">
								<label><b>Id</b></label> <input class="form-control" type="text"
									placeholder="Enter Id" name="id" required>
							</div>
							<div class="form-group">
								<label><b>Name</b></label> <input class="form-control"
									type="text" placeholder="Enter Name" name="name" required>
							</div>
							<div class="form-group">
								<label><b>Password</b></label> <input class="form-control"
									type="text" placeholder="Enter Password" name="pass" required>
							</div>
						</div>

						<div
							class="w3-container w3-border-top w3-padding-16 w3-light-grey">
							<div style="float: right;">
								<button class="btn btn-primary" type="submit">Join</button>
								<button
									onclick="document.getElementById('id02').style.display='none'"
									type="button" class="btn btn-danger">Cancel</button>
							</div>
						</div>

					</div>
				</div>
			</form>
		</div>
		<!-- 회원가입 모달 -->
	</div>

	<h3>&nbsp;</h3>

	<!-- 게시판 -->
	<div class="w3-container container">
		<div class="col-xs-12" style="margin: 15px auto;">
			<label style="font-size: 20px;"><span
				class="glyphicon glyphicon-list-alt"></span>게시글 목록</label>
			<button class="btn btn-primary" style="float: right;"
				onclick="document.getElementById('id03').style.display='block'">글쓰기</button>
		</div>

		<table class="w3-table w3-striped w3-border">
			<tr>
				<th>No</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
			</tr>
			<c:forEach var="board" items="${board_list }">
				<tr onclick="location.href='/board?no=${board.board_no}'"
					style="cursor: pointer;">
					<td>${board.num }</td>
					<td>${board.board_title }</td>
					<td>${board.board_writer }</td>
					<td><fmt:formatDate value="${board.board_date }"
							pattern="yyyy.MM.dd HH:mm:ss" /></td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<!-- 게시판 -->

	<h3>&nbsp;</h3>

	<!-- 글쓰기 모달 -->
	<div class="container">
		<form action="/write" method="post">
			<div id="id03" class="w3-modal">
				<div class="w3-modal-content w3-card-4 w3-animate-zoom"
					style="max-width: 600px">

					<div class="w3-center">
						<br> <span
							class="w3-xlarge w3-transparent w3-display-topleft">
							<div class="col-xs-12" style="margin: 15px auto;">
								<label style="font-size: 20px;"><span
									class="glyphicon glyphicon-edit"></span>게시글 작성</label>
							</div>
						</span>
						<!-- <span class="w3-xlarge w3-transparent w3-display-topleft">글쓰기</span> -->
						<span
							onclick="document.getElementById('id03').style.display='none'"
							class="w3-button w3-xlarge w3-transparent w3-display-topright"
							title="Close Modal">×</span>
					</div>

					<br />

					<div class="w3-section" style="padding: 3%;">
						<div class="form-group">
							<label><b>제목</b></label> <input class="form-control" type="text"
								placeholder="Enter Title" name="title" required>
						</div>
						<div class="form-group">
							<label for="comment">내용</label>
							<textarea class="form-control" rows="5" name="content"
								id="comment"></textarea>
						</div>
					</div>

					<div class="w3-container w3-border-top w3-padding-16 w3-light-grey">
						<div style="float: right;">
							<button class="btn btn-primary" type="submit">Submit</button>
							<button
								onclick="document.getElementById('id03').style.display='none'"
								type="button" class="btn btn-danger">Cancel</button>
						</div>
					</div>

				</div>
			</div>
		</form>
	</div>
	<!-- 글쓰기 모달 -->
	<!-- 글쓰기 -->

	<!-- S3버킷으로 데이터 보내기 테스트 -->
	<c:if test="${sessionScope.login_id eq 'test001'}">
		<form action="/aws_test" method="post">
			<button type="submit" class="btn btn-danger">글목록 S3버킷으로
				csv내보내기</button>
		</form>
	</c:if>
	<!-- S3버킷으로 데이터 보내기 테스트 -->

</body>
</html>
