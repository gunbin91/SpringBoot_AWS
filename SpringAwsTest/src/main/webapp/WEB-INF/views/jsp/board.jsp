<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<title>게시판 상세</title>
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

	<br />

	<div class="container">
		<div class="col-xs-12" style="margin: 15px auto;">
			<label style="font-size: 20px;"><span
				class="glyphicon glyphicon-list-alt"></span>게시글 상세</label>
		</div>

		<div class="col-xs-12">
			<form action="/insertProc" method="post">
				<dl class="dl-horizontal">
					<dt>제목</dt>
					<dd>${board.board_title }</dd>

					<dt>작성자</dt>
					<dd>${board.board_writer }</dd>

					<dt>작성날짜</dt>
					<dd>
						<fmt:formatDate value="${board.board_date }"
							pattern="yyyy.MM.dd HH:mm:ss" />
					</dd>

					<%-- <dt>첨부파일</dt>
					<dd>
						<a href="/fileDown/${files.bno}">${files.fileOriName}</a>
					</dd> --%>

					<dt>내용</dt>
					<dd style="white-space: pre;">${board.board_content }</dd>
				</dl>
			</form>
			<div class="btn-group btn-group-sm" role="group"
				style="float: right;">
				<c:if test="${sessionScope.login_id eq board.board_writer}">
					<button type="button" class="btn btn-default"
						onclick="location.href='/delete_board?no=${board.board_no}'">삭제</button>
					<button type="button" class="btn btn-default" onclick="">수정</button>
				</c:if>
				<button type="button" class="btn btn-default"
					onclick="location.href='/'">목록</button>
			</div>
		</div>

		<!--  댓글  -->
		<div class="container">
			<label for="content">comment</label>
			<form name="commentInsertForm">
				<div class="input-group">
					<input type="hidden" name="board_no" value="${board.board_no}" />
					<input type="hidden" name="reply_writer"
						value="${sessionScope.login_id}" /> <input type="text"
						class="form-control" id="content" name="reply_content"
						placeholder="내용을 입력하세요."> <span class="input-group-btn">
						<button class="btn btn-default" type="button"
							name="commentInsertBtn">등록</button>
					</span>
				</div>
			</form>
		</div>

		<br />

		<div class="container">
			<div class="commentList"></div>
		</div>

	</div>

	<script>
		var bno = '${board.board_no}'; //게시글 번호

		//댓글 목록 
		function commentList() {
			$
					.ajax({
						url : '/reply/list',
						type : 'post',
						dataType : "json",
						data : {
							'board_no' : bno
						},
						success : function(data) {
							var comment = '';
							for (var i = 0; i < data.length; i++) {
								comment += '<div class="commentArea" style="border-bottom:1px solid darkgray; margin-bottom: 15px;">';
								comment += '<div class="commentInfo'+data[i].reply_no+'"> 작성자 : '
										+ data[i].reply_writer;
								if ( data[i].reply_writer == '${sessionScope.login_id}' )
									comment += '<a style="cursor: pointer;" onclick="commentDelete('
											+ data[i].reply_no
											+ ');"> 삭제 </a>';
								comment += ' </div><div class="commentContent'+data[i].reply_no+'"> <p> 내용 : '
										+ data[i].reply_content + '</p>';
								comment += '</div></div>';
							}
							$(".commentList").html(comment);
						}
					});
		}
		commentList();

		$('[name=commentInsertBtn]').click(function() { //댓글 등록 버튼 클릭시 
			if ($('[name=reply_writer]').val() == "") {
				alert("로그인 후 이용해주세요.");
				return;
			} else if ($('[name=reply_content]').val() == "") {
				alert("댓글 내용을 입력해 주세요.");
				return;
			}
			var insertData = $('[name=commentInsertForm]').serialize(); //commentInsertForm의 내용을 가져옴
			commentInsert(insertData); //Insert 함수호출(아래)
		});

		//댓글 등록
		function commentInsert(insertData) {
			$.ajax({
				url : '/reply/insert',
				type : 'post',
				data : insertData,
				success : function(data) {
					if (data == 1) {
						commentList(); //댓글 작성 후 댓글 목록 reload
						$('[name=reply_content]').val('');
					}
				}
			});
		}

		//댓글 삭제 
		function commentDelete(rno) {
			$.ajax({
				url : '/reply/delete/',
				type : 'post',
				data : { reply_no: rno },
				success : function(data) {
					if (data == 1)
						commentList(); //댓글 삭제후 목록 출력 
				}
			});
		}
	</script>


</body>
</html>
