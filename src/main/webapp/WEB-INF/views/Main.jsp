<!-- 
/*
 *  Description :  Main 페이지
 *  Created : 2016-06-25
 *  Author : 김준혁
 *  
 *  Revisions :
 *  1.WHEN & WHO : 2016-07-14 임두휘
 *  2.WHAT : Log_in 성공여부 Register
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
<style>
body {
	background-color: #18bc9c
}
</style>
<script>
	$(
		function(){
			if("${login_success}"=="true"){
				alert("로그인에 성공하였습니다.");
			}
			if("${register_success}"=="true"){
				alert("회원가입에 성공하였습니다.");
			}
			else if("${register_success}"=="false"){
				alert("회원가입에 실패하였습니다. 다시 시도해 주세요");
			}
		}		
	);
</script>
</head>
<body id="page-top" class="index">
	<!-- Header -->
	<jsp:include page="/WEB-INF/views/layout/Header.jsp" />
	<!-- Main-Content Field -->
	<header id="Main-Header" style="margin-bottom: 0px !important;">
		<div id="Main-Container" class="container">
			<div id="Main-Row" class="row">
				<div id="Main-Div" class="col-lg-12">
					<!-- First Main Page  -->
					<div id="Main-Content" class="intro-text div-fade">
						<span class="name">Start TryCoffee</span> <span class="skills">Order
							Use Online and Save your Time</span>
					</div>
				</div>
			</div>
		</div>
	</header>

	<!-- Footer -->
	<jsp:include page="/WEB-INF/views/layout/Footer.jsp" />
</body>
</html>