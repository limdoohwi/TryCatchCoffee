<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
</head>
<!-- Bootstrap Core CSS - Uses Bootswatch Flatly Theme: http://bootswatch.com/flatly/ -->
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
<body>
<jsp:include page="/WEB-INF/views/layout/Header.jsp" />

<div class="container">
	<div class="row col-md-offset-2">
		<table class="table table-hover">
			<thead style="background-color: #18bc9c;">
				<tr>
					<th style="width: 10%; text-align: center;">NO</th>
					<th style="width: 40%; text-align: center;">TITLE</th>
					<th style="width: 20%; text-align: center;">WRITER</th>
					<th style="width: 20%; text-align: center;">DATE</th>
					<th style="width: 10%; text-align: center;">COUNT</th>
				</tr>
			</thead>
			<tbody style="text-align: center;">
			
<!-- Board Recipe List  -->
<c:set var="total_recipe_board" value="${fn:length(recipelist)}"/>
<c:set var="recipe_list" value="${recipelist}"/>
				<c:choose>
					<c:when test="${total_recipe_board != null}">
						<c:forEach items="${recipe_list}" var="recipedto">
							<tr>
								<td>${recipedto.board_recipe_no}</td>
								<td onClick="location.href='/community.recipe_read?board_recipe_no=${recipedto.board_recipe_no}'" style="cursor: pointer;">${recipedto.board_recipe_title}</td>
								<td> ${recipedto.board_recipe_writer}</td>
								<td>${recipedto.board_recipe_likes}</td>
								<td>${recipedto.board_recipe_count}</td>
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
		<form method="post" action="" class="form-inline">
		  <div class="form-group">
		    <input type="text" class="form-control" placeholder="SEARCH">
		  </div>
		  <div class="form-group">
		     <button type="submit" class="btn btn-default glyphicon glyphicon-zoom-in" style="background-color:#18bc9c">검색</button>
		  </div>
		  <button type="button" id="recipe_write" class="btn btn-default glyphicon glyphicon-pencil" style="background-color:#18bc9c">글쓰기</button>
		</form>
	</div>
</div>


<jsp:include page="/WEB-INF/views/layout/Footer.jsp" />
</body>
</html>





