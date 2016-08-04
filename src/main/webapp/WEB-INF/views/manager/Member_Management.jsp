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
	var board_start_page = 1;
	var board_start_index = 0;
	var board_date_search = "";
	var board_pagePer_num = 3;
	var board_category = "recipe";
	$(function() {
		$("#Show-Detail-Purchase-List").hide();
		//처음 페이지 시작시 회원 리스트 호출
		callMemberListAjax();
		//회원 리스트 페이지 초기화
		var memberPage = $(".Member_Page_Num").length;
		for(var i=0; i<memberPage; i++){
			$(".Member_Page_Num").eq(i).text(i+1);
		}
		//구매내역 리스트 페이지 초기화
		var drinkReservationPage = $(".Member_Drink_Page_Num").length;
		for(var i=0; i<drinkReservationPage; i++){
			$(".Member_Drink_Page_Num").eq(i).text(i+1);
		}
		//미팅룸 예약 내역 리스트 페이지 초기화
		var meetingRoomReservationPage = $(".Member_MeetingRoom_Page_Num").length;
		for(var i=0; i<meetingRoomReservationPage; i++){
			$(".Member_MeetingRoom_Page_Num").eq(i).text(i+1);
		}
		//게시판 리스트 페이지 초기화
		boardPageInit();
		//회원 리스트 페이징
		$(".Member_Page_Num").click(function(){
			var index = $(".Member_Page_Num").index(this);
			member_start_page = $(".Member_Page_Num").eq(index).text();
			member_start_index = (member_start_page -1) * member_pagePer_num;
			$("#Member-List-Table tbody").html('');
			callMemberListAjax();
		});
		//회원 리스트 페이징 < 버튼 클릭
		$("#Previous-Page-Member-Manage").click(function(){
			var firstPage = $(".Member_Page_Num").eq(0).text();
			if(firstPage > 1 ){
				var start_index = firstPage - 5;
				$(".Member_Page_Num").eq(0).text(start_index);
				$(".Member_Page_Num").eq(1).text(start_index+1);
				$(".Member_Page_Num").eq(2).text(start_index+2);
				$(".Member_Page_Num").eq(3).text(start_index+3);
				$(".Member_Page_Num").eq(4).text(start_index+4);
			}
		});
		//회원 리스트 페이징 > 버튼 클릭
		$("#Next-Page-Member-Manage").click(function(){
			var firstPage = $(".Member_Page_Num").eq(0).text();
			var start_page = Number(firstPage) + 5;
			$(".Member_Page_Num").eq(0).text(start_page);
			$(".Member_Page_Num").eq(1).text(start_page + 1);
			$(".Member_Page_Num").eq(2).text(start_page + 2);
			$(".Member_Page_Num").eq(3).text(start_page + 3);
			$(".Member_Page_Num").eq(4).text(start_page + 4);
		});
		//구매 내역 리스트 페이징 < 버튼 클릭
		$("#Pre-Page-Member-Drink-Manage").click(function(){
			var firstPage = $(".Member_Drink_Page_Num").eq(0).text();
			if(firstPage > 1 ){
				var start_index = firstPage - 5;
				$(".Member_Drink_Page_Num").eq(0).text(start_index);
				$(".Member_Drink_Page_Num").eq(1).text(start_index+1);
				$(".Member_Drink_Page_Num").eq(2).text(start_index+2);
				$(".Member_Drink_Page_Num").eq(3).text(start_index+3);
				$(".Member_Drink_Page_Num").eq(4).text(start_index+4);
			}
		});
		//구매 내역 리스트 페이징 > 버튼 클릭
		$("#Next-Page-Member-Drink-Manage").click(function(){
			var firstPage = $(".Member_Drink_Page_Num").eq(0).text();
			var start_page = Number(firstPage) + 5;
			$(".Member_Drink_Page_Num").eq(0).text(start_page);
			$(".Member_Drink_Page_Num").eq(1).text(start_page + 1);
			$(".Member_Drink_Page_Num").eq(2).text(start_page + 2);
			$(".Member_Drink_Page_Num").eq(3).text(start_page + 3);
			$(".Member_Drink_Page_Num").eq(4).text(start_page + 4);
		});
		
		//미팅룸 예약 내역 리스트 페이징 < 버튼 클릭
		$("#Pre-Page-Member-MeetingRoom-Manage").click(function(){
			var firstPage = $(".Member_MeetingRoom_Page_Num").eq(0).text();
			if(firstPage > 1 ){
				var start_index = firstPage - 5;
				$(".Member_MeetingRoom_Page_Num").eq(0).text(start_index);
				$(".Member_MeetingRoom_Page_Num").eq(1).text(start_index+1);
				$(".Member_MeetingRoom_Page_Num").eq(2).text(start_index+2);
				$(".Member_MeetingRoom_Page_Num").eq(3).text(start_index+3);
				$(".Member_MeetingRoom_Page_Num").eq(4).text(start_index+4);
			}
		});
		//미팅룸 예약 내역 리스트 페이징 > 버튼 클릭
		$("#Next-Page-Member-MeetingRoom-Manage").click(function(){
			var firstPage = $(".Member_MeetingRoom_Page_Num").eq(0).text();
			var start_page = Number(firstPage) + 5;
			$(".Member_MeetingRoom_Page_Num").eq(0).text(start_page);
			$(".Member_MeetingRoom_Page_Num").eq(1).text(start_page + 1);
			$(".Member_MeetingRoom_Page_Num").eq(2).text(start_page + 2);
			$(".Member_MeetingRoom_Page_Num").eq(3).text(start_page + 3);
			$(".Member_MeetingRoom_Page_Num").eq(4).text(start_page + 4);
		});
		
		//게시판 리스트 페이징 < 버튼 클릭
 		$("#Pre-Page-Member-Board-Manage").click(function(){
			var firstPage = $(".Member_Board_Page_Num").eq(0).text();
			if(firstPage > 1 ){
				var start_index = firstPage - 5;
				$(".Member_Board_Page_Num").eq(0).text(start_index);
				$(".Member_Board_Page_Num").eq(1).text(start_index+1);
				$(".Member_Board_Page_Num").eq(2).text(start_index+2);
				$(".Member_Board_Page_Num").eq(3).text(start_index+3);
				$(".Member_Board_Page_Num").eq(4).text(start_index+4);
			}
		});
		//게시판 예약 내역 리스트 페이징 > 버튼 클릭
		$("#Next-Page-Member-Board-Manage").click(function(){
			var firstPage = $(".Member_Board_Page_Num").eq(0).text();
			var start_page = Number(firstPage) + 5;
			$(".Member_Board_Page_Num").eq(0).text(start_page);
			$(".Member_Board_Page_Num").eq(1).text(start_page + 1);
			$(".Member_Board_Page_Num").eq(2).text(start_page + 2);
			$(".Member_Board_Page_Num").eq(3).text(start_page + 3);
			$(".Member_Board_Page_Num").eq(4).text(start_page + 4);
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
		
		//회원 게시판 페이징
		$(".Member_Board_Page_Num").click(function(){
			var index = $(".Member_Board_Page_Num").index(this);
			board_start_page = $(".Member_Board_Page_Num").eq(index).text();
			board_start_index = (board_start_page -1) * board_pagePer_num;
			var boardHistoryData = {member_no : member_no, start_page : board_start_index, date : board_date_search};
			callMemberBoardHistoryListAjax(boardHistoryData);
		});
		
		//상세 보기 클릭
		$(document).on("click", ".Show-Detail-Member-Btn", function(){
			//값 초기화
			$(".form-control").val("");
			drink_date_search = "";
			meetingRoom_date_search = "";
			board_date_search = "";
			var index = $(".Show-Detail-Member-Btn").index(this);
			member_no = $(".Member-Table-Num-td").eq(index).text();
			var meetingRoomReservationData = {member_no : member_no, start_page : meetingRoom_start_index, date : meetingRoom_date_search};
			var drinkReservationData = {member_no : member_no, start_page : drink_start_index, date : drink_date_search};
			var boardHistoryData = {member_no : member_no, start_page : board_start_index, date : board_date_search};
			callMemberMeetingRoomReservationListAjax(meetingRoomReservationData);
			callMemberDrinkReservationListAjax(drinkReservationData);
			callMemberBoardHistoryListAjax(boardHistoryData);
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
		
		//회원 구매내역 상세보기 클릭
		$(document).on("click", ".Member-Detail-Drink-Reservation-Btn", function(){
			var index = $(".Member-Detail-Drink-Reservation-Btn").index(this);
			var menu_payment_no = $(".Member-Detail-Drink-Reservation-Btn").eq(index).attr("id");
			callMyDrinkDetailListAjax(menu_payment_no);
		});
		
		//상세 보기 클릭시 해당 메뉴 리스트 호출
		function callMyDrinkDetailListAjax(menu_payment_no){
			var jsonData = {menu_payment_no : menu_payment_no};
			callList_Ajax("/my_page.drinkDetailList.member", successMyDrinkDetailList, errorMyDrinkDetailList, jsonData);
			function successMyDrinkDetailList(data){
				//초기화
				$("#My-Page-Detail-Menu-List-Table tbody").html('');
				var total_price = 0;
				$.each(data.menuDetailList, function(index, list){
					var menu_count = list.menu_count.split(",");
					total_price += list.menu_price * menu_count[0];
					var html =	'<tr>';
					html += '<td>'+list.menu_name+'</td>';
					html += '<td>'+menu_count[0]+'</td>';
					html += '<td>'+list.menu_price+'원</td>';
					html += '<td>'+list.menu_price * menu_count[0]+'원</td>';
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
		
		//회원 구매내역 상세 보기 닫기 클릭
		$("#Show-Detail-Purchase-List-Modal-Hide-Btn").click(function(){
			$("#Show-Detail-Purchase-List").hide();
		});
		
		//회원 미팅룸 예약내역 검색
		$("#Member-MeetingRoom-Search-Btn").click(function(){
			 meetingRoom_date_search = $("#Search-Member-MeetingRoom-Value").val();
			 var meetingRoomReservationData = {member_no : member_no, start_page : meetingRoom_start_index, date : meetingRoom_date_search};
			 callMemberMeetingRoomReservationListAjax(meetingRoomReservationData);
		});
		
		//게시판 검색
		$("#Member-Board-Search-Btn").click(function(){
			 board_date_search = $("#Search-Member-Board-Value").val();
			 var boardHistoryData = {member_no : member_no, start_page : board_start_index, date : board_date_search};
			 callMemberBoardHistoryListAjax(boardHistoryData);
		});
		
		//게시판 카테고리 클릭
		$("#Board-History-Category-Btn").click(function(){
			if(board_category == "recipe")
				board_category = "clientSound";
			else
				board_category = "recipe"
			
			
			//값 초기화
			$("#Search-Member-Board-Value").val("");
			board_date_search = "";
			var boardHistoryData = {member_no : member_no, start_page : board_start_index, date : board_date_search};
			callMemberBoardHistoryListAjax(boardHistoryData);
			//페이지 초기화
			boardPageInit();
			$(".Member_Board_Page_Num").eq(0).trigger("click");
		});
		
		//게시판 - 레시피 상세보기 클릭
		$(document).on("click", ".Member-Detail-Recipe-Btn", function(){
			var index = $(".Member-Detail-Recipe-Btn").index(this);
			var board_recipe_no = $(".Member-Detail-Recipe-Btn").attr("id");
			var url = "/community.recipe_read?board_recipe_no="+board_recipe_no;
			window.open(url, "_blank");  
		});
		
		//게시판 - 고객의 소리 상세보기 클릭
		$(document).on("click", ".Member-Detail-Client-Board-Btn", function(){
			var index = $(".Member-Detail-Client-Board-Btn").index(this);
			var board_num = $(".Member-Detail-Client-Board-Btn").attr("id");
			alert(board_num);
			var url = "/read.client.board?board_num="+board_num;
			window.open(url, "_blank");  
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
		//회원 삭제
		$("#Member-Table-Delete-Btn").click(
				function() {
					var member_no = new Array();
					var delete_count = 0;
					$("#Member-List-Table .Show-Check-Icon-Div").each(
							function() {
								//Find Check-Icon
								if ($(this).css("display") == "block") {
									member_no.push($(this).parent().siblings(
											".Member-Table-Num-td").text());
									delete_count++;

								}
							});
					if (delete_count != 0) {
						if (confirm("체크 된 항목들을 정말 삭제하시겠습니까?")) {
							alert(member_no.length);
							for(var i=0; i<member_no.length; i++){
								var jsonData = {member_no : member_no[i]};
								callList_Ajax("/delete.member.manage", successDeleteMember, null, jsonData);
							}
						}
					} else {
						alert("선택된 항목이 없습니다.");
					}
				});
	});
	
	function successDeleteMember(data){
		
		if(data == false){
			alert("회원 삭제중 오류가 발생하였습니다.\n해당 회원은 점장이므로 매장을 삭제하시거나 해당 매장의 점장을 변경 후 삭제해주세요.");
			return false;
		}
		location.reload();
	}
	
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
						'<a class="Member-List-Table-Check-Btn" class="btn btn-success"><em class="fa fa-check-circle fa-1x"></em></a>' +
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
					'<td><a href="#" id="'+list.menu_payment_no+'" class="Member-Detail-Drink-Reservation-Btn">상세보기</a></td>' +
					'<td>'+list.store_name+'</td>' +
					'<td>'+list.menu_payment_style+'</td>' +
					'<td>'+list.menu_total_price+'원</td></tr>';
				$("#Member-Drink-Reservation-List-Table tbody").append(html);
			});
		}
	}
	//게시판 리스트
	function callMemberBoardHistoryListAjax(boardHistoryData){
		callList_Ajax("/find.boardHistoryList.member.manage", successMemberBoardHistoryList, null, boardHistoryData);
		function successMemberBoardHistoryList(data){
			$("#Member-Board-History-List-Table tbody").html("");
			if(board_category == "recipe")
				memberRecipeHistory(data);
			else
				memberClientHistory(data);
		}
	}
	//게시판 - 레시피
	function memberRecipeHistory(data){
		$.each(data.memberBoardRecipeHistoryList, function(index, list){
			var html = '<tr>' + 
				'<td>'+String(list.board_recipe_date).substring(0,10)+'</td>' + 
				'<td>'+list.board_recipe_title+'</td>' + 
				'<td><a href="#" id="'+list.board_recipe_no+'" class="Member-Detail-Recipe-Btn">상세보기</a></td>' + 
				'<td>레시피</td>' + 
			'</tr>';
			$("#Member-Board-History-List-Table tbody").append(html);
		});
	}
	//게시판 - 고객의 소리
	function memberClientHistory(data){
		$.each(data.memberBoardClientHistroyList, function(index, list){
			var html = '<tr>' + 
				'<td>'+String(list.board_date).substring(0,10)+'</td>' + 
				'<td>'+list.board_subject+'</td>' + 
				'<td><a href="#" id="'+list.board_num+'" class="Member-Detail-Client-Board-Btn">상세보기</a></td>' + 
				'<td>고객의 소리</td>' + 
			'</tr>';
			$("#Member-Board-History-List-Table tbody").append(html);
		});
	}
	
	//게시판 페이징 초기화
	function boardPageInit(){
		//게시판 리스트 페이지 초기화
		var boardHistoryPage = $(".Member_Board_Page_Num").length;
		for(var i=0; i<boardHistoryPage; i++){
			$(".Member_Board_Page_Num").eq(i).text(i+1);
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
	style="padding-top: 0px; color: black;">
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
								<li><a class="Member_Page_Num"></a></li>	
								<li><a class="Member_Page_Num"></a></li>	
								<li><a class="Member_Page_Num"></a></li>	
								<li><a class="Member_Page_Num"></a></li>	
								<li><a class="Member_Page_Num"></a></li>	
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
						<li><a href="#" id="Pre-Page-Member-Drink-Manage" aria-label="Previous"> <span
								aria-hidden="true">&laquo;</span>
						</a></li>
						<li><a class="Member_Drink_Page_Num"></a></li>
						<li><a class="Member_Drink_Page_Num"></a></li>
						<li><a class="Member_Drink_Page_Num"></a></li>
						<li><a class="Member_Drink_Page_Num"></a></li>
						<li><a class="Member_Drink_Page_Num"></a></li>
						<li><a id="Next-Page-Member-Drink-Manage" aria-label="Next"> <span
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
						<li><a id="Pre-Page-Member-MeetingRoom-Manage" aria-label="Previous"> <span
								aria-hidden="true">&laquo;</span>
						</a></li>
						<li><a class="Member_MeetingRoom_Page_Num"></a></li>
						<li><a class="Member_MeetingRoom_Page_Num"></a></li>
						<li><a class="Member_MeetingRoom_Page_Num"></a></li>
						<li><a class="Member_MeetingRoom_Page_Num"></a></li>
						<li><a class="Member_MeetingRoom_Page_Num"></a></li>
						<li><a id="Next-Page-Member-MeetingRoom-Manage" aria-label="Next"> <span
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
						<input type="text" class="form-control" id="Search-Member-Board-Value"
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
			<table id="Member-Board-History-List-Table"
				class="table table-striped table-bordered table-list"
				style="font-size: 8pt">
				<!-- Member-Table-Header -->
				<thead>
					<tr>
						<th>작성 날짜</th>
						<th>제목</th>
						<th>내용</th>
						<th id="Board-History-Category-Btn" style="cursor: pointer;">카테고리</th>
					</tr>
				</thead>
				<tbody>
				</tbody>
			</table>
			<!-- Pagination -->
			<div class="col-sm-offset-4">
				<nav>
					<ul class="board_pagination pagination pagination-sm">
						<li id="Pre-Page-Member-Board-Manage"><a href="#" aria-label="Previous"> <span
								aria-hidden="true">&laquo;</span>
						</a></li>
						<li><a class="Member_Board_Page_Num"></a></li>
						<li><a class="Member_Board_Page_Num"></a></li>
						<li><a class="Member_Board_Page_Num"></a></li>
						<li><a class="Member_Board_Page_Num"></a></li>
						<li><a class="Member_Board_Page_Num"></a></li>
						<li><a id="Next-Page-Member-Board-Manage" href="#" aria-label="Next"> <span
								aria-hidden="true">&raquo;</span>
						</a></li>
					</ul>
				</nav>
			</div>
		</div>
	</div>
</div>

<!-- Meber_Purchase_List_Modal -->
<jsp:include page="../mypage/Member_Purchase_List_Modal.jsp" />