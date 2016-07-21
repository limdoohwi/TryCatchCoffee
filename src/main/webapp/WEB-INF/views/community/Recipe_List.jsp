<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
</head>
!-- Bootstrap Core CSS - Uses Bootswatch Flatly Theme: http://bootswatch.com/flatly/ -->
<link href="/resources/bootstrab/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="/resources/bootstrab/css/freelancer.css" rel="stylesheet">
<link href="/resources/bootstrab/css/heroic-features.css" rel="stylesheet">
<!-- Custom Fonts -->
<link href="/resources/bootstrab/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">
<link href="http://fonts.googleapis.com/css?family=Montserrat:400,700"
	rel="stylesheet" type="text/css">
<link
	href="http://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic"
	rel="stylesheet" type="text/css">

<!-- jQuery -->
<script src="/resources/bootstrab/js/jquery.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="/resources/bootstrab/js/bootstrap.min.js"></script>

<!-- Plugin JavaScript -->
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>
<script src="/resources/bootstrab/js/classie.js"></script>
<script src="/resources/bootstrab/js/cbpAnimatedHeader.js"></script>

<!-- Contact Form JavaScript -->
<script src="/resources/bootstrab/js/jqBootstrapValidation.js"></script>
<script src="/resources/bootstrab/js/contact_me.js"></script>

<!-- Custom Theme JavaScript -->
<script src="/resources/bootstrab/js/freelancer.js"></script>
<script>
$(function(){
	$("#recipe_write").click(function(){
		location.href="/community.recipe_insert";
	})
})

</script>
<style>
	.pagination {
	  display: inline-block;
	  padding-left: 0;
	  margin: 20px ;
	 margin-bottom: 10px;
	 margin-left:100px;
	}

</style>
<body>
<jsp:include page="/WEB-INF/views/layout/Header.jsp" />

<div class="container">
	<div class="row col-md-offset-2">
		<table class="table table-hover">
			<thead style="background-color: #18bc9c;">
				<tr>
					<th style="width: 10%; text-align: center;">NO</th>
					<th style="width: 30%; text-align: center;">TITLE</th>
					<th style="width: 20%; text-align: center;">WRITER</th>
					<th style="width: 20%; text-align: center;">DATE</th>
					<th style="width: 10%; text-align: center;">COUNT</th>
					<th style="width: 10%; text-align: center;">LIKES</th>
				</tr>
			</thead>
			<tbody style="text-align: center;">
			
<!-- Board Recipe List  -->
<c:set var="total_recipe_board" value="${fn:length(recipelistall)}"/>
<c:set var="recipe_list" value="${recipelist}"/>
				<c:choose>
					<c:when test="${total_recipe_board != null}">
						<c:forEach items="${recipe_list}" var="recipedto" end="10">
							<tr>
								<td>${recipedto.board_recipe_no}</td>
								<td onClick="location.href='/community.recipe_read?board_recipe_no=${recipedto.board_recipe_no}'" style="cursor: pointer;">${recipedto.board_recipe_title}</td>
								<td> ${recipedto.board_recipe_writer}</td>
								<td>${recipedto.board_recipe_date}</td>
								<td>${recipedto.board_recipe_count}</td>
								<td>${recipedto.board_recipe_likes}</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:when test="${total_recipe_board==0}">
						<td style="width: 100%; text-align: center;">데이터가 없습니다.</td>
					</c:when>
				</c:choose>	
			</tbody>
		</table>
		<!-- Search , Write  -->
		<form method="post" action="/community.recipe_search" class="form-inline">
			<input type="hidden" name="limit" value="0" />
		  <div class="form-group">
		    <input type="text" class="form-control" placeholder="SEARCH" name="board_recipe_search">
		  </div>
		  <div class="form-group">
		     <button type="submit" class="btn btn-default glyphicon glyphicon-zoom-in" style="background-color:#18bc9c">검색</button>
		  </div>
		  <div class="form-group">
		  
<c:set var="totalpage" value="${total_recipe_board}" />
<c:set var="totalblock" value="${(totalpage/10)}"/>


	<ul class="pagination">			
		<c:choose>
			<c:when test="${board_recipe_search==null}">
				<c:forEach begin="0" end="${totalblock}"  varStatus="status">
					<li>
						<a href="/community.Recipe_List?limit=${(status.index)*10}">${status.index+1}</a>
					</li>	
				</c:forEach>	
			</c:when>
			<c:when test="${board_recipe_search!=null}">
				<c:forEach begin="0" end="${totalblock}"  varStatus="status">
						<li>
							<a href="/community.recipe_search?board_recipe_search=${board_recipe_search}&limit=${(status.index)*10}">${status.index+1}</a>
						</li>	
				</c:forEach>
			</c:when>		
		</c:choose>
	</ul>	
		
		
				</div>		
		  <button type="button" id="recipe_write" class="btn btn-default glyphicon glyphicon-pencil" style="background-color:#18bc9c; margin-left:130px">글쓰기</button>
		</form>
	</div>
</div>


<jsp:include page="/WEB-INF/views/layout/Footer.jsp" />
</body>
</html>





