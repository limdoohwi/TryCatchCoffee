<!-- 
/*
 *  Description :  Main 페이지
 *  Created : 2016-06-25
 *  Author : 김준혁
 *  
 *  Revisions :
 */
 -->

<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<!-- Bootstrap Core CSS - Uses Bootswatch Flatly Theme: http://bootswatch.com/flatly/ -->
<link href="/bootstrab/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="/bootstrab/css/freelancer.css" rel="stylesheet">
<link href="/bootstrab/css/heroic-features.css" rel="stylesheet">
<!-- Custom Fonts -->
<link href="/bootstrab/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">
<link href="http://fonts.googleapis.com/css?family=Montserrat:400,700"
	rel="stylesheet" type="text/css">
<link
	href="http://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic"
	rel="stylesheet" type="text/css">

<!-- jQuery -->
<script src="/bootstrab/js/jquery.js"></script>
<!-- Bootstrap Core JavaScript -->
<script src="/bootstrab/js/bootstrap.min.js"></script>

<!-- Plugin JavaScript -->
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>
<script src="/resources/bootstrab/js/classie.js"></script>
<script src="/resources/bootstrab/js/cbpAnimatedHeader.js"></script>

<!-- Contact Form JavaScript -->
<script src="/resources/bootstrab/js/jqBootstrapValidation.js"></script>
<script src="/resources/bootstrab/js/contact_me.js"></script>

<!-- Custom Theme JavaScript -->
<script src="/resources/bootstrab/js/freelancer.js"></script>
<script>
$(function () {
})
</script>
<style>
#Our-Store-Inf-Form :read-only{
	background-color: white;
	border: none;
}
</style>
</head>
<body>
	<!-- Header -->
	<jsp:include page="/WEB-INF/views/layout/Header.jsp" />
	<div class="col-sm-offset-2" style="height: 500px">
		<div class="col-sm-6" style="display: inline-block;">
			<img
				src="http://static2.businessinsider.com/image/5204090c6bb3f7bd6b000004/the-rest-of-jc-penney-board-blasts-bill-ackman-firing-our-ceo-is-disruptive-and-counterproductive.jpg"
				width="100%" />
		</div>
		<div class="panel panel-default panel-table col-sm-6">
			<div class="panel-heading" style="background-color: #18bc9c">
				<div class="row">
					<div class="col col-sm-3">
						<div class="panel-title">
							 매장 정보
						</div>
					</div>
				</div>
			</div>
			<div class="panel-body">
				<form id="Our-Store-Inf-Form" class="form-horizontal">
						<!-- 매장명 -->
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">매장명</label>
							<div class="col-sm-6">
								<input type="text" class="form-control" readonly="readonly" value="종각점">
							</div>
						</div>
						<!-- 매장 주소 -->
						<div class="form-group">
							<label for="inputPassword3" class="col-sm-2 control-label">주소</label>
							<div class="col-sm-6">
								<input type="text" class="form-control" readonly="readonly" value="서울특별시 중구 을지로3가 101">
							</div>
							
						</div>
						<!-- 보유 미팅룸-->
						<div class="form-group">
							<label for="inputPassword3" class="col-sm-2 control-label">미팅룸</label>
							<div class="col-sm-6">
								<input type="text" class="form-control" readonly="readonly" value="3개">
							</div>
						</div>
						<!-- 운영 시간 -->
						<div class="form-group">
							<label for="inputPassword3" class="col-sm-2 control-label">운영 시간</label>
							<div class="col-sm-6">
								<input type="text" class="form-control" readonly="readonly" value="10:00 ~ 22:00">
							</div>
						</div>
						<div class="form-group">
							<label for="inputPassword3" class="col-sm-2 control-label">이벤트 &<br/>알림</label>
							<div class="col-sm-6">
								<textarea rows="5" cols="50" class="form-control" readonly="readonly">2016년 7월 5일부터 5일간 아메리카노 반값세일!</textarea>
							</div>
						</div>
					</form>
					<button type="button" class="btn btn-success">주문하기</button>
					<button type="button" class="btn btn-default">미팅룸 예약하기</button>
			</div>
		</div>
	</div>
	<br/><br/>
	<div class="panel panel-default panel-table col-md-offset-2">
			<div class="panel-heading" style="background-color: #18bc9c">
				<div class="row">
					<div class="col col-sm-3">
						<div class="panel-title">
							이메일
						</div>
					</div>
				</div>
			</div>
			<div class="panel-body">
			<p>
				<i class="fa fa-exclamation-circle" aria-hidden="true"></i>
				해당 매장 점장에게 궁금한 점이나 문의하고 싶은 내용을 적어서 보내주세요.<br/>
				연락 할 수 있는 핸드폰 번호를 남겨주시면 좀 더 빠른 답장을 받아보실 수 있습니다.
			</p>
				<form id="Our-Store-Inf-Form" class="form-horizontal">
						<!-- 제목 -->
						<div class="form-group">
							<label for="Subject" class="control-label">제목</label>
							<div>
								<input id="Subject" type="text" class="form-control">
							</div>
						</div>
						<!-- 내용 -->
						<div class="form-group">
							<label for="Content" class="control-label">내용</label>
							<div>
								<textarea id="Content" rows="10" cols="170" class="control-label" style="text-align:left;" wrap="hard"></textarea>
							</div>
						</div>
					</form>
					<button type="button" class="btn btn-success">전송</button>
			</div>
		</div>
	
	<!-- Footer -->
	<jsp:include page="/WEB-INF/views/layout/Footer.jsp" />
</body>
</html>