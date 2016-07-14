<!-- 
/*
 *  Description :  로그인 페이지
 *  Created : 2016-06-26
 *  Author : 김준혁
 *  
 *  Revisions :
 */
 -->

<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
	$(function() {
		$(".div-fade").fadeIn(400);
		if("${login_success}"=="false"){
			$("#login_false_label").text("이메일이나 패스워드가 잘못 입력 되었습니다.");
			$("#login_false_label").css("color","red");
		}
	})
</script>
<!-- Header -->
<jsp:include page="/WEB-INF/views/layout/Header.jsp" />

<!-- Log-In Grid Section -->
<div id="Log-In-Div" class="container div-fade" style="display: none; margin-top:100px; margin-bottom:100px;">
	<div class="row">
		<div class="col-lg-12 text-center">
			<h2>Log-In</h2>
			<hr class="star-primary">
		</div>
	</div>
	<!-- Log-In 메인 -->
	<div class="row col-md-offset-2">
		<form class="form-horizontal" action="login.member" method="post">
			<div class="form-group">
				<label for="inputEmail3" class="col-sm-2 control-label">Email</label>
				<div class="col-sm-6">
					<input type="email" class="form-control" id="inputEmail" name="member_email"
						placeholder="Email">
				</div>
			</div>
			<div class="form-group">
				<label for="inputPassword3" class="col-sm-2 control-label">Password</label>
				<div class="col-sm-6">
					<input type="password" class="form-control" id="inputPassword" name="member_pw"
						placeholder="Password">
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<button id="User-Log-In-Btn" type="submit" class="btn btn-default">Sign
						in</button>
					&nbsp;&nbsp;
					<label id="login_false_label"></label>
				</div>
			</div>
		</form>
	</div>
</div>

<!-- Footer -->
<jsp:include page="/WEB-INF/views/layout/Footer.jsp" />
