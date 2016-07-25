<!-- 
/*
 *  Description :  메뉴 관리 페이지
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
<script>
	var count = 0;
	$(function() {
		//전체 선택 MouseEnter
		$("#Menu-Table-Check-All-th")
				.mouseenter(
						function() {
							$(this)
									.html(
											"<a id='Menu-Table-Check-All-Btn' class='btn btn-success'><em class='fa fa-check-circle'></em></a>");
							//All-Check Click Make Icon
							$("#Menu-Table-Check-All-Btn")
									.click(
											function() {
												if (count == 0) {
													$(
															"#Menu-Table .Menu-Select-Single-Check-Div")
															.hide();
													$(
															"#Menu-Table .Menu-Show-Check-Icon-Div")
															.show();
													count++;
												} else {
													$(
															"#Menu-Table .Menu-Select-Single-Check-Div")
															.show();
													$(
															"#Menu-Table .Menu-Show-Check-Icon-Div")
															.hide();
													count = 0;
												}
											});
						});
		//전체 선택 MouseLeave
		$("#Menu-Table-Check-All-th").mouseleave(function() {
			$(this).html("전체 선택");
		});
		//Menu-Table-Show-Icon-Btn Click Make Icon
		$("#Menu-Table .Menu-Table-Show-Icon-Btn").click(function() {
			var div = $(this).parent();
			div.hide();
			$(div).siblings(".Menu-Show-Check-Icon-Div").show();
		});
		//Check-Btn Click Remove Icon
		$("#Menu-Table .Menu-Table-Check-Btn").click(function() {
			var div = $(this).parent();
			div.hide();
			$(div).siblings(".Menu-Select-Single-Check-Div").show();
		});
		//Menu-Table-Delete-Btn Click Delete Member
		$("#Menu-Table-Delete-Btn").click(
				function() {
					var delete_menu_numList = new Array();
					var currentRow = new Array();
					$("#Menu-Table .Menu-Show-Check-Icon-Div").each(
							function(i) {
								//Find Check-Icon
								if ($(this).css("display") == "block") {
									var menu_num = $(this).parent().siblings(
											".Menu-Table-Num-td").text();
									delete_menu_numList.push(menu_num);
									currentRow.push(i);

								}
					});
					var length = delete_menu_numList.length;
					if (length != 0) {
						if (confirm("체크 된 항목들을 정말 삭제하시겠습니까?")) {
							for(var i=0; i<length; i++){
								$.ajax({
									url:"/delete.menu",
									type:"post",
									data:{menu_num:delete_menu_numList.pop()},
									success:function(data){
										if(data == true){
											$("#Menu-Table tr").eq(Number(currentRow.pop()) + Number(1)).remove();
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
		//New-Menu-Insert-Btn 클릭시 메뉴 추가 패널 생성
		$("#New-Menu-Insert-Btn").click(
				function() {
					$("#Menu-Update-Div").hide();
					$("#Menu-Insert-Div").slideDown(400);
				});
		//Menu-Table-Update-Btn Click Call POPup Window
		$(".Menu-Table-Update-Btn").click(function(){
			var eq = '${param.nowPage_MenuManage}'*5+$(".Menu-Table-Update-Btn").index(this);
			var MenuImageList = new Array();
			var MenuNameList = new Array();
			var MenuNumList = new Array();
			var MenuPriceList = new Array();
			var MenuCategoryList = new Array();
			<c:forEach items='${menuList}' var="menu">
				MenuImageList.push("${menu.menu_image}");
				MenuNameList.push("${menu.menu_name}");
				MenuNumList.push("${menu.menu_num}");
				MenuPriceList.push("${menu.menu_price}");
				MenuCategoryList.push("${menu.menu_category_name}");
			</c:forEach>
			$("#Update-Menu-Image").attr("src","/resources/imgUpload/"+MenuImageList[eq]);
			$("#Update-Menu-Num").val(MenuNumList[eq]);
			$("#Update-Menu-Name").val(MenuNameList[eq]);
			$("#Update-Menu-Price").val(MenuPriceList[eq]);
			$("#Update-Menu-Category").val(MenuCategoryList[eq]).prop("selected", true);
			
			$("#Menu-Insert-Div").hide();
			$("#Menu-Update-Div").slideDown(400);
					
		});
		//New-Menu-Imange-Select-Icon Click Show File Search Modal
		$("#New-Menu-Image-Select-Icon").click(function(){
			$("#New-Menu-Image-Select-Btn").trigger('click');
		});
		//선택된 파일 이미지로 변경
		$("#New-Menu-Image-Select-Btn").change(
			function(){
				if(this.files&&this.files[0]){
					var reader = new FileReader();
					reader.readAsDataURL(this.files[0]);
					reader.onload=function(e){
						document.getElementById("New-Menu-Image").src=e.target.result;
					}
				}
			}		
		);
		//Update-Menu-Imange-Select-Icon Click Show File Search Modal
		$("#Update-Menu-Image-Select-Icon").click(function(){
			$("#Update-Menu-Image-Select-Btn").trigger('click');
		});
		//선택된 파일 이미지로 변경
		$("#Update-Menu-Image-Select-Btn").change(
			function(){
				if(this.files&&this.files[0]){
					var reader = new FileReader();
					reader.readAsDataURL(this.files[0]);
					reader.onload=function(e){
						document.getElementById("Update-Menu-Image").src=e.target.result;
					}
				}
			}		
		);
		//New-Menu-Catogory Value == 카테고리 추가, Create Text
		
		$("#New-Menu-Category").change(function(){
			if($(this).val() == "카테고리 추가"){
				$("#Create-New-Menu-Category-Div").slideDown(400);
			}
			else{
				$("#Create-New-Menu-Category-Div").slideUp(400);
			}
		});
		if($("#New-Menu-Category").val() == "카테고리 추가"){
			$("#Create-New-Menu-Category-Div").show();
		}
		$("#Update-Menu-Category").change(function(){
			if($(this).val() == "카테고리 추가"){
				$("#Create-Update-Menu-Category-Div").slideDown(400);
			}
			else{
				$("#Create-Update-Menu-Category-Div").slideUp(400);
			}
		});
	});
</script>
<style>
#Menu-Table #Menu-Table-Check-All-th {
	width: 100px;
}
</style>
<!-- 페이징 코드-->
<c:set var="totalRecord_MenuManage" value="${fn:length(menuList)}" />
<c:set var="numPerPage_MenuManage" value="5" />
<c:set var="pagePerBlock_MenuManage" value="5" />
<fmt:formatNumber var="fmt_totalPage_MenuManage"
	value="${totalRecord_MenuManage / numPerPage_MenuManage}"
	pattern="#.#" />
<c:if test="${fmt_totalPage_MenuManage%1 > 0}">
	<fmt:parseNumber var="totalPage_MenuManage" integerOnly="true"
		value="${(totalRecord_MenuManage / numPerPage_MenuManage)+1}"
		scope="session" />
</c:if>
<c:if test="${fmt_totalPage_MenuManage%1 == 0}">
	<fmt:parseNumber var="totalPage_MenuManage" integerOnly="true"
		value="${totalRecord_MenuManage / numPerPage_MenuManage}"
		scope="session" />
</c:if>
<fmt:formatNumber var="fmt_totalBlock_MenuManage"
	value="${totalPage_MenuManage / pagePerBlock_MenuManage}"
	pattern="#.#" />
<c:if test="${fmt_totalBlock_MenuManage%1 > 0}">
	<fmt:parseNumber var="totalBlock_MenuManage" integerOnly="true"
		value="${(totalPage_MenuManage / pagePerBlock_MenuManage)+1}"
		scope="session" />
</c:if>
<c:if test="${fmt_totalBlock_MenuManage%1 == 0}">
	<fmt:parseNumber var="totalBlock_MenuManage" integerOnly="true"
		value="${totalPage_MenuManage / pagePerBlock_MenuManage}"
		scope="session" />
</c:if>
<c:if test="${param.nowPage_MenuManage == null }">
	<c:set var="nowPage_MenuManage" value="0" />
</c:if>
<c:if test="${param.nowPage_MenuManage != null }">
	<c:set var="nowPage_MenuManage" value="${param.nowPage_MenuManage}" />
</c:if>
<c:if test="${param.nowBlock_MenuManage == null }">
	<c:set var="nowBlock_MenuManage" value="0" />
</c:if>
<c:if test="${param.nowBlock_MenuManage != null }">
	<c:set var="nowBlock_MenuManage"
		value="${param.nowBlock_MenuManage}" />
</c:if>
<c:set var="beginPerPage_MenuManage"
	value="${nowPage_MenuManage * numPerPage_MenuManage}" />
<div style="margin-top: 100px">
	<div>
		<div>
			<div class="panel panel-default panel-table col-md-6" style="display:inline-block;">
				<div class="panel-heading">
					<div class="row">
						<div class="col col-xs-6">
							<h3 class="panel-title">메뉴 관리</h3>
						</div>
					</div>
				</div>
				<div class="panel-body">
					<!-- Menu Insert Head-->
						<p>
							<strong>새로운 메뉴를 추가하세요</strong>&nbsp;&nbsp;<a
								id="New-Menu-Insert-Btn" class="btn btn-danger btn-sm"><em
								class="fa fa-plus-circle" aria-hidden="true"></em></a>
						</p>
					
					<table id="Menu-Table"
						class="table table-striped table-bordered table-list">
						<thead>
							<tr>
								<th class="text-center" id="Menu-Table-Check-All-th">전체 선택</th>
								<th width="90px">메뉴 번호</th>
								<th>메뉴명</th>
								<th>가격</th>
								<th>카테고리</th>
								<th class="text-center"> <a id="Menu-Table-Delete-Btn" class="btn btn-danger"><em class="fa fa-trash"></em></a></th>
							</tr>
						</thead>
						<tbody class="table-hover">
							<c:if test="${menuList == null }">
								<tr>
									<td>데이터가 없습니다.</td>
								</tr>
							</c:if>
							<c:if test="${menuList != null }">
								<c:forEach var="menuDto" begin="${beginPerPage_MenuManage}"
									end="${(beginPerPage_MenuManage + numPerPage_MenuManage) -1}"
									items="${menuList}">
									<tr>
										<td id="Menu-Table-Check-td"  class="text-center">
											<!-- 선택 div -->
											<div class="Menu-Select-Single-Check-Div">
												<a class="Menu-Table-Show-Icon-Btn btn btn-link" 
													style="text-decoration: none">선택</a>
											</div> <!-- Check-Icon div -->
											<div class="Menu-Show-Check-Icon-Div" style="display: none">
												<a class='Menu-Table-Check-Btn btn btn-success' style="cursor:pointer"><em
													class='fa fa-check-circle fa-2x'></em></a>
											</div>
										</td>
										<td style="text-align: left;" class="Menu-Table-Num-td">${menuDto.menu_num}</td>
										<td style="text-align: left;">${menuDto.menu_name}</td>
										<td style="text-align: left;">${menuDto.menu_price}</td>
										<td style="text-align: left;">${menuDto.menu_category_name}</td>
										<td align="center"><a class="Menu-Table-Update-Btn btn btn-default" data-toggle="tooltip" title="수정"><em class="fa fa-pencil"></em></a></td>
									</tr>
								</c:forEach>
							</c:if>
						</tbody>
					</table>
					<!-- Pagination -->
					<div class="col-sm-offset-4">
						<nav>
							<ul class="pagination">
								<li id="Previous-Page-Menu-Manage"><a href="#" aria-label="Previous"> <span
										aria-hidden="true">&laquo;</span>
								</a></li>
								<c:set var="BlockisCreate_MenuManage" value="true"/>
			    				<c:forEach var="index_MenuManage" begin="0" end="${pagePerBlock_MenuManage-1}" varStatus="BlockNum_MenuManage">
			  						<c:if test="${BlockisCreate_MenuManage}">
			  								<c:if test="${(nowBlock_MenuManage * pagePerBlock_MenuManage) + index_MenuManage >= totalPage_MenuManage-1}">
			  									<c:set var="BlockisCreate_MenuManage" value="false"/>
			  								</c:if>
			  								<li><a href="menu.manager?nowPage_MenuManage=${(nowBlock_MenuManage * pagePerBlock_MenuManage) + index_MenuManage}&nowBlock_MenuManage=${nowBlock_MenuManage}">${(nowBlock_MenuManage * pagePerBlock_MenuManage) + index_MenuManage + 1}</a></li>	
			  						</c:if>
			   					</c:forEach>
								<li id="Next-Page-Menu-Manage"><a href="#" aria-label="Next"> <span
										aria-hidden="true">&raquo;</span>
								</a></li>
							</ul>
						</nav>
					</div>
				</div>
			</div>
			<div class="panel panel-default panel-table col-md-5" style="display:inline-block; margin-right: 20px">
				<div class="panel-heading">
					<div class="row">
						<div class="col col-xs-6">
							<h3 class="panel-title">상품 정보</h3>
						</div>
					</div>
				</div>
				<div class="panel-body">
					<!-- TODO MENU INSERT -->
					<div id="Menu-Insert-Div" style="display: none;">
						<form class="form-horizontal" action="/insert.menu.manager" method="post" id="Menu-Insert-Form" enctype="multipart/form-data" >
							<div class="col-md-5" style="display:inline-block;">
								<img id="New-Menu-Image" width="100%" alt="" src="data:image/jpeg;base64,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">
								<div>
									<div class="input group row" style="margin-left: 0px !important">
										<hr />
										<span id="Result-Search-Owner">이미지 업로드</span> 
										<!-- Change-Image-Icon -->
										<a
											id="New-Menu-Image-Select-Icon"
											class="btn btn-success btn-sm"><em
											class="fa fa-plus-circle" aria-hidden="true"></em></a><br />
											<!-- Hidden Image File Upload Btn -->
											<div style="display:none;">
												<input type="file" id="New-Menu-Image-Select-Btn" name="menu_image"/>
											</div>
									</div>
								</div>
							</div>
							<div style="display:inline-block;">
								<!-- New Menu Name -->
								<div class="form-group">
									<label for="New-Menu-Name" class="col-sm-2 control-label">Name</label>
									<div class="col-sm-6">
										<input type="text" class="form-control" id="New-Menu-Name" name="menu_name" required="required"
											placeholder="메뉴 이름">
									</div>
								</div>
								<!-- New Menu Price -->
								<div class="form-group">
									<label for="New-Menu-Price" class="col-sm-2 control-label">Price</label>
									<div class="col-sm-6">
										<input type="text" class="form-control" name="menu_price" required="required"
											id="New-Menu-Price" placeholder="가격">
									</div>
								</div>
								<!-- New Menu Category -->
								<div class="form-group">
									<label for="New-Menu-Category" class="col-sm-2 control-label">Category</label>
									<div class="col-sm-6">
										<select id="New-Menu-Category" name="menu_category_name" style="width:210px; height:45px">
											<c:forEach items="${menucategoryList}" var="menucategory">
												<option value="${menucategory}">${menucategory}</option>
											</c:forEach>
											<option value="카테고리 추가">카테고리 추가</option>
										</select>
									</div>
								</div>
								<!-- Create New Category -->
								<div id="Create-New-Menu-Category-Div" class="form-group" style="display: none">
									<label for="Create-New-Menu-Category" class="col-sm-2 control-label">Add</label>
									<div class="col-sm-6">
										<input type="text" class="form-control" name="new_menu_category_name"
											id="Create-New-Menu-Category" placeholder="카테고리 추가">
									</div>
								</div>
								<!-- Submit Btn -->
								<div class="form-group">
									<div class="col-sm-offset-2 col-sm-10">
										<button id="Menu-Insert-Btn" type="submit"
											class="btn btn-default">메뉴 생성</button>
											&nbsp;&nbsp;
									</div>
								</div>
							</div>
						</form>
					</div>
					<!-- Menu Update -->
					<div id="Menu-Update-Div" style="display:none">
						<form class="form-horizontal" action="update.menu" method="post" enctype="multipart/form-data">
							<div class="col-md-5" style="display:inline-block;">
								<img width="100%" alt="" id="Update-Menu-Image" src="/resources/imgUpload/doohwi.jpg" >	
									<div class="input group row" style="margin-left: 0px !important">
										<hr />
										<span id="Result-Search-Owner">이미지 업로드</span> 
										<!-- Change-Image-Icon -->
										<a
											id="Update-Menu-Image-Select-Icon"
											class="btn btn-success btn-sm"><em
											class="fa fa-plus-circle" aria-hidden="true"></em></a><br />
											<!-- Hidden Image File Upload Btn -->
										<div style="display:none;">
											<input type="file" id="Update-Menu-Image-Select-Btn" name="menu_image"/>
										</div>
								</div>
							</div>
							<div style="display:inline-block;">
									<!-- Menu Num -->
									<div class="form-group">
										<label for="Menu-Num" class="col-sm-2 control-label">Num</label>
										<div class="col-sm-6">
											<input type="text" class="form-control" id="Update-Menu-Num" name="menu_num"
												placeholder="메뉴 번호" readonly="readonly">
										</div>
									</div>
									<!-- Menu Name -->
									<div class="form-group">
										<label for="Menu-Name" class="col-sm-2 control-label">Name</label>
										<div class="col-sm-6">
											<input type="text" class="form-control" id="Update-Menu-Name" name="menu_name"
												placeholder="메뉴 이름">
										</div>
									</div>
									<!-- Menu Price -->
									<div class="form-group">
										<label for="Menu-Price" class="col-sm-2 control-label">Price</label>
										<div class="col-sm-6">
											<input type="text" class="form-control" name="menu_price"
												id="Update-Menu-Price" placeholder="가격">
										</div>
									</div>
									<!-- Menu Category -->
									<div class="form-group">
										<label for="Menu-Catogory" class="col-sm-2 control-label">Category</label>
										<div class="col-sm-6">
											<select id="Update-Menu-Category" name="menu_category_name" style="width:210px; height:45px">
												<c:forEach items="${menucategoryList}" var="menucategory">
													<option>${menucategory}</option>
												</c:forEach>
												<option>카테고리 추가</option>
											</select>
										</div>
									</div>
									<!-- Create New Category -->
									<div id="Create-Update-Menu-Category-Div" class="form-group" style="display: none">
										<label for="Create-Update-Menu-Category" class="col-sm-2 control-label">Add</label>
										<div class="col-sm-6">
											<input type="text" class="form-control" name="new_menu_category_name"
												id="Create-Update-Menu-Category" placeholder="카테고리 추가">
										</div>
									</div>
									<!-- Submit Btn -->
									<div class="form-group">
										<div class="col-sm-offset-2 col-sm-10">
											<button id="User-Log-In-Btn" type="submit" 
												class="btn btn-default">메뉴 수정</button>
											&nbsp;&nbsp;
										</div>
									</div>
							</div>
						</form>
					</div>
				</div>
			</div>
			
		</div>
	</div>
</div>
