<!-- 
/*
 *  Description :  음료 주문 페이지
 *  Created : 2016-06-27
 *  Author : 김준혁
 *  
 *  Revisions :
 *  1.When & Who : 2016-07-19 임두휘
 *  2.What       : DB연동, Category별 메뉴 확인 구현, Cart 담기 구현
 */	
 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>
	$(
		function(){
			$.ajax({
				url:"/list.cart",
				type:"post",
				success:function(data){
					cart_list(data);
				}
			});		
			$(".menu_select_btn").click(
					function(){
						$.ajax({
							url:"/insert.cart",
							type:"post",
							data: {
								menu_num:$(this).val(),	
							},
							success:function(data){
								cart_list(data);
							},
							error:function(){
								alert("알수 없는 오류로인해 작업을 중지합니다. 다시 시도해 주세요");
								return false;
							}
						});		
					}
			);
			
		}		
	);
</script>

<div id="Drink-Div" class="container div-fade"
	style="border: 1px solid none; padding-top: 0px;">
	<!-- Navigation -->
	<ul class="nav nav-tabs">
		<c:forEach items="${menucategoryList}" var="menuCategory" varStatus="count">
				<li role="presentation" class='<c:if test="${count.count==1}">active</c:if>'><a href="#category_${menuCategory}" data-toggle="tab">${menuCategory}</a></li>
			
		</c:forEach>
	</ul>
	<br/>
	<!-- Page Features -->
	<div class="row text-center">
		<div class="tabbable">
			<div class="tab-content">
				<c:forEach var="menuCategory" items="${menucategoryList}" varStatus="i">
					<div class='tab-pane <c:if test="${i.count==1}">active</c:if>' id="category_${menuCategory}">
				
						<c:forEach items="${menuList}" var="menu">
							<c:if test="${menu.menu_category_name==menuCategory}">
								<div class="col-md-3 col-sm-6 hero-feature">
									<div class="thumbnail">
										<img src="/resources/imgUpload/${menu.menu_image}" style="width: 300px; height: 300px;">
										<div class="caption">
											<p>${menu.menu_name }</p>
											<p>${menu.menu_price }원</p>
											<p>
												<button class="menu_select_btn btn btn-danger" value="${menu.menu_num }">담기</button>
											</p>
										</div>
									</div>
								</div>
							</c:if>
						</c:forEach>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
</div>

<!-- 장바구니 -->
<jsp:include page="Cart.jsp" />