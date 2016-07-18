<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false"%>

<!-- Bootstrap Core CSS - Uses Bootswatch Flatly Theme: http://bootswatch.com/flatly/ -->
<link href="/resources/bootstrab/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="/resources/bootstrab/css/freelancer.css" rel="stylesheet">
<link href="/resources/bootstrab/css/heroic-features.css" rel="stylesheet">
<!-- Custom Fonts -->
<link href="/resources/bootstrab/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">
<link href="http://fonts.googleapis.com/css?family=Montserrat:400,700"
	rel="stylesheet" type="text/css">
<link
	href="http://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic"
	rel="stylesheet" type="text/css">

<!-- jQuery -->
<script src="/resources/bootstrab/js/jquery.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="/resources/bootstrab/js/bootstrap.min.js"></script>

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
	window.onload = function(){
		alert("비밀글 답변 확인시 비밀글 작성시에 사용한 비밀번호 입력");
	}
</script>
<jsp:include page="/WEB-INF/views/layout/Header.jsp" />
<body>
<br><br>
	
<div class="span 5">
	<form name="board_password_form" method="post" action="board/passcheck">
		<input type="hidden" name="board_num" value="${board.board_num}"/>
		<input type="password" id="password_text" name="password_text" />
		<button type="submit" class="btn btn-primary">비밀번호 입력완료</button>
	</form>
</div>
</body>
<jsp:include page="/WEB-INF/views/layout/Footer.jsp" />