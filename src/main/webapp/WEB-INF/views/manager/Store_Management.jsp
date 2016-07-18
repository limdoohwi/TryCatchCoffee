<!-- 
/*
 *  Description :  매장 관리 페이지
 *  Created : 2016-06-29
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
<!-- Daum ZipSearch API -->
<script
	src="http://dmaps.daum.net/map_js_init/postcode.v2.js?autoload=false"></script>
<script>
	$(function() {
		$('[data-toggle="tooltip"]').tooltip()
		//매장 검색 후 해당 단어와 일치하는 데이터를 찾아 mark 표시
		var search_store_value = "${search_store_value}";
		if(search_store_value != ""){
			$("#Store-Table tr").not("#Store-Table-Head-Row").find("td").not(".Store-Table-Num-td").each(function(){
				if($(this).text().indexOf(search_store_value) != -1){
					var store_search_value_length = search_store_value.length;
					var tdText_length = $(this).text().length;
					var matchText = "";
					var preExtraText = "";
					var sufExtraText = "";
					var startIndex = $(this).text().indexOf(search_store_value);
					if(startIndex != 0){
						preExtraText = $(this).text().substring(0, startIndex);
						matchText = $(this).text().substring(startIndex, startIndex + store_search_value_length);
						sufExtraText = $(this).text().substring(startIndex + store_search_value_length, tdText_length);
					}
					else{
						matchText = $(this).text().substring(startIndex, store_search_value_length);
						sufExtraText = $(this).text().substring(store_search_value_length, tdText_length);
					}
					$(this).html(preExtraText + "<mark>" + matchText + "</mark>" + sufExtraText);
				}
			});
		}
		//매장 생성 후 DB에 등록 성공 유무 확인
		var isSuccessInsertStore = "${isSuccessInsertStore}";
		if(isSuccessInsertStore != ""){
			if(isSuccessInsertStore == "true"){
				alert("매장 추가가 완료되었습니다.")
			}
			else{
				alert("알수없는 오류로 인해 취소되었습니다. 매장이 추가되었다면 지우고 다시 시도해주세요.");
			}
		}
		// 페이징
		var nowBlock = "${nowBlock_StoreManage}";
		var totalBlock = "${totalBlock_StoreManage}";
		if(nowBlock <= 0){
			$("#Previous-Page-Store-Manage").addClass("disabled");
		}
		if(Number(nowBlock) + 1 >= totalBlock){
			$("#Next-Page-Store-Manage").addClass("disabled");
		}
		
		//전체 선택 MouseEnter
		$("#Store-Table-Check-All-th").mouseenter(function() {
			$(this).html("<a id='Store-Table-Check-All-Btn' class='btn btn-success'><em class='fa fa-check-circle'></em></a>");
		});
		//전체 선택 버튼 클릭
		$(document).on("click", "#Store-Table-Check-All-Btn", function() {
			$("#Store-Table .Store-Select-Single-Check-Div").each(function(){
				if($(this).css("display") == "block"){
					var index = $(".Store-Select-Single-Check-Div").index(this);
					$(this).hide();
					$(".Store-Show-Check-Icon-Div").eq(index).show();
				}
				else{
					var index = $(".Store-Select-Single-Check-Div").index(this);
					$(this).show();
					$(".Store-Show-Check-Icon-Div").eq(index).hide();
				}
			});
		});
		//전체 선택 MouseLeave
		$("#Store-Table-Check-All-th").mouseleave(function() {
			$(this).html("전체 선택");
		});
		//선택 text 클릭시 체크 아이콘으로 변경
		$(".Store-Table-Show-Icon-Btn").click(function() {
			var index = $(".Store-Table-Show-Icon-Btn").index(this);
			var div = $(".Store-Select-Single-Check-Div").eq(index);
			$(div).hide();
			$(div).siblings(".Store-Show-Check-Icon-Div").show();
		});
		//체크 아이콘 클릭시 선택 text로 변경
		$(".Store-Table-Check-Btn").click(function() {
			var index = $(".Store-Table-Check-Btn").index(this);
			var div = $(".Store-Show-Check-Icon-Div").eq(index);
			$(div).hide();
			$(div).siblings(".Store-Select-Single-Check-Div").show();
		});
		//매장 삭제 버튼 클릭
		$("#Store-Table-Delete-Btn").click(function() {
			var store_no = new Array();
			var currentRow = new Array();
			var isSuccessDeleteStore = true;
			$("#Store-Table .Store-Show-Check-Icon-Div").each(function(i) {
				//체크되어 있는 아이콘을 찾음
				if ($(this).css("display") == "block") {
					currentRow.push(i);
					store_no.push($(this).parent().siblings(".Store-Table-Num-td").text());
				}
			});
				var length = store_no.length;
				if (length != 0) {
					if (confirm("체크 된 항목들을 정말 삭제하시겠습니까?")) {
						for(var i=0; i<length; i++){
							$.ajax({
								url:"/delete.store.manager",
								type:"post",
								data:{store_no:store_no.pop()},
								success:function(data){
									if(data == true){
										$("#Store-Table tr").eq(Number(currentRow.pop()) + Number(1)).remove();
										isSuccessDeleteStore = true;
									}
								},
								error:function(){
									alert("알수 없는 오류로인해 작업을 중지합니다. 다시 시도해 주세요");
									return false;
								}
							});		
						}
						alert("작업이 완료되었습니다.");
					}
				} 
				else {
						alert("선택된 항목이 없습니다.");
				}
		});
		//Show Insert Store Div
		$("#Store-Insert-Form-Div-Show-Btn").click(function() {
			$("#Store-Insert-Form-Div").slideDown(400);
		});
		//매장 추가 버튼 클릭
		$("#Store-Insert-Btn").click(function(){
			var flag = true;
			$("#Store-Insert-Form .form-control").each(function(){
				if($(this).val() == ''){
					alert("입력되지 않은 부분이 있습니다.");
					$(this).focus();
					flag = false;
					return false;
				}
			});
			if(flag == false)
				return false;
			
			if(confirm("위 내용대로 매장을 추가하시겠습니까?")){
				$("#Store-Insert-Form").submit();
			}
		});
		//매장 추가 닫기 버튼 클릭시 매장 추가 form 안에 모든 text 값 초기화
		$("#Store-Insert-Cancel-Btn").click(function() {
			$("#Store-Insert-Form .form-control").val('');
			$("#Store-Insert-Form-Div").slideUp(400);
		});
		//매장 추가 및 매장 수정 시 점장 text 클릭시 팝업창 호출
		$(".Store-Insert-Owner").click(
				function() {
					var wX = 1172;
					var wY = 800;
					var url = 'search.owner.insert.store.manager';
					var popOption = 'width=' + wX + ', height=' + wY
							+ ', resizable=no, scrollbars=no, status=no;';
					window.open(url, '', popOption);
				});
		
		//매장 수정 버튼 클릭
		$(".Store-Table-Update-Btn").click(function() {
			//이미 Store Update를 진행하고 있는 상태라면 함수 진입 불가
			if($("#Store-Update-Form-Div").css("display") == "block"){
				alert("이미 수정 작업을 하고 있습니다.");
				return false;
			}
			var index = $(".Store-Table-Update-Btn").index(this);
			var store_no = $(".Store-Table-Num-td").eq(index).text();
			$.ajax({
				url:"/load.storeInfo.update.store.manager",
				type:"post",
				data:{store_no:store_no},
				async:false,
				success:function(data){
					successLoadStoreInfo(data);
				},
				error:function(){
					alert("실패");
				}
			});
			$("#Store-Insert-Div-Header").hide();
			$("#Store-Insert-Form-Div").hide();
			$("#Store-Update-Div-Header").slideDown(400);
			$("#Store-Update-Form-Div").slideDown(400);
			
		});
		function successLoadStoreInfo(data){
			var form = $("#Store-Update-Form");
			$(form).find("input[name=store_no]").val(data.store_no);
			$(form).find("input[name=store_name]").val(data.store_name);
			$(form).find("input[name=store_addr]").val(data.store_addr);
			$(form).find("input[name=member_no]").val(data.member_no);
			$(form).find("input[name=member_name]").val(data.member_name);
			$(form).find("input[name=meeting_room]").val(data.meeting_room);
			$(form).find("input[name=store_ip]").val(data.store_ip);
		}
		//매장 수정 완료 버튼 클릭
		$("#Store-Update-Btn").click(function(){
			alert($("#Store-Update-Form input[name=store_no]").val());
			if(confirm("수정된 내용대로 정보를 저장하시겠습니까?")){
				$("#Store-Update-Form").submit();
			}	
		});
		
		//매장 수정 취소 버튼 클릭
		$("#Store-Update-Cancel-Btn").click(function(){
			if(confirm("수정 작업을 취소하시겠습니까?")){
				$("#Store-Update-Form .form-control").val('');
				$("#Store-Update-Div-Header").hide();
				$("#Store-Update-Form-Div").slideUp(400);
				$("#Store-Insert-Div-Header").slideDown(400);
			}
		});
		
		//매장 찾기 버튼 클릭
		$("#Search-Store-Btn").click(function(){
			$("#Search-Store-Form").submit();
		});
	});
	//When Click 점장 Text, Call Daum API
	function ZipCode_Search(obj) {
		//load함수를 이용하여 core스크립트의 로딩이 완료된 후, 우편번호 서비스를 실행합니다.
		daum.postcode.load(function() {
			new daum.Postcode({
				oncomplete : function(data) {
					// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
					// 예제를 참고하여 다양한 활용법을 확인해 보세요.
				    // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var fullAddr = ''; // 최종 주소 변수
	                var extraAddr = ''; // 조합형 주소 변수

	                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    fullAddr = data.roadAddress;

	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    fullAddr = data.jibunAddress;
	                }

	                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
	                if(data.userSelectedType === 'R'){
	                    //법정동명이 있을 경우 추가한다.
	                    if(data.bname !== ''){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있을 경우 추가한다.
	                    if(data.buildingName !== ''){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
	                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
	                }
					$(obj).val(fullAddr);
				}
			}).open();
		});
	}
</script>
<style>
#Store-Table #Store-Table-Check-All-th {
	width: 100px;
}
</style>
<!-- 페이징 코드-->
<c:set var="totalRecord_StoreManage" value="${fn:length(storeList)}" />
<c:set var="numPerPage_StoreManage" value="5" />
<c:set var="pagePerBlock_StoreManage" value="5" />
<fmt:formatNumber var="fmt_totalPage_StoreManage"
	value="${totalRecord_StoreManage / numPerPage_StoreManage}"
	pattern="#.#" />
<c:if test="${fmt_totalPage_StoreManage%1 > 0}">
	<fmt:parseNumber var="totalPage_StoreManage" integerOnly="true"
		value="${(totalRecord_StoreManage / numPerPage_StoreManage)+1}"
		scope="session" />
</c:if>
<c:if test="${fmt_totalPage_StoreManage%1 == 0}">
	<fmt:parseNumber var="totalPage_StoreManage" integerOnly="true"
		value="${totalRecord_StoreManage / numPerPage_StoreManage}"
		scope="session" />
</c:if>
<fmt:formatNumber var="fmt_totalBlock_StoreManage"
	value="${totalPage_StoreManage / pagePerBlock_StoreManage}"
	pattern="#.#" />
<c:if test="${fmt_totalBlock_StoreManage%1 > 0}">
	<fmt:parseNumber var="totalBlock_StoreManage" integerOnly="true"
		value="${(totalPage_StoreManage / pagePerBlock_StoreManage)+1}"
		scope="session" />
</c:if>
<c:if test="${fmt_totalBlock_StoreManage%1 == 0}">
	<fmt:parseNumber var="totalBlock_StoreManage" integerOnly="true"
		value="${totalPage_StoreManage / pagePerBlock_StoreManage}"
		scope="session" />
</c:if>
<c:if test="${param.nowPage_StoreManage == null }">
	<c:set var="nowPage_StoreManage" value="0" />
</c:if>
<c:if test="${param.nowPage_StoreManage != null }">
	<c:set var="nowPage_StoreManage" value="${param.nowPage_StoreManage}" />
</c:if>
<c:if test="${param.nowBlock_StoreManage == null }">
	<c:set var="nowBlock_StoreManage" value="0" />
</c:if>
<c:if test="${param.nowBlock_StoreManage != null }">
	<c:set var="nowBlock_StoreManage"
		value="${param.nowBlock_StoreManage}" />
</c:if>
<c:set var="beginPerPage_StoreManage"
	value="${nowPage_StoreManage * numPerPage_StoreManage}" />

<div style="margin-top: 100px">
	<div class="col-md-5" style="display:inline-block;">
		<div class="panel panel-default panel-table">
				<div class="panel-heading">
					<div class="row">
						<div>
							<h3 class="panel-title">매장 관리</h3>
						</div>
					</div>
				</div>
				<div class="panel-body">
					<div id="Store-Insert-Div-Header">
						<p>
							<strong>새로운 매장을 추가하세요</strong>&nbsp;&nbsp;<a
								id="Store-Insert-Form-Div-Show-Btn" class="btn btn-danger btn-sm"><em
								class="fa fa-plus-circle" aria-hidden="true"></em></a>
						</p>
					</div>
					<!-- Store Update Head-->
					<div id="Store-Update-Div-Header" style="display:none">
						<p>
							<strong>매장을 수정하세요</strong>
						</p>
					</div>
					<!-- Store Insert -->
					<div id="Store-Insert-Form-Div" class="row col-md-offset-2"
						style="display: none;">
						<form id="Store-Insert-Form" class="form-horizontal" method="post" action="insert.store.manager">
							<!-- Store-Name -->
							<div class="form-group">
								<label for="inputEmail3" class="col-sm-2 control-label">Store
									Name</label>
								<div class="col-sm-6">
									<input type="text" class="form-control" name="store_name"
										placeholder="매장명">
								</div>
							</div>
							<!-- Store-Addr -->
							<div class="form-group">
								<label for="store_addr" class="col-sm-2 control-label">Store
									Address</label>
								<div class="col-sm-6">
									<input type="text" class="form-control" name="store_addr"
										placeholder="주소" onclick="ZipCode_Search(this)">
								</div>
							</div>
							<!-- Owner-Name -->
							<div class="form-group">
								<label for="member_name" class="col-sm-2 control-label">Owner</label>
								<div class="col-sm-6">
									<input type="text" class="Store-Insert-Owner form-control" name="member_name"
										placeholder="점장">
									<input type="hidden" class="form-control" id="member_no" name="member_no" value="">
								</div>
							</div>
							<!-- Meeting-Room -->
							<div class="form-group">
								<label for="meetring_room" class="col-sm-2 control-label">MeetingRoom</label>
								<div class="col-sm-6">
									<input type="text" class="form-control" name="meeting_room"
										placeholder="미팅룸 보유수">
								</div>
							</div>
							<!-- IP -->
							<div class="form-group">
								<label for="store_ip" class="col-sm-2 control-label">IP</label>
								<div class="col-sm-6">
									<input type="text" class="form-control" name="store_ip"
										placeholder="매장 IP">
								</div>
							</div>
							<!-- Submit Btn -->
							<div class="form-group">
								<div class="col-sm-offset-2 col-sm-10">
									<button id="Store-Insert-Btn" type="button"
										class="btn btn-success">매장 등록</button>
									&nbsp;&nbsp;
									<button id="Store-Insert-Cancel-Btn" type="button"
										class="btn btn-primary">닫기</button>
								</div>
							</div>
						</form>
					</div>
					<!-- Store Update -->
					<div id="Store-Update-Form-Div" class="row col-md-offset-2"
						style="display: none">
						<form id="Store-Update-Form" class="form-horizontal" method="post" action="update.store.manager">
							<!-- Store-No -->
							<input type="hidden" class="form-control" id="store_no" name="store_no">
							<!-- Store-Name -->
							<div class="form-group">
								<label for="inputEmail3" class="col-sm-2 control-label">Store
									Name</label>
								<div class="col-sm-6">
									<input type="text" class="form-control" name="store_name"
										placeholder="매장명">
								</div>
							</div>
							<!-- Store-Addr -->
							<div class="form-group">
								<label for="store_addr" class="col-sm-2 control-label">Store
									Address</label>
								<div class="col-sm-6">
									<input type="text" class="form-control" name="store_addr"
										placeholder="주소" onclick="ZipCode_Search(this)">
								</div>
							</div>
							<!-- Owner-Name -->
							<div class="form-group">
								<label for="member_name" class="col-sm-2 control-label">Owner</label>
								<div class="col-sm-6">
									<input type="text" class="Store-Insert-Owner form-control" name="member_name"
										placeholder="점장">
									<input type="hidden" class="form-control" id="member_no" name="member_no" value="">
								</div>
							</div>
							<!-- Meeting-Room -->
							<div class="form-group">
								<label for="meetring_room" class="col-sm-2 control-label">MeetingRoom</label>
								<div class="col-sm-6">
									<input type="text" class="form-control" name="meeting_room"
										placeholder="미팅룸 보유수">
								</div>
							</div>
							<!-- IP -->
							<div class="form-group">
								<label for="store_ip" class="col-sm-2 control-label">IP</label>
								<div class="col-sm-6">
									<input type="text" class="form-control" name="store_ip"
										placeholder="매장 IP">
								</div>
							</div>
							<!-- Submit Btn -->
							<div class="form-group">
								<div class="col-sm-offset-2 col-sm-10">
									<button id="Store-Update-Btn" type="button"
										class="btn btn-success">수정 완료</button>
									&nbsp;&nbsp;
									<button id="Store-Update-Cancel-Btn" type="button"
										class="btn btn-primary">취소</button>
								</div>
							</div>
						</form>
					</div>
				</div>
		</div>
	</div>
	<!-- 매장 리스트 -->
	<div style="display:inline-block;">
		<div>
			<div class="panel panel-default panel-table">
				<div class="panel-heading">
					<div class="row">
						<div>
							<h3 class="panel-title">상세 관리</h3>
						</div>
					</div>
				</div>
				<div class="panel-body">
					<!-- 매장 검색 -->
					<form id="Search-Store-Form" class="form-inline" method="post" action="/search.store.manager">
						<div class="form-group">
							<div class="input-group">
								<!-- 입력  -->
								<input type="text" class="form-control" name="search_store_value"
									placeholder="매장정보 입력...">
								<!-- 검색 버튼 -->
								<div id="Search-Store-Btn" class="input-group-addon"
									style="background-color: white; color: green; cursor: pointer;">
									<i class="fa fa-search"></i>
								</div>
							</div>
						</div>
					</form>
					<table id="Store-Table"
						class="table table-striped table-bordered table-list">
						<thead>
							<tr id="Store-Table-Head-Row">
								<th class="text-center" id="Store-Table-Check-All-th">전체 선택</th>
								<th width="90px">매장 번호</th>
								<th>매장명</th>
								<th>점장</th>
								<th>주소</th>
								<th>미팅룸</th>
								<th>IP</th>
								<th class="text-center"><a
									id="Store-Table-Delete-Btn" class="btn btn-danger" data-toggle="tooltip" title="삭제"><em
										class="fa fa-trash"></em></a></th>
							</tr>
						</thead>
						<tbody class="table-hover">
							<c:if test="${storeList == null }">
								<tr>
									<td>데이터가 없습니다.</td>
								</tr>
							</c:if>
							<c:if test="${storeList != null }">
								<c:forEach var="storeDto" begin="${beginPerPage_StoreManage}"
									end="${(beginPerPage_StoreManage + numPerPage_StoreManage) -1}"
									items="${storeList}">
									<tr>
										<td id="Store-Table-Check-td" " class="text-center">
											<!-- 선택 div -->
											<div class="Store-Select-Single-Check-Div">
												<a class="Store-Table-Show-Icon-Btn" href="#"
													style="text-decoration: none">선택</a>
											</div> <!-- Check-Icon div -->
											<div class="Store-Show-Check-Icon-Div" style="display: none">
												<a class='Store-Table-Check-Btn' class='btn btn-success' style="cursor:pointer"><em
													class='fa fa-check-circle fa-2x'></em></a>
											</div>
										</td>
										<td style="text-align: left;" class="Store-Table-Num-td">${storeDto.store_no}</td>
										<td style="text-align: left;">${storeDto.store_name}</td>
										<td style="text-align: left;">${storeDto.member_name}</td>
										<td id="test" style="text-align: left">${storeDto.store_addr}</td>
										<td style="text-align: left">${storeDto.meeting_room}</td>
										<td style="text-align: left;">${storeDto.store_ip}</td>
										<td align="center"><a class="Store-Table-Update-Btn btn btn-default" data-toggle="tooltip" title="수정"><em class="fa fa-pencil"></em></a></td>
									</tr>
								</c:forEach>
							</c:if>
						</tbody>
					</table>
					<!-- Pagination -->
					<div class="col-sm-offset-4">
						<nav>
							<ul class="pagination">
								<li id="Previous-Page-Store-Manage"><a href="#" aria-label="Previous"> <span
										aria-hidden="true">&laquo;</span>
								</a></li>
								<c:set var="BlockisCreate_StoreManage" value="true"/>
			    				<c:forEach var="index_StoreManage" begin="0" end="${pagePerBlock_StoreManage-1}" varStatus="BlockNum_StoreManage">
			  						<c:if test="${BlockisCreate_StoreManage}">
			  								<c:if test="${(nowBlock_StoreManage * pagePerBlock_StoreManage) + index_StoreManage >= totalPage_StoreManage-1}">
			  									<c:set var="BlockisCreate_StoreManage" value="false"/>
			  								</c:if>
			  								<li><a href="store.manager?nowPage_StoreManage=${(nowBlock_StoreManage * pagePerBlock_StoreManage) + index_StoreManage}&nowBlock_StoreManage=${nowBlock_StoreManage}">${(nowBlock_StoreManage * pagePerBlock_StoreManage) + index_StoreManage + 1}</a></li>	
			  						</c:if>
			   					</c:forEach>
								<li id="Next-Page-Store-Manage"><a href="#" aria-label="Next"> <span
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
