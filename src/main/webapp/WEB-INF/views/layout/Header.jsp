<!-- 
 *  Revisions :
 *  1.WHEN & WHO : 2016-07-14 임두휘
 *  2.WHAT : Log_in 성공여부 Register
-->
<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>
	$(function() {
		//Main-Brand-Btn Click
		$("#Main-Brand-Btn").click(function() {
			location.href = "front?cmd=main";
		});
		//DropDown-Menu Mouseenter
		$("#Main-DropDown-Nav #Main-DropDown").mouseenter(function() {
			$(".Main-DropDown-Menu").slideDown(200);
		});
		//DropDown-Menu Mouseleave
		$(".Main-DropDown-Menu").mouseleave(function() {
			$(".Main-DropDown-Menu").slideUp(400);
		});
		//MeetingRoom-Btn Click Load Meeting_Room.jsp
		$("#MeetingRoom-Btn").click(
				function() {
					var wX = screen.availWidth;
					var wY = screen.availHeight;
					wY = (wY - 38);
					var url = '/meeting_room.order';
					var popOption = 'width=' + wX + ', height=' + wY
							+ ', resizable=no, scrollbars=no, status=no;';
					window.open(url, '', popOption);
				});
		//왼쪽 매장 찾기 매장 선택 버튼 클릭시 default 매장 바뀜
		$(".Member-Select-Store-Btn").click(function() {
			var index = $(".Member-Select-Store-Btn").index(this);
			if (confirm("선택하신 매장으로 변경할까요? 커피,음료 주문시 해당 매장으로 전달됩니다.")) {
			}
		});
		//dropdown menu에 mouseenter 되었을 때 심플 가이드 호출
		$(".Main-DropDown-Menu a")
				.mouseenter(
						function() {
							$("#Simple-Explain-Div").css("visibility",
									"inherit");
							var name = $(this).attr("name");
							var menuName = $("#Dropdown-Name");
							var menuExplain = $("#Dropdown-Simple-Explain");

							if (name == "Company") {
								$(menuName).text("회사 소개");
								$(menuExplain)
										.text(
												"TRYCOFFEE가 어떤 일을 하며 경영 철학 및 본사 위치를 확인 할 수 있습니다.")
							} else if (name == "Ceo") {
								$(menuName).text("CEO 인사말");
								$(menuExplain).text(
										"TryCoffee사 CEO의 간략한 인사말을 볼 수 있습니다.");
							} else if (name == "Drink") {
								$(menuName).text("음료 주문 예약");
								$(menuExplain).text("온라인으로 음료를 예약 주문할 수 있습니다.");
							} else if (name == "MeetingRoom") {
								$(menuName).text("미팅룸 예약");
								$(menuExplain).text(
										"매장에서 제공하는 미팅룸을 미리 예약 할 수 있습니다.");
							} else if (name == "Recipe") {
								$(menuName).text("Recipe Contest");
								$(menuExplain)
										.text("자신만의 커피 및 음료 레시피를 공유해보세요!");
							} else if (name == "Client") {
								$(menuName).text("고객의 소리");
								$(menuExplain)
										.text(
												"매장이나 본사에 대한 운영, 서비스에 대한 솔직한 평가와 바라는 점을 조회 및 작성 할 수 있습니다.")
							} else if (name == "Member-Manage") {
								$(menuName).text("회원 관리");
								$(menuExplain).text("관리자 전용페이지");
							} else if (name == "Store-Manage") {
								$(menuName).text("매장 관리");
								$(menuExplain).text("관리자 전용페이지");
							} else if (name == "Board-Manage") {
								$(menuName).text("게시판 관리");
								$(menuExplain).text("관리자 전용페이지");
							} else if (name == "Menu-Manage") {
								$(menuName).text("메뉴 관리");
								$(menuExplain).text("관리자 전용페이지");
							}
						});
		$(".Main-DropDown-Menu a").mouseleave(function() {
			$("#Simple-Explain-Div").css("visibility", "hidden");
		});
	});
</script>

<style>
.dropdown a {
	text-decoration: none;
}

.nav li>.dropdown a {
	margin-top: 20px;
	margin-right: 10px
}

.Main-DropDown-Menu a {
	color: #18bc9c;
	text-decoration: none;
}

.Main-DropDown-Menu a:hover {
	color: white;
}

.Main-DropDown-Menu {
	display: none;
}

h2 {
	color: black;
}
</style>

<!-- Search-Store Field -->
<div id="Store-Search-Main-Div" class="col-lg-2"
	style="background-color: black; opacity: 0.5; position: fixed; margin-top: 60px">
	<form class="form-horizontal">
		<div class="form-group">
			<input type="email" class="form-control" id="inputEmail3"
				placeholder="매장 검색">
		</div>
	</form>
	<!-- Result Search Store -->
	<div style="color: white">
		<table>
			<tr style="height: 70px">
				<td width="60%">서울 특별시 중구 을지로3가 101</td>
				<td width="25%">종각점</td>
				<td width="15%"><button
						class="Member-Select-Store-Btn btn btn-primary btn-sm">선택</button></td>
			</tr>
			<tr style="height: 70px">
				<td width="60%">서울 특별시 중구 을지로3가 101</td>
				<td width="25%">종각점</td>
				<td width="15%"><button
						class="Member-Select-Store-Btn btn btn-primary btn-sm">선택</button></td>
			</tr>
			<tr style="height: 70px">
				<td width="60%">서울 특별시 중구 을지로3가 101</td>
				<td width="25%">종각점</td>
				<td width="15%"><button
						class="Member-Select-Store-Btn btn btn-primary btn-sm">선택</button></td>
			</tr>
		</table>
	</div>
</div>

<div class="navbar-header">
	<button type="button" class="navbar-toggle collapsed"
		data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
		<span class="sr-only">Toggle navigation</span> <span class="icon-bar"></span>
		<span class="icon-bar"></span>

	</button>
	<button id="Main-Brand-Btn" class="navbar-brand">Brand</button>
	<span class="icon-bar"></span>
</div>


<!-- Collect the nav links, forms, and other content for toggling -->
<div class="collapse navbar-collapse" id="Main-DropDown-Nav">
	<!-- Navigation -->
	<nav class="navbar navbar-default navbar-fixed-top">
		<a id="Main-Brand-Btn" class="navbar-brand" href="/">Try Coffee Catch{}<br /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
			<c:if test="${member_dto!=null}">
				<span class="navbar-brand" style="font-size: 11pt">${member_dto.member_name}님</span>
			</c:if> 
			<c:if test="${store_dto != null}">
				<span class="navbar-brand" style="font-size: 11pt">${store_dto.store_name}</span>
			</c:if>
			<c:if test="${store_dto == null}">
				<span class="navbar-brand" style="font-size: 11pt">설정된 매장없음</span>
			</c:if>
		</a>
		<ul class="nav navbar-nav" style="margin-left: 8%">
			<li><c:if test="${member_dto==null}">
					<a id="Log-In-Btn" href="login.member">Log-In</a>
				</c:if> <c:if test="${member_dto!=null}">
					<a id="Log-Out-Btn" href="logout.member">Log-Out</a>
				</c:if></li>
			<li><c:if test="${member_dto==null}">
					<a id="Register-Btn" href="register.member">Register</a>
				</c:if></li>
			<li><c:if test="${member_dto!=null}">
					<a id="My-Page-Btn" href="my_page.member">My Page</a>
				</c:if></li>
			<li><a href="#" id="OurStore-Btn">Our Store</a></li>
		</ul>
		<br />
		<ul class="nav navbar-nav">
			<li class="hidden"><a href="#page-top"></a></li>
			<!-- TryCoffee DropDown -->
			<li><a href="#`" id="Main-DropDown">Try Coffee</a></li>
			<!-- Order DropDown -->
			<li><a href="#" id="Main-DropDown">Order</a></li>
			<!-- Community DropDown -->
			<li><a href="#" id="Main-DropDown">Community</a></li>
			<li><a href="go.manager" id="Main-DropDown">Manager</a></li>
		</ul>
		<br />
		<!-- Main-DropDown-Menu -->
		<ul class="Main-DropDown-Menu nav navbar-nav" style="width: 100%;">
			<div>
				<hr />
			</div>
			<!-- 심플 가이드 -->
			<div id="Simple-Explain-Div" class="col-md-6"
				style="visibility: hidden; display: inline-block;">
				<h2>
					<i class="fa fa-lightbulb-o" aria-hidden="true"
						style="color: yellow; text-shadow: 1px 1px 1px #ccc; font-size: 1.5em;"></i>
					<span style="color: white">심플 가이드</span>
					<hr/>
				</h2>
				<!-- hover 된 dropdown menu명 -->
				<p id="Dropdown-Name" style="color: #18bc9c"></p>
				<!-- 해당 dropdown menu에 대한 설명 -->
				<p id="Dropdown-Simple-Explain" style="color: white"></p>
				<br />
			</div>
			<!-- dropdown menu -->
			<div style="padding-top: 40px; display:inline-block; margin-left: 115px">
					<!-- TryCoffee Menu -->
					<div style="display: inline-block;">
						<a name="Company" role="menuitem" tabindex="-1" href="front?cmd=trycoffee&check=company">회사소개</a><br /> 
						<a name="Ceo" role="menuitem" tabindex="-1" href="front?cmd=trycoffee&check=ceo">CEO 인사말</a><br /> 
					</div>
					<!-- Order Menu -->
					<div style="display: inline-block; margin-left: 15px">
						<a name="Drink" role="menuitem" tabindex="-1" href="front?cmd=order&check=drink">음료 주문 예약</a><br />
						<a name="MeetingRoom" id="MeetingRoom-Btn" role="menuitem" tabindex="-1" href="#">미팅룸 예약</a><br />
					</div>
					<!-- Community Menu -->
					<div style="display: inline-block; margin-left: 13px">
						<a name="Recipe" role="menuitem" tabindex="-1" href="/community/Recipe_List">Recipe<br/>Contest</a><br />
						<a name="Client" role="menuitem" tabindex="-1" href="#">고객의 소리</a><br />
					</div>
					<!-- Manager Menu -->
					<div  style="display: inline-block; margin-left: 30px">
						<a name="Member-Manage" role="menuitem" tabindex="-1" href="member.manager">회원 관리</a><br /> <a
							name="Store-Manage" role="menuitem" tabindex="-1" href="store.manager">매장 관리</a><br /> <a
							name="Board-Manage" role="menuitem" tabindex="-1" href="board.manager">게시판 관리</a><br /> <a
							name="Menu-Manage" role="menuitem" tabindex="-1" href="menu.manager">메뉴 관리</a><br />
					</div>
			</div>
		</ul>
	</nav>
</div>
