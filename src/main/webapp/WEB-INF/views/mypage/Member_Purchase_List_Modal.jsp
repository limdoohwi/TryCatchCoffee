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
		<table id="My-Page-Detail-Menu-List-Table" class="table table-bordered table-list">
			<!-- Member-Purchase-Table-Header -->
			<thead>
				<tr>
					<th>구매 상품</th>
					<th>수량</th>
					<th>단가</th>
					<th>총금액</th>	
				</tr>
			</thead>
			<!-- Member-Purchase-Table-Body -->
			<tbody>
			</tbody>
		</table>
	</div>
	<div class="col-sm-offset-5">
		<button id="Show-Detail-Purchase-List-Modal-Hide-Btn" type="button"
			class="btn btn-default">닫기</button>
	</div>
</div>

