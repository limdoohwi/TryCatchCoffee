<!-- 
/*
 *  Description :  회원 구매 내역 상품 리스트 모달
 *  Created : 2016-07-08
 *  Author : 김준혁
 *  
 *  Revisions :
 */
 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<script>
	$(function(){
		$("#Show-Detail-Purchase-List").draggable();
	})
</script>
<style>
#Show-Detail-Purchase-List {
	padding: 20px;
	border: 4px solid #ddd;
	position: absolute;
    left: 500px;
    top: 150px;
	background: #fff;
}

#Show-Detail-Purchase-List button {
	cursor: pointer;
}
</style>

<div id="Show-Detail-Purchase-List">
	<div>
		<table class="table table-striped table-bordered table-list">
			<!-- Member-Purchase-Table-Header -->
			<thead>
				<tr>
					<th>구매 날짜</th>
					<th>구매 상품</th>
					<th>수량</th>
					<th>금액</th>	
				</tr>
			</thead>
			<!-- Member-Purchase-Table-Body -->
			<tbody>
				<tr>
					<td>2016년 6월 30일 14시 30분</td>
					<td>아메리카노</td>
					<td>1개</td>
					<td>1,500원</td>
				</tr>
				<tr>
					<td>2016년 6월 30일 14시 30분</td>
					<td>핫초코</td>
					<td>1개</td>
					<td>2,500원</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="col-sm-offset-5">
		<button id="Show-Detail-Purchase-List-Modal-Hide-Btn" type="button"
			class="btn btn-default">닫기</button>
	</div>
</div>

