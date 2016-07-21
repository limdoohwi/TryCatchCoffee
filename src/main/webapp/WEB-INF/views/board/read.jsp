<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
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
$(document).ready(function(){
	
	var formObj = $("form[role='form']");
	
	console.log(formObj);
	
	$(".btn-warning").on("click", function(){
		formObj.attr("action", "/update.client.board");
		formObj.attr("method", "get");		
		formObj.submit();
	});
	
	$(".btn-danger").on("click", function(){
		formObj.attr("action", "/delete.client.board");
		formObj.attr("method", "post");	
		formObj.submit();
	});
	
	$(".btn-primary").on("click", function(){
		formObj.attr("action", "/board/list");
		formObj.submit();
	});
	
	$(".btn-success").on("click", function(){
		formObj.attr("action", "/reply.client.board");
		formObj.attr("method", "get");		
		formObj.submit();
	});
	
});
</script>
<jsp:include page="/WEB-INF/views/layout/Header.jsp" />
<div class="panel panel-default panel-table" style="width:80%; " align="center">
	<div class="panel-head">
		<table class="table table-list" >
		 <tr>
		  <td bgcolor=9CA2EE height=25 align=center class=m>게시판</td>
		 </tr>
	</div>
	<div class="panel-body">
	<form role="form" method="post">
		<input type='hidden' name='board_num' value="${board.board_num}">
		<input type='hidden' name='board_password' value="${board.board_password }"/>
		<input type='hidden' name='board_pos' value="${board.board_pos }"/>
		<input type='hidden' name='board_depth' value="${board.board_depth }"/>
		<input type="hidden" name="member_no" value="${member_dto.member_no}"/>
		 <tr>
		  <td colspan=4>
		   <table class="table"> 
		    <tr> 
			 <td align=center bgcolor=#dddddd width=10%> 이 름 </td>
			 <td bgcolor=#ffffe8>${member_dto.member_name }</td>
			 <td align=center bgcolor=#dddddd width=15%> 등록날짜 </td>
			 <td bgcolor=#ffffe8><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${board.board_date}" /></td>
			</tr>
		    <tr> 
		     <td align=center bgcolor=#dddddd> 제 목</td>
		     <td bgcolor=#ffffe8 colspan=3>${board.board_subject}</td>
		   </tr>
		 	 <tr> <td>${board_content}</td></tr>
		   </table>
		  </td>
		 </tr>
			 <tr style="float:right" >
					<td><button type="submit" class="btn btn-primary" id="list_button_td">목록</button></td>
					<td><button type="submit" class="btn btn-warning" id="update_button_td">수정</button></td>
					<td><button type="submit" class="btn btn-success" id="reply_button_td">답변 달기</button></td>
					<td><button type="submit" class="btn btn-danger" id="delete_button_td">삭제</button></td> 	
			 </tr>
			 </form>
		</div>	 
		</table>
	</div>
</div>
<jsp:include page="/WEB-INF/views/layout/Footer.jsp" />