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
	pageEncoding="UTF-8"%>

<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css"
	rel='stylesheet' type='text/css'>
<!-- Daum ZipSearch API -->
<script
	src="http://dmaps.daum.net/map_js_init/postcode.v2.js?autoload=false"></script>
<script>
	var count = 0;
	$(function() {
		//전체 선택 MouseEnter
		$("#Store-Table-Check-All-th")
				.mouseenter(
						function() {
							$(this)
									.html(
											"<a id='Store-Table-Check-All-Btn' class='btn btn-success'><em class='fa fa-check-circle'></em></a>");
							//All-Check Click Make Icon
							$("#Store-Table-Check-All-Btn")
									.click(
											function() {
												if (count == 0) {
													$(
															"#Store-Table #Store-Select-Single-Check-Div")
															.hide();
													$(
															"#Store-Table #Store-Show-Check-Icon-Div")
															.show();
													count++;
												} else {
													$(
															"#Store-Table #Store-Select-Single-Check-Div")
															.show();
													$(
															"#Store-Table #Store-Show-Check-Icon-Div")
															.hide();
													count = 0;
												}
											});
						});
		//전체 선택 MouseLeave
		$("#Store-Table-Check-All-th").mouseleave(function() {
			$(this).html("전체 선택");
		});
		//Store-Table-Show-Icon-Btn Click Make Icon
		$("#Store-Table #Store-Table-Show-Icon-Btn").click(function() {
			var div = $(this).parent();
			div.hide();
			$(div).siblings("#Store-Show-Check-Icon-Div").show();
		});
		//Check-Btn Click Remove Icon
		$("#Store-Table #Store-Table-Check-Btn").click(function() {
			var div = $(this).parent();
			div.hide();
			$(div).siblings("#Store-Select-Single-Check-Div").show();
		});
		//Store-Table-Delete-Btn Click Delete Member
		$("#Store-Table-Delete-Btn").click(
				function() {
					var delete_count = 0;
					$("#Store-Table #Store-Show-Check-Icon-Div").each(
							function() {
								//Find Check-Icon
								if ($(this).css("display") == "block") {
									var store_num = $(this).parent().siblings(
											"#Store-Table-Num-td").text();
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
		//Show Insert Store Div
		$("#Store-Insert-Form-Div-Show-Btn").click(function() {
			$("#Store-Insert-Form-Div").slideDown(400);
		});
		//Cancel Insert Store
		$("#Store-Insert-Cancel-Btn").click(function() {
			$("#Store-Insert-Form-Div").slideUp(400);
		});
		//Store-Insert-Owner Click Call POPup Window
		$("#Store-Insert-Owner").click(
				function() {
					var wX = 1172;
					var wY = 800;
					var url = 'front?cmd=manager&check=owner_search_create';
					var popOption = 'width=' + wX + ', height=' + wY
							+ ', resizable=no, scrollbars=no, status=no;';
					window.open(url, '', popOption);
				});
		//Store-Table-Update-Btn Click Show Store Update Div
		$("#Store-Table-Update-Btn").click(function() {
			//이미 Store Update를 진행하고 있는 상태라면 함수 진입 불가
			if($("#Store-Update-Form-Div").css("display") == "block"){
				alert("이미 수정 작업을 하고 있습니다.");
				return false;
			}
			//count == 선택된 매장수
			var count = 0;
			$("#Store-Table #Store-Show-Check-Icon-Div").each(function(){
				if($(this).css("display") == "block"){
					count++;
				}
			});
			if(count == 1){
				$("#Store-Insert-Div-Header").hide();
				$("#Store-Insert-Form-Div").hide();
				$("#Store-Update-Div-Header").slideDown(400);
				$("#Store-Update-Form-Div").slideDown(400);
			}
			else if(count > 1){
				alert("1개의 매장만 선택해야 합니다.");
				return false;
			}
			else if(count == 0){
				alert("선택 된 매장이 없습니다.");
				return false;
			}
		});
		//Cancel Update Store
		$("#Store-Update-Cancel-Btn").click(function(){
			$("#Store-Update-Div-Header").hide();
			$("#Store-Update-Form-Div").slideUp(400);
			$("#Store-Insert-Div-Header").slideDown(400);
		});
	});
	//When Click 점장 Text, Call Daum API
	function ZipCode_Search() {
		//load함수를 이용하여 core스크립트의 로딩이 완료된 후, 우편번호 서비스를 실행합니다.
		daum.postcode.load(function() {
			new daum.Postcode({
				oncomplete : function(data) {
					// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
					// 예제를 참고하여 다양한 활용법을 확인해 보세요.
					$("#Store-Address").val(data.jibunAddress);
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
						<form class="form-horizontal">
							<!-- Store-Name -->
							<div class="form-group">
								<label for="inputEmail3" class="col-sm-2 control-label">Store
									Name</label>
								<div class="col-sm-6">
									<input type="email" class="form-control" id="inputEmail3"
										placeholder="매장명">
								</div>
							</div>
							<!-- Store-Addr -->
							<div class="form-group">
								<label for="inputPassword3" class="col-sm-2 control-label">Store
									Address</label>
								<div class="col-sm-6">
									<input type="text" class="form-control" id="Store-Address"
										placeholder="주소" onclick="ZipCode_Search()">
								</div>
							</div>
							<!-- Owner-Name -->
							<div class="form-group">
								<label for="inputPassword3" class="col-sm-2 control-label">Owner</label>
								<div class="col-sm-6">
									<input type="text" class="form-control" id="Store-Insert-Owner"
										placeholder="점장">
								</div>
							</div>
							<!-- Meeting-Room -->
							<div class="form-group">
								<label for="inputPassword3" class="col-sm-2 control-label">MeetingRoom</label>
								<div class="col-sm-6">
									<input type="text" class="form-control" id="inputPassword3"
										placeholder="미팅룸 보유수">
								</div>
							</div>
							<!-- IP -->
							<div class="form-group">
								<label for="inputPassword3" class="col-sm-2 control-label">IP</label>
								<div class="col-sm-6">
									<input type="text" class="form-control" id="inputPassword3"
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
						<form class="form-horizontal">
							<!-- Store-Num -->
							<div class="form-group">
								<label for="inputEmail3" class="col-sm-2 control-label">Store
									Num</label>
								<div class="col-sm-6">
									<input type="text" class="form-control" id="inputEmail3"
										placeholder="매장 번호">
								</div>
							</div>
							<!-- Store-Name -->
							<div class="form-group">
								<label for="inputEmail3" class="col-sm-2 control-label">Store
									Name</label>
								<div class="col-sm-6">
									<input type="text" class="form-control" id="inputEmail3"
										placeholder="매장명">
								</div>
							</div>
							<!-- Store-Addr -->
							<div class="form-group">
								<label for="inputPassword3" class="col-sm-2 control-label">Store
									Address</label>
								<div class="col-sm-6">
									<input type="text" class="form-control" id="Store-Address"
										placeholder="주소" onclick="ZipCode_Search()">
								</div>
							</div>
							<!-- Owner-Name -->
							<div class="form-group">
								<label for="inputPassword3" class="col-sm-2 control-label">Owner</label>
								<div class="col-sm-6">
									<input type="text" class="form-control" id="Store-Insert-Owner"
										placeholder="점장">
								</div>
							</div>
							<!-- Meeting-Room -->
							<div class="form-group">
								<label for="inputPassword3" class="col-sm-2 control-label">MeetingRoom</label>
								<div class="col-sm-6">
									<input type="text" class="form-control" id="inputPassword3"
										placeholder="미팅룸 보유수">
								</div>
							</div>
							<!-- IP -->
							<div class="form-group">
								<label for="inputPassword3" class="col-sm-2 control-label">IP</label>
								<div class="col-sm-6">
									<input type="text" class="form-control" id="inputPassword3"
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
										class="btn btn-primary">닫기</button>
								</div>
							</div>
						</form>
					</div>
				</div>
		</div>
	</div>
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
					<form class="form-inline">
						<div class="form-group">
							<div class="input-group">
								<!-- 입력  -->
								<input type="text" class="form-control" id="exampleInputAmount"
									placeholder="매장정보 입력...">
								<!-- 검색 버튼 -->
								<div id="Member-Search-Btn" class="input-group-addon"
									style="background-color: white; color: green">
									<i class="fa fa-search"></i>
								</div>
							</div>
						</div>
					</form>
					<table id="Store-Table"
						class="table table-striped table-bordered table-list">
						<thead>
							<tr>
								<th class="text-center" id="Store-Table-Check-All-th">전체 선택</th>
								<th width="90px">매장 번호</th>
								<th>매장명</th>
								<th>점장</th>
								<th>주소</th>
								<th>미팅룸</th>
								<th>IP</th>
								<th class="text-center"><a id="Store-Table-Update-Btn"
									class="btn btn-default"><em class="fa fa-pencil"></em></a> <a
									id="Store-Table-Delete-Btn" class="btn btn-danger"><em
										class="fa fa-trash"></em></a></th>
							</tr>
						</thead>
						<tbody class="table-hover">
							<tr>
								<td id="Store-Table-Check-td" " class="text-center">
									<!-- 선택 div -->
									<div id="Store-Select-Single-Check-Div">
										<a id="Store-Table-Show-Icon-Btn" href="#"
											style="text-decoration: none">선택</a>
									</div> <!-- Check-Icon div -->
									<div id="Store-Show-Check-Icon-Div" style="display: none">
										<a id='Store-Table-Check-Btn' class='btn btn-success'><em
											class='fa fa-check-circle'></em></a>
									</div>
								</td>
								<td style="text-align: left;" id="Store-Table-Num-td">1</td>
								<td style="text-align: left;">인천점</td>
								<td style="text-align: left;">테스트</td>
								<td id="test" style="text-align: left">인천광역시 계양구 효성2동 현대4차
									아파트</td>
								<td style="text-align: left">3</td>
								<td style="text-align: left;">192.168.20.46</td>
								<td align="center"></td>
							</tr>
							<tr>
								<td id="Store-Table-Check-td" " class="text-center">
									<!-- 선택 div -->
									<div id="Store-Select-Single-Check-Div">
										<a id="Store-Table-Show-Icon-Btn" href="#"
											style="text-decoration: none">선택</a>
									</div> <!-- Check-Icon div -->
									<div id="Store-Show-Check-Icon-Div" style="display: none">
										<a id='Store-Table-Check-Btn' class='btn btn-success'><em
											class='fa fa-check-circle'></em></a>
									</div>
								</td>
								<td style="text-align: left;" id="Store-Table-Num-td">2</td>
								<td style="text-align: left;">인천점</td>
								<td style="text-align: left;">테스트</td>
								<td style="text-align: left">인천광역시 계양구 효성2동 현대4차 0</td>
								<td style="text-align: left">0</td>
								<td style="text-align: left;">192.168.20.46</td>
								<td align="center"></td>
							</tr>
						</tbody>
					</table>
					<!-- Pagination -->
					<div class="col-sm-offset-4">
						<nav>
							<ul class="pagination">
								<li><a href="#" aria-label="Previous"> <span
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
	</div>
</div>
