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

<script>
function cart_list(data){	
	var html = "";
	var totalprice = 0;
	var totalcount = 0;
	$.each(data.cartList, function(index,jsonData){
		html +='<div style="border-top:1px solid white; background-color:#828282;">';
		html += '<div class="row">';
		html += '<div class="col-sm-8 col-sm-offset-1" align="left" style="color:white;font-size:15pt; margin-top:2px;" >'
		html += jsonData.menu_name + '</div>';
		html += '<div class="col-sm-1"><i class="remove_btn btn fa fa-times fa-1x" aria-hidden="true"></i></div>';
		html += '</div>';
		html += '<div class="row" >'
		html +=	'<div class="col-sm-7 col-sm-offset-5">';
		html += '<i class="minus_btn btn fa fa-minus-square fa-2x" aria-hidden="true"></i>';
		html += '<input class="menu_num_hidden" type="hidden" name="menu_name" value='+jsonData.menu_num + ' />'
		html += '<input class="count_text" type="text" name="menu_count" value="'+jsonData.menu_count+'" style="width:30px;"/>';
		html += '<i class="plus_btn btn fa fa-plus-square fa-2x" aria-hidden="true"></i>';
		html +=	'</div>';
		html += '</div>';
	    html += '</div>';
	    totalprice += jsonData.menu_price*jsonData.menu_count;
	    totalcount += jsonData.menu_count;
	});
		$("#cart_list").html(html);
	$("#total_price").html(totalprice+"원  &nbsp;&nbsp;");
	$("#total_mileage").html(totalprice/20 +"p &nbsp;&nbsp;")
	$("#total_menu_count").html(totalcount+"개 &nbsp;&nbsp;");
}
$(document).on('click',".minus_btn", function(){
	var eq = $(".minus_btn").index(this);
	if($(".count_text").eq(eq).val()==1){
		alert("더이상 줄일 수 없습니다.");
		return false;
	}
	$.ajax({
			url:"/update.cart",
			type:"post",
			data: {
				param: "minus",
				menu_num:$(".menu_num_hidden").eq(eq).val(),	
			},
			success:function(data){
				cart_list(data);
			},
			error:function(){
				alert("알수 없는 오류로인해 작업을 중지합니다. 다시 시도해 주세요");
				return false;
			}
	});		
});

$(document).on('click',".plus_btn", function(){
	var eq = $(".plus_btn").index(this);
	$.ajax({
		url:"/update.cart",
		type:"post",
		data: {
			param: "plus",
			menu_num:$(".menu_num_hidden").eq(eq).val(),	
		},
		success:function(data){
			cart_list(data);
		},
		error:function(){
			alert("알수 없는 오류로인해 작업을 중지합니다. 다시 시도해 주세요");
			return false;
		}
});	
	
});
$(document).on('blur',".count_text", function(){	
	var eq = $(".count_text").index(this);
	$.ajax({
		url:"/update.cart",
		type:"post",
		data: {
			param: "count",
			menu_num:$(".menu_num_hidden").eq(eq).val(),
			menu_count:$(".count_text").eq(eq).val()
		},
		success:function(data){
			cart_list(data);
		},
		error:function(){
			alert("알수 없는 오류로인해 작업을 중지합니다. 다시 시도해 주세요");
			return false;
		}
	});	
});
$(document).on('click',".remove_btn", function(){
	var eq = $(".remove_btn").index(this);
	$.ajax({
		url:"/delete.cart",
		type:"post",
		data: {
			menu_num:$(".menu_num_hidden").eq(eq).val(),
		},
		success:function(data){
			cart_list(data);
		},
		error:function(){
			alert("알수 없는 오류로인해 작업을 중지합니다. 다시 시도해 주세요");
			return false;
		}
	});	
	
});
</script>
<style>

	#cart{
		position: absolute;
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
	<a class="btn btn-danger btn-large btn-block" href="/order.cart" id="order_btn" style="font-weight:bold; font-size:20px" >주문 하기</a>
</div>