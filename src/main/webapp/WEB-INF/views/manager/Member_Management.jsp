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
<script>
	var count = 0;
	$(function() {
		// 페이징
		var nowBlock = "${nowBlock_MemberManage}";
		var totalBlock = "${totalBlock_MemberManage}";
		if(nowBlock <= 0){
			$("#Previous-Page-Member-Manage").addClass("disabled");
		}
		if(Number(nowBlock) + 1 >= totalBlock){
			$("#Next-Page-Member-Manage").addClass("disabled");
		}
		
		//전체 선택 MouseEnter
		$("#Member-Table-Check-All-th").mouseenter(function() {
			$(this).html("<a id='Member-Table-Check-All-Btn' class='btn btn-success'><em class='fa fa-check-circle'></em></a>");
			//All-Check Click Make Icon
			$("#Member-Table-Check-All-Btn").click(function() {
				if (count == 0) {
					$("#Member-Table #Select-Single-Check-Div").hide();
					$("#Member-Table #Show-Check-Icon-Div").show();
					count++;
				} 
				else {
					$("#Member-Table #Select-Single-Check-Div").show();
					$("#Member-Table #Show-Check-Icon-Div").hide();
					count = 0;
				}
			});
		});
		//전체 선택 MouseLeave
		$("#Member-Table-Check-All-th").mouseleave(function() {
			$(this).html("전체 선택");
		});
		//Member-Table-Show-Icon-Btn Click Make Icon
		$("#Member-Table #Member-Table-Show-Icon-Btn").click(function() {
			var div = $(this).parent();
			div.hide();
			$(div).siblings("#Show-Check-Icon-Div").show();
		});
		//Check-Btn Click Remove Icon
		$("#Member-Table #Member-Table-Check-Btn").click(function() {
			var div = $(this).parent();
			div.hide();
			$(div).siblings("#Select-Single-Check-Div").show();
		});
		//Member-Table-Delete-Btn Click Delete Member
		$("#Member-Table-Delete-Btn").click(
				function() {
					var delete_count = 0;
					$("#Member-Table #Show-Check-Icon-Div").each(
							function() {
								//Find Check-Icon
								if ($(this).css("display") == "block") {
									var member_num = $(this).parent().siblings(
											"#Member-Table-Num-td").text();
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
		//회원 찾기 버튼 클릭
		$("#Member-Search-Btn").click(function(){
			$("#Member-Search-Form").submit();
		});
		
	});
</script>
<style>
#Member-Search-Btn {
	cursor: pointer;
}
</style>
<!-- 페이징 코드-->
<c:set var="totalRecord_MemberManage" value="${fn:length(memberList)}" />
<c:set var="numPerPage_MemberManage" value="5" />
<c:set var="pagePerBlock_MemberManage" value="5" />
<fmt:formatNumber var="fmt_totalPage_MemberManage"
	value="${totalRecord_MemberManage / numPerPage_MemberManage}"
	pattern="#.#" />
<c:if test="${fmt_totalPage_MemberManage%1 > 0}">
	<fmt:parseNumber var="totalPage_MemberManage" integerOnly="true"
		value="${(totalRecord_MemberManage / numPerPage_MemberManage)+1}"
		scope="session" />
</c:if>
<c:if test="${fmt_totalPage_MemberManage%1 == 0}">
	<fmt:parseNumber var="totalPage_MemberManage" integerOnly="true"
		value="${totalRecord_MemberManage / numPerPage_MemberManage}"
		scope="session" />
</c:if>
<fmt:formatNumber var="fmt_totalBlock_MemberManage"
	value="${totalPage_MemberManage / pagePerBlock_MemberManage}"
	pattern="#.#" />
<c:if test="${fmt_totalBlock_MemberManage%1 > 0}">
	<fmt:parseNumber var="totalBlock_MemberManage" integerOnly="true"
		value="${(totalPage_MemberManage / pagePerBlock_MemberManage)+1}"
		scope="session" />
</c:if>
<c:if test="${fmt_totalBlock_MemberManage%1 == 0}">
	<fmt:parseNumber var="totalBlock_MemberManage" integerOnly="true"
		value="${totalPage_MemberManage / pagePerBlock_MemberManage}"
		scope="session" />
</c:if>
<c:if test="${param.nowPage_MemberManage == null }">
	<c:set var="nowPage_MemberManage" value="0" />
</c:if>
<c:if test="${param.nowPage_MemberManage != null }">
	<c:set var="nowPage_MemberManage" value="${param.nowPage_MemberManage}" />
</c:if>
<c:if test="${param.nowBlock_MemberManage == null }">
	<c:set var="nowBlock_MemberManage" value="0" />
</c:if>
<c:if test="${param.nowBlock_MemberManage != null }">
	<c:set var="nowBlock_MemberManage"
		value="${param.nowBlock_MemberManage}" />
</c:if>
<c:set var="beginPerPage_MemberManage"
	value="${nowPage_MemberManage * numPerPage_MemberManage}" />

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
								<input type="text" class="form-control" id="Search-Member-Value" name="member_email"
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
					<table id="Member-Table"
						class="table table-striped table-bordered table-list">
						<!-- Member-Table-Header -->
						<thead>
							<tr>
								<th class="text-center" id="Member-Table-Check-All-th"
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
							<c:if test="${memberList == null }">
								<tr>
									<td>데이터가 없습니다.</td>
								</tr>
							</c:if>
							<c:if test="${memberList != null }">
								<c:forEach var="memberDto" begin="${beginPerPage_MemberManage}"
									end="${(beginPerPage_MemberManage + numPerPage_MemberManage) -1}"
									items="${memberList}">
									<tr>
										<!-- Check-Icon-td -->
										<td id="Member-Table-Check-td" class="text-center">
											<!-- 선택 div -->
											<div id="Select-Single-Check-Div">
												<a id="Member-Table-Show-Icon-Btn" href="#"
													style="text-decoration: none">선택</a>
											</div> <!-- Check-Icon div -->
											<div id="Show-Check-Icon-Div" style="display: none">
												<a id='Member-Table-Check-Btn' class='btn btn-success'><em
													class='fa fa-check-circle'></em></a>
											</div>
										</td>
										<td id="Member-Table-Num-td">${memberDto.member_no}</td>
										<td>${memberDto.member_name}</td>
										<td>${memberDto.member_birth}</td>
										<td>${memberDto.member_email}</td>
										<td>${memberDto.member_tel}</td>
										<td><c:if test="${memberDto.member_code == 1}">
												회원
											</c:if> <c:if test="${memberDto.member_code == 2}">
												점장
											</c:if></td>
										<td class="text-center"><a href="#">상세보기</a></td>
									</tr>
								</c:forEach>
							</c:if>
						</tbody>
					</table>
					<!-- Pagination -->
					<div class="col-sm-offset-5">
						<nav>
							<ul class="pagination">
								<li id="Previous-Page-Member-Manage"><a href="#" aria-label="Previous"> <span
										aria-hidden="true">&laquo;</span>
								</a></li>
								<c:set var="BlockisCreate_MemberManage" value="true"/>
			    				<c:forEach var="index_MemberManage" begin="0" end="${pagePerBlock_MemberManage-1}" varStatus="BlockNum_MemberManage">
			  						<c:if test="${BlockisCreate_MemberManage}">
			  								<c:if test="${(nowBlock_MemberManage * pagePerBlock_MemberManage) + index_MemberManage >= totalPage_MemberManage-1}">
			  									<c:set var="BlockisCreate_MemberManage" value="false"/>
			  								</c:if>
			  								<li><a href="member.manager?check=member&nowPage_MemberManage=${(nowBlock_MemberManage * pagePerBlock_MemberManage) + index_MemberManage}&nowBlock_MemberManage=${nowBlock_MemberManage}">${(nowBlock_MemberManage * pagePerBlock_MemberManage) + index_MemberManage + 1}</a></li>	
			  						</c:if>
			   					</c:forEach>
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
						<input type="text" class="form-control" id="exampleInputAmount"
							placeholder="YYYY/MM/DD">
						<!-- 검색 버튼 -->
						<div id="Member-Search-Btn" class="input-group-addon"
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
						<th>구매 날짜</th>
						<th>구매 상품</th>
						<th>매장명</th>
						<th>결제 방법</th>
						<th>결제 금액</th>
					</tr>
				</thead>
				<!-- Member-Table-Body -->
				<tbody>
					<tr>
						<td>2016년 6월 30일</td>
						<td><a href="#">상세보기</a></td>
						<td>종각점</td>
						<td>신용 카드</td>
						<td>13,000원</td>
					</tr>
				</tbody>

			</table>
			<!-- Pagination -->
			<div class="col-sm-offset-4">
				<nav>
					<ul class="pagination pagination-sm">
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
						<input type="text" class="form-control" id="exampleInputAmount"
							placeholder="YYYY/MM/DD">
						<!-- 검색 버튼 -->
						<div id="Member-Search-Btn" class="input-group-addon"
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
						<th>구매 날짜</th>
						<th>예약 날짜</th>
						<th>매장명</th>
						<th>미팅룸 번호</th>
						<th>예약 시간</th>
					</tr>
				</thead>
				<!-- Member-Table-Body -->
				<tbody>
					<tr>
						<td>2016년 6월 30일</td>
						<td>2016년 7월 3일</td>
						<td>종각점</td>
						<td>3번</td>
						<td>10:00~12:00</td>
					</tr>
				</tbody>
			</table>
			<!-- Pagination -->
			<div class="col-sm-offset-4">
				<nav>
					<ul class="pagination pagination-sm">
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
						<div id="Member-Search-Btn" class="input-group-addon"
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

