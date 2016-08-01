
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

<script>
var today = new Date();
var currentHour = today.getHours();
var currentMinute = today.getMinutes();
var menu_reserve_time;

	$(function(){
		//Websocket Connect
		connect();
		//예약시간 라디오 버튼 값 변경
		$("input[name=order_style]").change(function(){
			if($(this).val() == "direct"){
				$("#select_hour").hide();
				$("#select_minute").hide();
				$("#select_hour option").eq(0).attr("selected", "selected");
				$("#select_minute option").eq(0).attr("selected", "selected");
				menu_reserve_time = 10;
			}
			else{
				$("#select_hour").show();
				//시간이 지난 option은 disabled 처리
				$("#select_hour option").each(function(){
					if($(this).text() < currentHour){
						$(this).attr("disabled", "disabled");
						$(this).text("불가");
					}
				});
				$("#select_minute option").each(function(){
					if(Number($(this).text()) + 10 < currentMinute){
						$(this).attr("disabled", "disabled");
						$(this).text("불가");
					}
				});
			}
		});
		
		//예약 시간 설정 셀렉트 박스
		$("#select_hour").change(function(){
			if($(this).text() != "시"){
				menu_reserve_time = $(this).find("option:selected").text();
				$("#select_minute").show();
			}
		});
		
		//예약 분 설정 셀렉트 박스
		$("#select_minute").change(function(){
			if($(this).text() != "분"){
				menu_reserve_time += ":" + $(this).find("option:selected").text() + ":00";
			}
		});
		
		//결제하기 버튼 클릭
		$("#payment_cart").click(function(){
			if(confirm("위 내용대로 결제 하시겠습니까?")){
				var menu_no = "";
				var menu_count = "";
				var menu_option = "";
				//메뉴 정보 가져오기
				$("#selected_option_table .cart_list_tr").each(function(){
					menu_no += $(this).find(".cart_menu_no").val() + ",";
					menu_count += $(this).find(".cart_menu_count").text() + ",";
					var option_text = "";
					if($(this).find(".cart_menu_option").val() == ""){
						option_text = "없음";
					}
					else{
						option_text = $(this).find(".cart_menu_option").val();
					}
					menu_option += option_text + ",";
				});
				var order_name = $("#order_name").val();
				var order_tel = $("#order_tel").val();
				var menu_payment_style = $("input[name=payment_style]:checked").val();
				var menu_total_price = $("#menu_total_price").text();
				var menu_total_mileage = $("#menu_total_mileage span").text();
				var order_style = $("input[name=order_style]:checked").val();
				$.ajax({
					url:"/insert.menu_payment.order",
					type:"post",
					dataType:"json",
					data:{order_name:order_name, order_tel:order_tel, menu_reserve_time:menu_reserve_time, 
						  menu_payment_style:menu_payment_style, menu_total_price:menu_total_price, menu_total_mileage:menu_total_mileage,
						  menu_no:menu_no, menu_count:menu_count, menu_option:menu_option, order_style:order_style},
					success:function(data){
							if(data == true){
								alert("주문이 완료되었습니다.");
								//sendName(store_no, webCk);
								location.href="/go.reservation";
							}
							else{
								alert("주문에 실패하였습니다. 다시 시도해주세요.");
							}
					},
					 error:function(request,status,error){
					        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					 }
				});
			}
		});
	})
	
	/*
	WebSocket
	*/
	function connect() {
		if ('WebSocket' in window) {
			console.log('Websocket supported');
			socket = new WebSocket('ws://' + document.location.hostname+ ':8080/owner//websocket');
			console.log('Connection attempted');
			socket.onopen = function() {
				console.log('Connection open!');
			}
			socket.onclose = function() {
				console.log('Disconnecting connection');
			}
			socket.onmessage = function(evt) {
				var received_msg = evt.data;
				console.log(received_msg);
				console.log('message received!');
				showMessage(received_msg);
			}
		} else {
			console.log('Websocket not supported');
		}
	}
	function disconnect() {
		console.log("Disconnected");
	}
	function sendName(store_no, webCk) {
		socket.send(JSON.stringify({'store_no' : store_no, 'webCk' : webCk}));
	}
	function showMessage(message) {
		alert(meessage);
		
	}
	function showmyMessage(message){
		alert(message);
	}
</script>
<style>
#store_name:read-only{
	background-color: white;
	border:none;
}
</style>
<!-- Header -->
<jsp:include page="/WEB-INF/views/layout/Header.jsp" />
<div class="row" style="color: black">
	<!-- Page Content -->
	<div class="col-lg-offset-3">
		<div class="row">
			<div class="col-sm-8"></div>
			<h2>주문서 작성 결제</h2>
			<hr/>
			<h2 style="font-size:15px;font-weight:bold;margin-top:-2px">주문 정보</h2>
			
			<form id="payment_form" action="front" method="post">	
				<table class="table table-bordered">
					<tr>
						<td bgcolor="#ecf0f1" style="font-size:10px;width:140px;text-align:left;vertical-align: middle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;주문자</td>
						<td colspan="3"><input type="text" id="order_name" style="width:130px; height:20px;text-align:center;vertical-align: middle" value="${member_dto.member_name}" /></td>
					</tr>
					
					<tr>
						<td bgcolor="#ecf0f1" style="font-size:10px;width:140px;text-align:left;vertical-align: middle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;매장</td>
						<td colspan="3"><input type="text" id="store_name" style="width:130px; height:20px;text-align:center;vertical-align: middle" value="${store_dto.store_name}" readonly="readonly"/></td>
					</tr>
					
					<tr>
						<td bgcolor="#ecf0f1" style="font-size:10px;width:140px;text-align:left;vertical-align: middle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;휴대폰 번호</td>
						<td colspan="3"><input type="text" id="order_tel" placeholder="휴대폰 번호 입력" style="width:130px" value="${member_dto.member_tel}"/></td>
					</tr>
					
					<tr>
						<td bgcolor="#ecf0f1" style="font-size:10px;width:140px;text-align:left;vertical-align: middle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;예약 시간</td>
						<td colspan="3">
							<label style="font-size:10px;"><input type="radio" name="order_style" id="direct_order" checked="checked" value="direct"/>바로 주문</label>
								<label style="font-size:10px; "><input type="radio" name="order_style" id="reservation_order" value="reservation"/>예약 주문<span style="font-size:9px;color:red">&nbsp;&nbsp;(예약 주문은 당일만 가능합니다.)</span></label>
								<select id="select_hour" name="select_hour" style="width:50px;font-size:10px; display:none;" >
									<option>시</option>
									<option>9</option>
									<option value="">10</option>
									<option value="">11</option>
									<option value="">12</option>
									<option value="">13</option>
									<option value="">14</option>
									<option value="">15</option>
									<option value="">16</option>
									<option value="">17</option>
									<option value="">18</option>
									<option value="">19</option>
									<option value="">20</option>
									<option value="">21</option>
									<option value="">22</option>
								</select>
								
								<select id="select_minute" name="select_minute"style="width:50px;font-size:10px; display:none;">
									<option>분</option>
									<option value="">00</option>
									<option value="">05</option>
									<option value="">10</option>
									<option value="">15</option>
									<option value="">20</option>
									<option value="">25</option>
									<option value="">30</option>
									<option value="">35</option>
									<option value="">40</option>
									<option value="">45</option>
									<option value="">50</option>
									<option value="">55</option>
								</select>
						</td>
					</tr>
				</table>
				<div style="border-top:1px solid #dedede;margin-top:-21px"></div>
				<br/>
				<!-- 옵션 추가 내역 테이블 -->
				<h2 style="font-size:15px;font-weight:bold;margin-top:-2px">최종 주문 내역</h2>
				<table id="selected_option_table" class="table">
					<tr id="selected_option_header_tr">
						<th>메뉴 이름</th>
						<th>주문 수량</th>
						<th>해당 가격</th>
						<th>비고</th>
					</tr>
					<c:set var="total_price" value="0"></c:set>
					<c:set var="total_count" value="0"></c:set>
					<c:forEach var="cart_menu" items="${cartList}">
						<tr class="cart_list_tr">
							<td class="cart_menu_name">${cart_menu.menu_name }</td>
							<td class="cart_menu_count">${cart_menu.menu_count }</td>
							<td class="cart_menu_total_price">${cart_menu.menu_count*cart_menu.menu_price}</td>
							<td><input class="cart_menu_option" type="text" placeholder="[해당 옵션]&nbsp;&nbsp;예)1shot추가"/></td>
							<input type="hidden" class="cart_menu_no" value="${cart_menu.menu_num}"/>
							<input type="hidden" name="menu_counts" value="${cart_menu.menu_count}"/>
							<c:set var="total_price" value="${total_price+cart_menu.menu_count*cart_menu.menu_price}"/>
							<c:set var="total_count" value="${total_count+cart_menu.menu_count}"/>
						<tr/>
					</c:forEach>
					<tr>
						<td>총 계</td>
						<td>${total_count}</td>
						<td id="menu_total_price">${total_price}</td>
						<td id="menu_total_mileage">적립 포인트: <span><fmt:formatNumber value="${total_price/20 }" pattern="#"/></span>p</td>
					</tr>
				</table>
				<input type="hidden" name="total_price" value="${total_price}"/>
				<br/>
				<div style="border-top:1px solid #dedede;"></div>
				<br/>
				<h2 style="font-size:15px;font-weight:bold;margin-top:-2px">결제수단 선택</h2>
				<table class="table">
					<tr>
						<td bgcolor="#ecf0f1" style="font-size:10px;width:140px;text-align:left;vertical-align: middle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;결제수단</td>
						<td colspan="3">
						<label style="font-size:10px;"><input type="radio" name="payment_style" value="card" checked="checked"/>카드 결제</label>
						<label style="font-size:10px"><input type="radio" name="payment_style" value="phone"/>휴대폰 결제</label>
						<label style="font-size:10px"><input type="radio" name="payment_style" value="point"/>적립액 사용</label></td>
					
					</tr>
				</table>
				<div style="border-top:1px solid #dedede;margin-top:-20px"></div>
				<br/>
				<div>
				<button class="btn">뒤로</button>
				<button type="button" id="payment_cart" class="btn btn-danger" style="margin-left:1000px;">결제하기</button>
				</div>
			</form>
		</div>
	</div>
</div>


<!-- Footer -->
<jsp:include page="/WEB-INF/views/layout/Footer.jsp" />