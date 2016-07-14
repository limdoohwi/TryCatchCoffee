<!-- 
/*
 *  Description :  음료 주문 페이지
 *  Created : 2016-06-27
 *  Author : 김준혁
 *  
 *  Revisions :
 */
 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<style>
	#cart{
		position: fixed;
		right: 80px;
		top: 200px;
	}
</style>

<!-- 장바구니 -->
<div id="Cart" class="col-sm-2" style="background-color: #3A3A3A;">
	<h2 class="text-center"style="font-size:20px;color:#ffffff;">장바구니</h2>
	<div style="border-top:1px solid gray;background-color:#6F6F6F;">
		<div class="row">
			<div class="span2" align="center" style="font-size:12px;color:#B7B7B7">기본소요시간 </div> 
			<div class="span1" align="center" style="font-size:17px;color:yellow;">10분</div>
		</div>
	</div>
	<!-- 모든 장바구니의 형태 아래쪽 수량을 고치는 것은 collapse를 사용할 예정 -->
	<div id="cart_list"></div>
	
	<div style="border-top:1px dashed white; height:40px;background-color:#828282; ">
		<div style="line-height:40px; margin-left:-3px">
			<span  style="font-size:13px;color:#EDEDED;font-weight:bold;float: left;" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;결제 예상 금액 </span>
			<p align="right" id="total_price" style="font-size:15px;color:#FFE400;font-weight:bold;">0원 &nbsp;&nbsp;</p>
		</div>
	</div>
	<div style="border-top:1px dashed white; height:40px;background-color:#828282; ">
		<div style="line-height:40px; ">
			<span  style="font-size:10px;color:#B7B7B7;font-weight:bold;float: left;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;총 개수 </span>
			<p align="right" id="total_menu_count" style="font-size:15px;color:#FFE400;font-weight:bold;">0개&nbsp;&nbsp;</p>
		</div>
	</div>
	<div style="border-top:1px dashed white; height:40px;background-color:#828282; ">
		<div style="line-height:40px; ">
			<span  style="font-size:10px;color:#B7B7B7;font-weight:bold;float: left;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;적립 예상 포인트 </span>
			<p align="right" id="total_mileage" style="font-size:15px;color:#FFE400;font-weight:bold;">0P&nbsp;&nbsp;</p>
		</div>
	</div>
	<form id="menu_order_form" action="front" method="post">
		<input type="hidden" name="cmd" value="menu_order"/>
		<button class="btn btn-danger btn-large btn-block" id="order_btn" style=" font-weight:bold; font-size:20px" >주문 하기</button>
	</form>
</div>