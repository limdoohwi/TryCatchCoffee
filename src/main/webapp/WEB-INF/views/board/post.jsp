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
<jsp:include page="/WEB-INF/views/layout/Header.jsp" />
<div class="panel panel-default panel-table" style="width:70%">
	<div class=panel-title>
		<table class="table">
		 <tr>
		  <td bgcolor=84F399 height=25 align=center>글쓰기</td>
		 </tr>
		</table>
	</div>
	<div class=panel-body>
		<table class="table table-striped table-bordered table-list">
			<form name="post_form" method="post" action="/post.client.board" >
			<input type="hidden" name="member_no" value="${member_dto.member_no}"/>
				 <tr>
				  <td align=center>
					   <table class=table>
					    <tr>
					     <td width=12%>제 목</td>
					     <td width=88%><input type=text name=board_subject size=50 maxlength=30></td>
					    </tr>
					    <tr>
					     <td width=12% >내 용</td>
					     <td width=88%><textarea name=board_content rows=10 cols=50></textarea></td>
					    </tr>
					    <tr>
					     <td width=12%>비밀번호</td> 
					     <td width=88% ><input type=password name=board_password size=15 maxlength=15></td>
					    </tr>		
					   </table>
				    	<button type="submit" class="btn btn-primary" id="post_submit_button">작성 완료</button>				
				  </td>
				 </tr>
			</form> 
		</table>
	</div>
</div>
<jsp:include page="/WEB-INF/views/layout/Footer.jsp" />