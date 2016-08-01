<!-- 
/*
 *  Description :  마이 페이지
 *  Created : 2016-06-29
 *  Author : 김준혁
 *  
 *  Revisions :
 */
 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
				
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
<script src="/resources/semi_js/ListAjax.js"></script>
<script>
var cnt = 0;
var meeting_room_page = 0;
var meeting_room_search_date = "";
var drink_page = 0;
var drink_search_date = "";
	$(function() {
		 $("#Show-Detail-Purchase-List").hide();
		//* 미팅룸 시작
		//mypage 접속시 현재 접속한 회원의 미팅룸 예약 history를 호출
		callMyMeetingRoomReservationListAjax();
		//미팅룸 페이지네이션
		//< 버튼 클릭
		$("#Member-MeetingRoom-ReservationList-Pre-Btn").click(function(){
			if(meeting_room_page > 0){
				meeting_room_page -= 3;
				callMyMeetingRoomReservationListAjax();
			}
			else{
				alert("이동할 페이지가 없습니다.");
			}
		});
		//> 버튼 클릭
		$("#Member-MeetingRoom-ReservationList-Next-Btn").click(function(){
			meeting_room_page += 3;
			callMyMeetingRoomReservationListAjax();
		});
		//미팅룸 구매 날짜 검색
		$(".Search-MeetingRoom-Reservation-Date-Btn").click(function(){
			meeting_room_search_date = $("#meeting_order_date").val();
			alert(meeting_room_search_date);
			callMyMeetingRoomReservationListAjax();
		});
		//mypage 접속시 현재 접속한 회원의 음료구매내역 history를 호출
		callMyDrinkReservationListAjax();
		//음료 페이지네이션
		//< 버튼 클릭
		$("#Member-Drink-ReservationList-Pre-Btn").click(function(){
			if(drink_page > 0){
				drink_page -= 3;
				callMyDrinkReservationListAjax();
			}
			else{
				alert("이동할 페이지가 없습니다.");
			}
		});
		//> 버튼 클릭
		$("#Member-Drink-ReservationList-Next-Btn").click(function(){
			drink_page += 3;
			callMyDrinkReservationListAjax();
		});
		//음료 구매 날짜 검색
		$(".Search-Drink-Reservation-Date-Btn").click(function(){
			drink_search_date = $("#drink_order_date").val();
			callMyDrinkReservationListAjax();
		});
		//상세 보기 클릭시 모달 및 상품 리스트 호출
		$(document).on("click", ".Show-Detail-Purchase-List-Btn", function(){
			var index = $(".Show-Detail-Purchase-List-Btn").index(this);
			var menu_payment_no = $(".Show-Detail-Purchase-List-Btn").attr("id");
			callMyDrinkDetailListAjax(menu_payment_no);
		});
		//Show-Detail-Purchase-List-Modal-Hide-Btn Click Hide Modal
		$("#Show-Detail-Purchase-List-Modal-Hide-Btn").click(function(){
		    $("#Show-Detail-Purchase-List").hide();
		    $("#My-Page-Detail-Menu-List-Table tbody").html("");
		  });
		//* 음료주문 종료
		
		$("#Show-Detail-Purchase-List").hide();
		$(".div-fade").fadeIn(400);
		//Show-Change-Member-Password-Panel-Body-Btn Click Show Change-Member-Password-Panel-Body
		$("#Show-Change-Member-Password-Panel-Body-Btn").click(function(){
			if($("#Change-Member-Password-Panel-Body").css("display") == "none"){
				$(this).html("<em class='fa fa-minus-circle' aria-hidden='true'></em>");
				$("#Change-Member-Password-Panel-Body").slideDown(400);
			}
			else{
				$(this).html("<em class='fa fa-plus-circle' aria-hidden='true'></em>");
				$("#Change-Member-Password-Panel-Body").slideUp(400);
			}
		});
		//현재 비밀번호 확인 버튼 클릭시 새로운 비밀번호 변경 div 호출
		$("#Member-Current-Password-Confirm-Btn").click(function(){
			var password = $("#Current-Password").val();
			if(password == ""){
				alert("비밀번호가 입력되지 않았습니다.");
				$("#Current-Password").focus();
				return false;
			}
			else if(password == "${member_dto.member_pw}"){
				$("#Member-Current-Password-Div").hide();
				$("#Member-New-Password-Div").show();
			}
			else{
				alert("비밀번호가 틀렸습니다.");
			}
		});
		//비밀번호 변경 취소 버튼 클릭시 현재 비밀번호 입력 div 호출
		$("#Member-New-Password-Cancel-Btn").click(function(){
			$("#Member-Current-Password-Div").show();
			$("#Member-New-Password-Div").hide();
		});
		//정규식을 이용한 비밀번호 로직 검사, 숫자와 영문 조합 10~15자리
		$("#New-Password-Input").keyup(function(){
			var passwordRules = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$/;
			var password = $(this).val();
			var checkNumber = password.search(/[0-9]/g);
			var checkEnglish = password.search(/[a-z]/ig);
			if(!/^[a-zA-Z0-9]{10,15}$/.test(password)){
				$(this).css("border", "1px solid red");
				$("#New-Password-Input-Span").text('숫자와 영문자 조합 10~15자리');
				$("#New-Password-Input-Span").css("color", "red");
				return false;
			}
			if(checkNumber <0 || checkEnglish <0){
				$(this).css("border", "1px solid red");
				$("#New-Password-Input-Span").text("숫자와 영문자를 혼용");
				$("#New-Password-Input-Span").css("color", "red");
				return false;
			}
			if(/(\w)\1\1\1/.test(password)){
				$(this).css("border", "1px solid red");
				$("#New-Password-Input-Span").text('444같은 문자를 4번 이상 사용불가');
				$("#New-Password-Input-Span").css("color", "red");
				return false;
			}
			$(this).css("border", "1px solid green");
			$("#New-Password-Input-Span").text('사용가능');
			$("#New-Password-Input-Span").css("color", "green");
		});
		//새로운 비밀번호 체크 확인
		$("#New-Password-Ck-Input").keyup(function(){
			var newPassword = $("#New-Password-Input").val();
			var newPasswordCk = $(this).val();
			
			if(newPassword != newPasswordCk){
				$(this).css("border", "1px solid red");
				$("#New-Password-Input-Ck-Span").text('일치하지 않습니다');
				$("#New-Password-Input-Ck-Span").css("color", "red");
				return false;
			}
			$(this).css("border", "1px solid green");
			$("#New-Password-Input-Ck-Span").text('비밀번호 일치');
			$("#New-Password-Input-Ck-Span").css("color", "green");
		});
		//새로운 비밀번호 완료 버튼 클릭
		$("#Member-New-Password-Confirm-Btn").click(function(){
			$("#My-Page-ChangePassword-Inf-Form .New-Password").each(function(){
				if($(this).val() == ""){
					alert("입력하지 않은 부분이 있습니다.");
					$(this).focus();
					return false;
				}
				if($("#New-Password-Input-Ck-Span").text() == "일치하지 않습니다."){
					alert("비밀번호가 서로 다릅니다. 다시 확인해주세요.");
					return false;
				}
				if($("#New-Password-Input-Ck-Span").text() == "비밀번호 일치"){
					var member_no = "${member_dto.member_no}";
					$.ajax({
						url:"/my_page.chage_pw.member",
						type:"post",
						data:{member_no:member_no , member_pw:$("#New-Password-Ck-Input").val()},
						success:function(data){
							if(data == true && cnt == 0){
								alert("비빌번호를 변경하였습니다. 다시 로그인 해주세요.")
								location.href="/";
								cnt++;
							}
						},
						error:function(){
							alert("비밀번호 변경을 실패하였습니다. 다시 시도해주세요.");
						}
					});
				}
			});
		});
		
	})
	
		//mypage 접속시 접속한 회원의 미팅룸 예약 내역을 호출
		function callMyMeetingRoomReservationListAjax(){
			var jsonData = {start_page : meeting_room_page, date : meeting_room_search_date};
			callList_Ajax("/my_page.meetingRoomReservationList.member", successMyMeetingRoomReservationList, errorMyMeetingRoomReservationList, jsonData);
			function successMyMeetingRoomReservationList(data){
				//초기화
				$("#Member-MeetingRoom-ReservationList-Table tbody").html('');
				$.each(data.myPageMeetingRoomReservationList, function(index, listMenuPayment){
					var html =	'<tr>';
						html += '<td>'+listMenuPayment.meeting_order_date+'</td>';
						html += '<td>'+listMenuPayment.meeting_reservation_date+'</td>';
						html += '<td>'+listMenuPayment.meeting_reservation_time+'</td>';
						html += '<td>'+listMenuPayment.member_name+'</td>';
						html += '<td>'+listMenuPayment.store_name+'</td>';
						html += '<td>'+listMenuPayment.meeting_no+'번</td>';
						html += '</tr>';
					$("#Member-MeetingRoom-ReservationList-Table tbody").append(html);
				});
			}
			function errorMyMeetingRoomReservationList(){
				alert("ajax 예외 발생 My_Page : errorMyMeetingRoomReservationList");
			}
		}
		//mypage 접속시 접속한 회원의 음료주문 histroy를 호출
		function callMyDrinkReservationListAjax(){
			var jsonData = {start_page : drink_page, date : drink_search_date};
			callList_Ajax("/my_page.drinkReservationList.member", successMyDrinkReservationList, errorMyDrinkReservationList, jsonData);
			function successMyDrinkReservationList(data){
				//초기화
				$("#Member-Drink-ReservationList-Table tbody").html('');
				$.each(data.menuPaymentList, function(index, list){
					var html =	'<tr>';
					html += '<td>'+list.menu_payment_date+'</td>';
					html += '<td>'+list.order_name+'</td>';
					html += '<td><a class="Show-Detail-Purchase-List-Btn" id="'+list.menu_payment_no+'" style="cursor:pointer;">상품 보기</a></td>';
					html += '<td>'+list.menu_payment_style+'</td>';
					html += '<td>'+list.menu_total_price+'</td>';
					html += '<td>'+list.store_name+'</td>';
					html += '</tr>';
					$("#Member-Drink-ReservationList-Table tbody").append(html);
				});
			}
			function errorMyDrinkReservationList(){
				alert("ajax 예외 발생 My_Page : errorMyDrinkReservationList");
			}
		}
		//상세 보기 클릭시 해당 메뉴 리스트 호출
		function callMyDrinkDetailListAjax(menu_payment_no){
			alert(menu_payment_no);
			var jsonData = {menu_payment_no : menu_payment_no};
			callList_Ajax("/my_page.drinkDetailList.member", successMyDrinkDetailList, errorMyDrinkDetailList, jsonData);
			function successMyDrinkDetailList(data){
				//초기화
				$("#My-Page-Detail-Menu-List-Table tbody").html('');
				var total_price = 0;
				$.each(data.menuDetailList, function(index, list){
					total_price += list.menu_price * list.menu_count;
					var html =	'<tr>';
					html += '<td>'+list.menu_name+'</td>';
					html += '<td>'+list.menu_count+'</td>';
					html += '<td>'+list.menu_price+'원</td>';
					html += '<td>'+list.menu_price * list.menu_count+'원</td>';
					$("#My-Page-Detail-Menu-List-Table tbody").append(html);
				});
				var html = '</tr><tr><td colspan="2">합계</td><td colspan="2">'+total_price+'원</td></tr>';
				$("#My-Page-Detail-Menu-List-Table tbody").append(html);
				$("#Show-Detail-Purchase-List").show();
			}
			function errorMyDrinkDetailList(){
				alert("ajax 예외 발생 My_Page : errorMyDrinkDetailList");
			}
		}
</script>

<style>
#Store-Search-Main-Div {
	display: none;
}

#My-Page-Member-Inf-Form :read-only{
	background-color: white;
	border: none;
}
</style>

<!-- Header -->
<jsp:include page="/WEB-INF/views/layout/Header.jsp" />
<div class="row">
	<div class="col-lg-4" style="display: inline-block;">
		<!-- Member Information -->
		<div class="panel panel-default panel-table">
			<div class="panel-heading" style="background-color:#18bc9c">
				<div class="row">
					<div class="col col-xs-6">
						<h3 class="panel-title">회원 정보</h3>
					</div>
				</div>
			</div>
			<div class="panel-body">
				<!-- Member Info Panel -->
				<div class="row col-md-offset-1">
					<form id="My-Page-Member-Inf-Form" class="form-horizontal">
						<!-- Email -->
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">Email</label>
							<div class="col-sm-6">
								<input type="email" class="form-control" readonly="readonly" value="${member_dto.member_email}">
							</div>
						</div>
						<!-- Name -->
						<div class="form-group">
							<label for="inputPassword3" class="col-sm-2 control-label">Name</label>
							<div class="col-sm-4">
								<input type="text" class="form-control" readonly="readonly" value="${member_dto.member_name}">
							</div>
						</div>
						<!-- Tel -->
						<div class="form-group">
							<label for="inputPassword3" class="col-sm-2 control-label">Tel</label>
							<div class="col-sm-4">
								<input type="text" class="form-control" readonly="readonly" value="${member_dto.member_tel}">
							</div>
						</div>
						<!-- Mileage -->
						<div class="form-group">
							<label for="inputPassword3" class="col-sm-2 control-label">Mileage</label>
							<div class="col-sm-4">
								<input type="text" class="form-control" readonly="readonly" value="${member_dto.member_mileage}">
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
		<!-- Chage Member Password -->
		<div class="panel panel-default panel-table">
			<div class="panel-heading">
				<div class="row">
					<div class="col col-xs-6">
						<div class="panel-title" style="display:inline-block; margin-right: 10px">비밀번호 변경</div> 
						<div style="display:inline-block;">
							<a id="Show-Change-Member-Password-Panel-Body-Btn" class="btn btn-success"><em class="fa fa-plus-circle" aria-hidden="true"></em></a>
						</div>
					</div>
				</div>
			</div>
				<div id="Change-Member-Password-Panel-Body" class="panel-body" style="display:none">
					<div class="row">
						<form id="My-Page-ChangePassword-Inf-Form" class="form-horizontal">
							<!-- 현재 비밀번호 -->
							<div id="Member-Current-Password-Div" class="form-group">
								<label for="Current-Password" class="col-sm-3 control-label">현재 비밀번호</label>
								<div class="col-sm-6" style="display:inline-block;">
									<input id="Current-Password" type="password" class="form-control">
								</div>
								<div style="display:inline-block;">
									<button id="Member-Current-Password-Confirm-Btn" type="button" class="btn btn-default">확인</button>
								</div>
							</div>
							<!-- 새로 입력 할 비밀번호 div -->
							<div id="Member-New-Password-Div" style="display:none">
								<!-- 새로운 비밀번호 -->
								<div class="form-group">
									<label for="New-Password-Input" class="col-sm-3 control-label">새로운 비밀번호</label>
									<div class="col-sm-6">
										<input id="New-Password-Input" type="password" class="New-Password form-control" ><span id="New-Password-Input-Span"></span>
									</div>
								</div>
								<!-- 새로운 비밀번호 확인 -->
								<div class="form-group">
									<label for="New-Password-Ck-Input" class="col-sm-3 control-label">비밀번호 확인</label>
									<div class="col-sm-6">
										<input id="New-Password-Ck-Input" type="password" class="New-Password form-control" name="member_pw"><span id="New-Password-Input-Ck-Span"></span>
									</div>
								</div>
								<div class="form-group">
									 <div class="col-sm-offset-3 col-sm-6">
										<button id="Member-New-Password-Confirm-Btn" type="button" class="btn btn-default">비밀번호 변경</button>&nbsp;&nbsp;
										<button id="Member-New-Password-Cancel-Btn" type="button" class="btn btn-primary">취소</button>
									 </div>
								</div>
							</div>
						</form>
					</div>
				</div>
	 		</div>
	</div>
	<!-- Purchase History -->
	<div class="col-lg-8" style="display: inline-block;">
		<div class="panel panel-default panel-table">
			<div class="panel-heading" style="background-color:#18bc9c">
				<div class="row">
					<div class="col col-xs-6">
						<h3 class="panel-title">상품 구매 내역</h3>
					</div>
				</div>
			</div>
			<div class="panel-body">
				<form id="Search-MeetingRoom-Reservation-Date-Form" class="form-inline" method="post" action="/my_page.member">
					<div class="form-group">
						<div class="input-group">
							<!-- 입력  -->
							<input type="text" class="form-control" id="drink_order_date"
								placeholder="구매날짜 입력 예)2016-07-18">
							<!-- 검색 버튼 -->
							<div class="Search-Drink-Reservation-Date-Btn input-group-addon"
								style="background-color: white; color: green; cursor: pointer;">
								<i class="Search-MeetingRoom-Reservation-Date-Btn fa fa-search"></i>
							</div>
						</div>
					</div>
				</form>
				<div class="row">
					<table id="Member-Drink-ReservationList-Table"
						class="table table-striped table-bordered table-list">
						<!-- Member-Purchase-Table-Header -->
						<thead>
							<tr>
								<th>구매 날짜</th>
								<th>구매자</th>
								<th>구매 상품</th>
								<th>결제 방법</th>
								<th>결제액</th>
								<th>구매 매장</th>
							</tr>
						</thead>
						<!-- Member-Purchase-Table-Body -->
						<tbody>
						</tbody>
					</table>
				</div>
			</div>
			<div class="panel-footer pull-right">
			<a id="Member-Drink-ReservationList-Pre-Btn" class="btn btn-success"><i class="fa fa-chevron-left" aria-hidden="true"></i></a>
				<a id="Member-Drink-ReservationList-Next-Btn" class="btn btn-success"><i class="fa fa-chevron-right" aria-hidden="true"></i></a>
			</div>
		</div>
	</div>
	<!-- MeetingRoom History -->
	<div class="col-lg-8" style="display: inline-block;">
		<div class="panel panel-default panel-table">
			<div class="panel-heading" style="background-color:#18bc9c">
				<div class="row">
					<div class="col col-xs-6">
						<h3 class="panel-title">미팅룸 예약 내역</h3>
					</div>
				</div>
			</div>
			<div class="panel-body">
				<!-- 미팅룸 예약 내역 검색 -->
				<form id="Search-MeetingRoom-Reservation-Date-Form" class="form-inline" method="post" action="/my_page.member">
					<div class="form-group">
						<div class="input-group">
							<!-- 입력  -->
							<input type="text" class="form-control" id="meeting_order_date"
								placeholder="구매날짜 입력 예)2016-07-18">
							<!-- 검색 버튼 -->
							<div class="Search-MeetingRoom-Reservation-Date-Btn input-group-addon"
								style="background-color: white; color: green; cursor: pointer;">
								<i class="Search-MeetingRoom-Reservation-Date-Btn fa fa-search"></i>
							</div>
						</div>
					</div>
				</form>
				<div class="row">
					<table id="Member-MeetingRoom-ReservationList-Table"
						class="table table-striped table-bordered table-list">
						<!-- Member-Purchase-Meeting-Table-Header -->
						<thead>
							<tr>
								<th>구매 날짜</th>
								<th>예약 날짜</th>
								<th>예약 시간</th>
								<th>구매자</th>
								<th>매장명</th>
								<th>미팅룸 번호</th>
							</tr>
						</thead>
						<!-- Member-Purchase-Meeting-Table-Body -->
						<tbody>
						</tbody>
					</table>
				</div>
			</div>
			<div class="panel-footer pull-right">
			<a id="Member-MeetingRoom-ReservationList-Pre-Btn" class="btn btn-success"><i class="fa fa-chevron-left" aria-hidden="true"></i></a>
			<a id="Member-MeetingRoom-ReservationList-Next-Btn" class="btn btn-success"><i class="fa fa-chevron-right" aria-hidden="true"></i></a>
			</div>
		</div>
	</div>
</div>
<!-- Meber_Purchase_List_Modal -->
<jsp:include page="Member_Purchase_List_Modal.jsp" />
<!-- Footer -->
<jsp:include page="/WEB-INF/views/layout/Footer.jsp" />