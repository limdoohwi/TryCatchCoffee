<!-- 
/*
 *  Description :  점장 생성 및 검색 페이지
 *  Created : 2016-06-29
 *  Author : 김준혁
 *  
 *  Revisions :
 */
 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="/resources/bootstrab/css/bootstrap.min.css" rel="stylesheet">
<!-- jQuery -->
<script src="/resources/bootstrab/js/jquery.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="/resources/bootstrab/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="http://www.prepbootstrap.com/Content/shieldui-lite/dist/css/light/all.min.css" />
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css"
	rel='stylesheet' type='text/css'>
	
<script>
	$(function(){
		//기존 점장 이메일 검색 버튼 클릭
		$("#Owner-Email-Search-Btn").click(function(){
			var member_email = $("#Exist-Owner-Email").val();
			$.post("/search.owner.insert.store.manager", {member_email:member_email}, function(data){
				var div = $("#Result-Owner-Search-Div");
				$(div).empty();
				if(data.ownerList.length == 0){
					$(div).append("<h4>일치하는 결과가 없습니다.</h4>");
					return false;
				}
				for(var i=0; i<data.ownerList.length; i++){
					if(data.ownerList[i].member_code == 2){
						$(div).append("<a class='Result-Owner-List-a list-group-item active'>" +
								"<input type='hidden' class='member_no' value='"+ data.ownerList[i].member_no +"'/>" +
									 "<h4 class='member_name list-group-item-heading'>"+ decodeURI(data.ownerList[i].member_name) +"</h4>" +
		   							 "<p class='list-group-item-text'>"+ data.ownerList[i].member_email +"</p>" +
								"</a><br/>");
					}
				}
			}, 'json');
		});
		//점장 선택 클릭 
		$(document).on("click", ".Result-Owner-List-a", function(){
			var index = $(".Result-Owner-List-a").index(this);
			var member_no = $(".member_no").eq(index).val();
			var member_name = $(".member_name").eq(index).text();
			var insertDisplay = $("#Store-Insert-Form-Div", opener.document).css("display");
			//매장 수정 중일 땐 매장 수정 owner text에 정보를 넘겨준다
			if(insertDisplay == "none"){
				$("#Store-Update-Form-Div input[name=member_no]", opener.document).val(member_no);
				$("#Store-Update-Form-Div input[name=member_name]", opener.document).val(member_name);
			}
			//매장 추가 중일 땐 매장 추가 owner text에 정보를 넘겨준다
			else{
				$("#Store-Insert-Form-Div input[name=member_no]", opener.document).val(member_no);
				$("#Store-Insert-Form-Div input[name=member_name]", opener.document).val(member_name);
			}
			
			window.close();
		});
		//점장 생성 패널에서 이메일 중복 체크
		$("#member_email").keyup(function(){
			var regExp = /[0-9a-zA-Z][_0-9a-zA-Z-]*@[_0-9a-zA-Z-]+(\.[_0-9a-zA-Z-]+){1,2}$/;
			var member_email = $("#Create-Owner-Form #member_email").val();
			if(member_email == ""){
				$("#member_email").removeAttr("style");
				$("#member_email").css("border", "1px solid red");
				$("#Email-Overlap-Result-Span").css("color", "red");
				$("#Email-Overlap-Result-Span").text("입력된 값이 없습니다.");
			}
			else if(!member_email.match(regExp)){
				$("#member_email").css("border", "1px solid red");
				$("#Email-Overlap-Result-Span").css("color", "red");
				$("#Email-Overlap-Result-Span").html("올바르지 않은 이메일 형식<br/>예:abc12@defg.com");
			}
			else{
				$.post("email.overlap.check.insert.store.manager", {member_email:member_email}, function(data){
					if(data.indexOf('false') != -1){
						$("#member_email").css("border", "1px solid green");
						$("#Email-Overlap-Result-Span").css("color", "green");
						$("#Email-Overlap-Result-Span").text("사용 가능");
						return false;
					}
					if(data.indexOf('true') != -1){
						$("#member_email").css("border", "1px solid red");
						$("#Email-Overlap-Result-Span").css("color", "red");
						$("#Email-Overlap-Result-Span").text("이미 존재하는 이메일입니다.");
						return false;
					}
				});
			}
		});
		
		//점장 생성 패널에서 비밀번호 체크
		$("#member_check").keyup(function(){
			var pass = $("#member_pw").val();
			var passCk = $(this).val();
			if(pass == passCk){
				$(this).css("border", "1px solid green");
				$("#Member-Pw-Ck-Result-Span").css("color", "green");
				$("#Member-Pw-Ck-Result-Span").text("비밀번호 일치");
			}
			else{
				$(this).css("border", "1px solid red");
				$("#Member-Pw-Ck-Result-Span").css("color", "red");
				$("#Member-Pw-Ck-Result-Span").text("비밀번호 불일치");
			}
		});
		
		//점장 생성 클릭
		$("#Create-Owner-Btn").click(function(){
			$("#Create-Owner-Form .form-control").each(function(){
				if($(this).val() == ""){
					alert("입력하지 않은 부분이 있습니다.");
					return false;
				}
			});
			var email = $("#member_email");
			var password = $("#member_check");
			if($(email).css("border-color") == "rgb(255, 0, 0)"){
				alert("이메일 형식을 정확히 입력해주세요");
				return false;
			}
			if($(password).css("border-color") == "rgb(255, 0, 0)"){
				alert("비밀번호를 재확인 하세요");
				return false;
			}
			
			var member_email = $(email).val();
			var member_pw = $(password).val();
			var member_name = $("#member_name").val();
			var member_tel = $("#member_tel").val();
			var member_birth = $("#member_birth").val();
			var member_code = 2;
			$.ajax({
				url:"/create.owner.insert.store.manager",
				type:"post",
				data:{member_name:member_name, member_email:member_email, member_pw:member_pw, member_birth:member_birth, member_tel:member_tel, member_code:2},
				dataType:"json",
				success:function(data){
					alert(data);
					alert(data.flag);
					var member_no;
					var member_name;
					if(data.flag == "true"){
						member_no = data.member_no;
						member_name = decodeURI(data.member_name);
					}
					else{
						alert("점장을 등록하는데 실패했습니다.. 다시 시도해주세요.");
						return false;
					}
					var insertDisplay = $("#Store-Insert-Form-Div", opener.document).css("display");
					//매장 수정 중일 땐 매장 수정 owner text에 정보를 넘겨준다
					if(insertDisplay == "none"){
						$("#Store-Update-Form-Div input[name=member_no]", opener.document).val(member_no);
						$("#Store-Update-Form-Div input[name=member_name]", opener.document).val(member_name);
					}
					//매장 추가 중일 땐 매장 추가 owner text에 정보를 넘겨준다
					else{
						$("#Store-Insert-Form-Div input[name=member_no]", opener.document).val(member_no);
						$("#Store-Insert-Form-Div input[name=member_name]", opener.document).val(member_name);
					}
					window.close();
				}
			});
		});
	})
</script>
<style>
	.Result-Owner-List-a:hover{
		cursor: pointer;
	}
</style>
</head>
<body>
<div class="container">
		<div class="row">
			<!-- 점장 검색 -->
			<div class="col-lg-6" style="display: inline-block;">
				<div class="panel panel-default panel-table">
					<div class="panel-heading">
						<div class="row">
							<div class="col col-xs-6">
								<h3 class="panel-title">점장 검색</h3>
							</div>
						</div>
					</div>
					<div class="panel-body">
						<div id="Search-Owner-Form-Div" class="row col-md-offset-4">
							<form id="Owner-Search-Form" class="form-horizontal">
								<!-- Owner-Search -->
								<div class="form-group">
									<div class="col-sm-6 input-group">
										<input type="text" class="form-control"
											id="Exist-Owner-Email"
											placeholder="이메일 검색..."> <a id="Owner-Email-Search-Btn"
											class="btn btn-success input-group-addon"><em
											class="fa fa-search" aria-hidden="true"></em></a>
									</div>
								</div>
							</form>
						</div>
						<!-- Result Owner-Search -->
						<div>
							<div id="Result-Owner-Search-Div" class="row list-group""
								style="margin-left: 0px !important">
								<br/><hr/>
							<!-- 기존 점장 검색시 결과 화면  -->
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 점장 생성 -->
			<div class="col-lg-6" style="display: inline-block;">
				<div class="panel panel-default panel-table">
					<div class="panel-heading">
						<div class="row">
							<div class="col col-xs-6">
								<h3 class="panel-title">점장 생성</h3>
							</div>
						</div>
					</div>
					<div class="panel-body">
						<div class="row col-md-offset-2">
							<form id="Create-Owner-Form" class="form-horizontal">
								<!-- Email -->
								<div class="form-group">
									<label for="member_email" class="col-sm-2 control-label">Email</label>
									<div class="col-sm-6">
										<input type="email" class="form-control" id="member_email" name="member_email"
											placeholder="Email"><span id="Email-Overlap-Result-Span"></span>
									</div>
								</div>
								<!-- Password -->
								<div class="form-group">
									<label for="member_pw" class="col-sm-2 control-label">Password</label>
									<div class="col-sm-6">
										<input type="password" class="form-control"
											id="member_pw" name="member_pw"  placeholder="Password">
									</div>
								</div>
								<!-- Password-Check -->
								<div class="form-group">
									<label for="member_check" class="col-sm-2 control-label">Password-Check</label>
									<div class="col-sm-6">
										<input type="password" class="form-control"
											id="member_check" placeholder="Password-Check"><span id="Member-Pw-Ck-Result-Span"></span>
									</div>
								</div>
								<!-- Name -->
								<div class="form-group">
									<label for="member_name" class="col-sm-2 control-label">Name</label>
									<div class="col-sm-6">
										<input type="text" class="form-control" id="member_name" name="member_name"
											placeholder="Name">
									</div>
								</div>
								<!-- Tel -->
								<div class="form-group">
									<label for="member_tel" class="col-sm-2 control-label">Tel</label>
									<div class="col-sm-6">
										<input type="text" class="form-control" id="member_tel" name="member_tel"
											placeholder="010xxxxyyyy">
									</div>
								</div>
								<!-- Birth -->
								<div class="form-group">
									<label for="member_birth" class="col-sm-2 control-label">Birth</label>
									<div class="col-sm-6">
										<input type="text" class="form-control" id="member_birth" name="member_birth"
											placeholder="YYYY/MM/DD">
									</div>
								</div>
								<!-- Submit Btn -->
								<div class="form-group">
									<div class="col-sm-offset-2 col-sm-10">
										<button id="Create-Owner-Btn" type="button"
											class="btn btn-default">점장 생성</button>
										&nbsp;&nbsp;
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>