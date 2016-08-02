<!-- 
/*
 *  Description :  회원 관리 페이지
 *  Created : 2016-06-28
 *  Author : 김준혁
 *  
 *  Revisions :
 */
 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css"
	rel='stylesheet' type='text/css'>
<script src="/resources/semi_js/ListAjax.js"></script>
<script>
	var cnt = 0;
	var count = 0;
	var member_no = 0;
	var member_start_page = 1;
	var member_start_index = 0;
	var member_email_search = "";
	var member_pagePer_num = 5;
	var meetingRoom_start_page = 1;
	var meetingRoom_start_index = 0;
	var meetingRoom_date_search = "";
	var meetingRoom_pagePer_num = 3;
	var drink_start_page = 1;
	var drink_start_index = 0;
	var drink_date_search = "";
	var drink_pagePer_num = 3;
	$(function() {
		//처음 페이지 시작시 회원 리스트 호출
		callMemberListAjax();
		
		//회원 리스트 페이징
		$(".Member_Page_Num").click(function(){
			var index = $(".Member_Page_Num").index(this);
			member_start_page = $(".Member_Page_Num").eq(index).text();
			member_start_index = (member_start_page -1) * member_pagePer_num;
			$("#Member-List-Table tbody").html('');
			callMemberListAjax();
		});
		
		//회원 구매내역 페이징
		$(".Member_Drink_Page_Num").click(function(){
			var index = $(".Member_Drink_Page_Num").index(this);
			drink_start_page = $(".Member_Drink_Page_Num").eq(index).text();
			drink_start_index = (drink_start_page -1) * drink_pagePer_num;
			$("#Member-Drink-Reservation-List-Table tbody").html('');
			var drinkReservationData = {member_no : member_no, start_page : drink_start_index, date : drink_date_search};
			callMemberDrinkReservationListAjax(drinkReservationData);
		});
		
		//회원 미팅룸 예약 내역 페이징
		$(".Member_MeetingRoom_Page_Num").click(function(){
			var index = $(".Member_MeetingRoom_Page_Num").index(this);
			meetingRoom_start_page = $(".Member_MeetingRoom_Page_Num").eq(index).text();
			meetingRoom_start_index = (meetingRoom_start_page -1) * meetingRoom_pagePer_num;
			$("#Member-MeetingRoom-Reservation-List-Table tbody").html('');
			var meetingRoomReservationData = {member_no : member_no, start_page : meetingRoom_start_index, date : meetingRoom_date_search};
			callMemberMeetingRoomReservationListAjax(meetingRoomReservationData);
		});
		
		//상세 보기 클릭
		$(document).on("click", ".Show-Detail-Member-Btn", function(){
			var index = $(".Show-Detail-Member-Btn").index(this);
			member_no = $(".Member-Table-Num-td").eq(index).text();
			var meetingRoomReservationData = {member_no : member_no, start_page : meetingRoom_start_index, date : meetingRoom_date_search};
			var drinkReservationData = {member_no : member_no, start_page : drink_start_index, date : drink_date_search};
			callMemberMeetingRoomReservationListAjax(meetingRoomReservationData);
			callMemberDrinkReservationListAjax(drinkReservationData);
		});
		
		//회원 이메일 검색
		$("#Member-Search-Btn").click(function(){
			 member_email_search = $("#Search-Member-Email-Value").val();
			 callMemberListAjax();
		});
		
		//회원 구매내역 검색
		$("#Member-Drink-Search-Btn").click(function(){
			 drink_date_search = $("#Search-Member-Drink-Value").val();
			 var drinkReservationData = {member_no : member_no, start_page : drink_start_index, date : drink_date_search};
			 callMemberDrinkReservationListAjax(drinkReservationData);
		});
		
		//회원 미팅룸 예약내역 검색
		$("#Member-MeetingRoom-Search-Btn").click(function(){
			 meetingRoom_date_search = $("#Search-Member-MeetingRoom-Value").val();
			 var meetingRoomReservationData = {member_no : member_no, start_page : meetingRoom_start_index, date : meetingRoom_date_search};
			 callMemberMeetingRoomReservationListAjax(meetingRoomReservationData);
		});
		//전체 선택 MouseEnter
		$("#Member-List-Table-Check-All-th").mouseenter(function() {
			$(this).html("<a id='Member-List-Table-Check-All-Btn' class='btn btn-success'><em class='fa fa-check-circle'></em></a>");
			//All-Check Click Make Icon
			$("#Member-List-Table-Check-All-Btn").click(function() {
				if (count == 0) {
					$("#Member-List-Table .Select-Single-Check-Div").hide();
					$("#Member-List-Table .Show-Check-Icon-Div").show();
					count++;
				} 
				else {
					$("#Member-List-Table .Select-Single-Check-Div").show();
					$("#Member-List-Table .Show-Check-Icon-Div").hide();
					count = 0;
				}
			});
		});
		//전체 선택 MouseLeave
		$("#Member-List-Table-Check-All-th").mouseleave(function() {
			$(this).html("전체 선택");
		});
		//Member-Table-Show-Icon-Btn Click Make Icon
		$(document).on("click", ".Member-List-Table-Show-Icon-Btn",function() {
			var index = $(".Member-List-Table-Show-Icon-Btn").index(this);
			var div = $(".Member-List-Table-Show-Icon-Btn").eq(index).parent();
			div.hide();
			$(div).siblings(".Show-Check-Icon-Div").show();
		});
		//Check-Btn Click Remove Icon
		$(document).on("click", ".Member-List-Table-Check-Btn", function() {
			var index = $(".Member-List-Table-Check-Btn").index(this);
			var div = $(".Member-List-Table-Check-Btn").eq(index).parent();
			div.hide();
			$(div).siblings(".Select-Single-Check-Div").show();
		});
		//Member-Table-Delete-Btn Click Delete Member
		$("#Member-List-Table-Delete-Btn").click(
				function() {
					var delete_count = 0;
					$("#Member-List-Table #Show-Check-Icon-Div").each(
							function() {
								//Find Check-Icon
								if ($(this).css("display") == "block") {
									var member_num = $(this).parent().siblings(
											"#Member-List-Table-Num-td").text();
									delete_count++;

								}
							});
					if (delete_count != 0) {
						if (confirm("체크 된 항목들을 정말 삭제하시겠습니까?")) {

						}
					} else {
						alert("선택된 항목이 없습니다.");
					}
				});
	});
	function callMemberListAjax(){
		//회원 리스트 호출
		var jsonData = {start_page : member_start_index, member_email_search : member_email_search};
		callList_Ajax("/member.list.manager", successMemberList, errorMemberList, jsonData);
		function successMemberList(data){
			$("#Member-List-Table tbody").html('');
			$.each(data.memberList, function(index, list){
				var member_code = "";
				if(list.member_code == 1)
					member_code = "회원";
				else if(list.member_code == 2)
					member_code = "점장";
				var html = '<tr>' +
				'<td class="Member-List-Table-Check-td" class="text-center">' +
					'<div class="Select-Single-Check-Div">' +
						'<a class="Member-List-Table-Show-Icon-Btn" href="#" style="text-decoration: none">선택</a>' +
					'</div>' +
					'<div class="Show-Check-Icon-Div" style="display: none">' +
						'<a class="Member-List-Table-Check-Btn" class="btn btn-success"><em class="fa fa-check-circle"></em></a>' +
					'</div>' +
				'</td>' +
				'<td class="Member-Table-Num-td">'+list.member_no+'</td>' +
				'<td>'+list.member_name+'</td>' +
				'<td>'+list.member_birth+'</td>' +
				'<td>'+list.member_email+'</td>' +
				'<td>'+list.member_tel+'</td>' +
				'<td>'+member_code+'</td>' +
				'<td><a href="#" class="Show-Detail-Member-Btn">상세보기</td>' +
			'</tr>';
				$("#Member-List-Table tbody").append(html);
			});
		}
		function errorMemberList(){
			alert("ajax 예외 발생 : Member_Management:callMemberListAjax");
		}
	}
	//미팅룸 리스트
	function callMemberMeetingRoomReservationListAjax(meetingRoomReservationData){
		callList_Ajax("/find.meetingRoomReservationList.member.manage", successMemberMeetingRoomReservationList, null, meetingRoomReservationData);
		function successMemberMeetingRoomReservationList(data){
			$("#Member-MeetingRoom-Reservation-List-Table tbody").html("");
			$.each(data.myPageMeetingRoomReservationList, function(index, list){
				var meeting_reservation_time = "";
				if(list.meeting_reservation_time == 1)
					meeting_reservation_time = "10:00 ~ 12:00";
				else if(list.meeting_reservation_time == 2)
					meeting_reservation_time = "12:00 ~ 14:00";
				else if(list.meeting_reservation_time == 3)
					meeting_reservation_time = "14:00 ~ 16:00";
				else if(list.meeting_reservation_time == 4)
					meeting_reservation_time = "16:00 ~ 18:00";
				else if(list.meeting_reservation_time == 5)
					meeting_reservation_time = "18:00 ~ 20:00";
				else if(list.meeting_reservation_time == 6)
					meeting_reservation_time = "20:00 ~ 22:00";
				var html = '<tr>' +
					'<td>'+list.meeting_order_date+'</td>' +
					'<td>'+String(list.meeting_reservation_date).substring(0,10)+'</td>' +
					'<td>'+list.store_name+'</td>' +
					'<td>'+list.meeting_no+'번</td>' +
					'<td>'+meeting_reservation_time+'</td>' +
				'</tr>';
				
				$("#Member-MeetingRoom-Reservation-List-Table tbody").append(html);
			});
		}
	}
	//음료주문 리스트
	function callMemberDrinkReservationListAjax(drinkReservationData){
		callList_Ajax("/find.drinkReservationList.member.manage", successMemberDrinkReservationList, null, drinkReservationData);
		function successMemberDrinkReservationList(data){
			$("#Member-Drink-Reservation-List-Table tbody").html("");
			$.each(data.memberDrinkReservationList, function(index, list){
				var html = '<tr><td>'+list.menu_payment_date+'</td>' +
					'<td><a href="#" class="Member-Detail-Drink-Reservation-Btn">상세보기</a></td>' +
					'<td>'+list.store_name+'</td>' +
					'<td>'+list.menu_payment_style+'</td>' +
					'<td>'+list.menu_total_price+'원</td></tr>';
				$("#Member-Drink-Reservation-List-Table tbody").append(html);
			});
		}
	}
	function callMemberBoardHistoryListAjax(){
		callList_Ajax("/find.boardHistoryList.member.manage", successMemberBoardHistoryList, null, null);
		//게시판 리스트
		function successMemberBoardHistoryList(data){
			
		}
	}
</script>
<style>
#Member-Search-Btn {
	cursor: pointer;
}

.pagination li a{
	cursor: pointer;
}
.pagination li a:hover{
	background-color: #0F7864;
}
</style>
<div id="Member-Management-Div" class="div-fade"
	style="padding-top: 0px; color: black; margin-top: 100px">
	<div>
		<div>
			<div class="panel panel-default panel-table">
				<div class="panel-heading">
					<div class="row">
						<div class="col col-xs-6">
							<!-- Title -->
							<h3 class="panel-title">회원 관리</h3>
						</div>
					</div>
				</div>
				<div class="panel-body">
					<!-- 회원 검색 -->
					<form id="Member-Search-Form" class="form-inline" method="post" action="search.member.manager">
						<div class="form-group">
							<div class="input-group">
								<!-- 입력  -->
								<input type="text" class="form-control" id="Search-Member-Email-Value"
									placeholder="이메일 입력...">
								<!-- 검색 버튼 -->
								<div id="Member-Search-Btn" class="input-group-addon"
									style="background-color: white; color: green">
									<i class="fa fa-search"></i>
								</div>
							</div>
						</div>
					</form>
					<!-- Member-Table -->
					<table id="Member-List-Table"
						class="table table-striped table-bordered table-list">
						<!-- Member-Table-Header -->
						<thead>
							<tr>
								<th class="text-center" id="Member-List-Table-Check-All-th"
									width="90px">전체 선택</th>
								<th>회원 번호</th>
								<th>이름</th>
								<th>생년월일</th>
								<th width="180px">이메일</th>
								<th>핸드폰 번호</th>
								<th>회원 구분</th>
								<th class="text-center"><a id="Member-Table-Delete-Btn"
									class="btn btn-danger"><em class="fa fa-trash"></em></a></th>
							</tr>
						</thead>
						<!-- Member-Table-Body -->
						<tbody>
						</tbody>
					</table>
					<!-- Pagination -->
					<div class="col-sm-offset-5">
						<nav>
							<ul class="pagination">
								<li id="Previous-Page-Member-Manage"><a href="#" aria-label="Previous"> <span
										aria-hidden="true">&laquo;</span>
								</a></li>
								<li><a class="Member_Page_Num">1</a></li>	
								<li><a class="Member_Page_Num">2</a></li>	
								<li><a class="Member_Page_Num">3</a></li>	
								<li><a class="Member_Page_Num">4</a></li>	
								<li><a class="Member_Page_Num">5</a></li>	
								<li id="Next-Page-Member-Manage"><a href="#" aria-label="Next"> <span
										aria-hidden="true">&raquo;</span>
								</a></li>
							</ul>
						</nav>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 구매 내역 -->
<div class="col-md-4" style="padding-top: 0px; color: black;">
	<div class="panel panel-default panel-table">
		<div class="panel-heading">
			<div class="row">
				<div class="col col-xs-6">
					<!-- Title -->
					<h3 class="panel-title">구매 내역</h3>
				</div>
			</div>
		</div>
		<div class="panel-body">
			<form class="form-inline">
				<div class="form-group">
					<div class="input-group">
						<!-- 입력  -->
						<input type="text" class="form-control" id="Search-Member-Drink-Value"
							placeholder="YYYY/MM/DD">
						<!-- 검색 버튼 -->
						<div id="Member-Drink-Search-Btn" class="input-group-addon"
							style="background-color: white; color: green">
							<i class="fa fa-search"></i>
						</div>
					</div>
				</div>
			</form>
			<table id="Member-Drink-Reservation-List-Table"
				class="table table-striped table-bordered table-list"
				style="font-size: 8pt">
				<!-- Member-Table-Header -->
				<thead>
					<tr>
						<th>구매 날짜</th>
						<th>구매 상품</th>
						<th>매장명</th>
						<th>결제 방법</th>
						<th>결제 금액</th>
					</tr>
				</thead>
				<!-- 구매내역 -->
				<tbody>
				</tbody>
			</table>
			<!-- Pagination -->
			<div class="col-sm-offset-4">
				<nav>
					<ul class="pagination pagination-sm">
						<li><a href="#" aria-label="Previous"> <span
								aria-hidden="true">&laquo;</span>
						</a></li>
						<li><a class="Member_Drink_Page_Num">1</a></li>
						<li><a class="Member_Drink_Page_Num">2</a></li>
						<li><a class="Member_Drink_Page_Num">3</a></li>
						<li><a class="Member_Drink_Page_Num">4</a></li>
						<li><a class="Member_Drink_Page_Num">5</a></li>
						<li><a aria-label="Next"> <span
								aria-hidden="true">&raquo;</span>
						</a></li>
					</ul>
				</nav>
			</div>
		</div>
	</div>
</div>
<!-- 미팅룸 예약 내역 -->
<div class="col-md-4" style="padding-top: 0px; color: black;">
	<div class="panel panel-default panel-table">
		<div class="panel-heading">
			<div class="row">
				<div class="col col-xs-6">
					<!-- Title -->
					<h3 class="panel-title">미팅룸 예약 내역</h3>
				</div>
			</div>
		</div>
		<div class="panel-body">
			<form class="form-inline">
				<div class="form-group">
					<div class="input-group">
						<!-- 입력  -->
						<input type="text" class="form-control" id="Search-Member-MeetingRoom-Value"
							placeholder="YYYY/MM/DD">
						<!-- 검색 버튼 -->
						<div id="Member-MeetingRoom-Search-Btn" class="input-group-addon"
							style="background-color: white; color: green">
							<i class="fa fa-search"></i>
						</div>
					</div>
				</div>
			</form>
			<!-- 미팅룸 예약 내역 테이블 -->
			<table id="Member-MeetingRoom-Reservation-List-Table"
				class="table table-striped table-bordered table-list"
				style="font-size: 8pt">
				<thead>
					<tr>
						<th>구매 날짜</th>
						<th>예약 날짜</th>
						<th>매장명</th>
						<th>미팅룸 번호</th>
						<th>예약 시간</th>
					</tr>
				</thead>
				<!-- Member-Table-Body -->
				<tbody>
				</tbody>
			</table>
			<!-- Pagination -->
			<div class="col-sm-offset-4">
				<nav>
					<ul class="pagination pagination-sm">
						<li><a href="#" aria-label="Previous"> <span
								aria-hidden="true">&laquo;</span>
						</a></li>
						<li><a class="Member_MeetingRoom_Page_Num">1</a></li>
						<li><a class="Member_MeetingRoom_Page_Num">2</a></li>
						<li><a class="Member_MeetingRoom_Page_Num">3</a></li>
						<li><a class="Member_MeetingRoom_Page_Num">4</a></li>
						<li><a class="Member_MeetingRoom_Page_Num">5</a></li>
						<li><a aria-label="Next"> <span
								aria-hidden="true">&raquo;</span>
						</a></li>
					</ul>
				</nav>
			</div>
		</div>
	</div>
</div>
<!-- 게시판 -->
<div class="col-md-4" style="padding-top: 0px; color: black;">
	<div class="panel panel-default panel-table">
		<div class="panel-heading">
			<div class="row">
				<div class="col col-xs-6">
					<!-- Title -->
					<h3 class="panel-title">게시판 보기</h3>
				</div>
			</div>
		</div>
		<div class="panel-body">
			<form class="form-inline">
				<div class="form-group">
					<div class="input-group">
						<!-- 입력  -->
						<input type="text" class="form-control" id="exampleInputAmount"
							placeholder="YYYY/MM/DD">
						<!-- 검색 버튼 -->
						<div id="Member-Board-Search-Btn" class="input-group-addon"
							style="background-color: white; color: green">
							<i class="fa fa-search"></i>
						</div>
					</div>
				</div>
			</form>
			<!-- Member-Table -->
			<table id="Member-Table"
				class="table table-striped table-bordered table-list"
				style="font-size: 8pt">
				<!-- Member-Table-Header -->
				<thead>
					<tr>
						<th>작성 날짜</th>
						<th>제목</th>
						<th>내용</th>
						<th>카테고리</th>
					</tr>
				</thead>
				<!-- Member-Table-Body -->
				<tbody>
					<tr>
						<td>2016년 6월 30일</td>
						<td>테스트</td>
						<td><a href="#">상세보기</a></td>
						<td>고객의 소리</td>
					</tr>
				</tbody>
			</table>
			<!-- Pagination -->
			<div class="col-sm-offset-4">
				<nav>
					<ul class="pagination pagination-sm">
						<li id="Previous-Page-Member-Manage"><a href="#" aria-label="Previous"> <span
								aria-hidden="true">&laquo;</span>
						</a></li>
						<li><a href="#">1</a></li>
						<li><a href="#">2</a></li>
						<li><a href="#">3</a></li>
						<li><a href="#">4</a></li>
						<li><a href="#">5</a></li>
						<li><a href="#" aria-label="Next"> <span
								aria-hidden="true">&raquo;</span>
						</a></li>
					</ul>
				</nav>
			</div>
		</div>
	</div>
</div>

