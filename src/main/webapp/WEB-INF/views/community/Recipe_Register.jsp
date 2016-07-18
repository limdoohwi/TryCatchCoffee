<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
</head>

<!-- Bootstrap Core CSS - Uses Bootswatch Flatly Theme: http://bootswatch.com/flatly/ -->
<link href="/resources/bootstrab/css/bootstrap.min.css" rel="stylesheet">
<!-- jQuery -->
<script src="/resources/bootstrab/js/jquery.js"></script>
<!-- Bootstrap Core JavaScript -->
<script src="/resources/bootstrab/js/bootstrap.min.js"></script>



<body>
<jsp:include page="/WEB-INF/views/layout/Header.jsp" />


<div class="container">
	<div class="row col-md-offset-2">
		<div class="panel panel-info">
			<div class="panel-heading">
				<h3 class="panel-title" style="text-align: center;">${boardRecipeDTO.board_recipe_title}</h3>
			</div>
			<div class="panel-body">WRITER : ${boardRecipeDTO.board_recipe_writer}</div>
			<div class="panel-body">DATE : ${boardRecipeDTO.board_recipe_date}</div>
			<div class="panel-body">COUNT : ${boardRecipeDTO.board_recipe_count}</div>
			<div class="panel-body">LIKES : ${boardRecipeDTO.board_recipe_likes}</div>
			<div class="panel-body"><hr style="border: solid 10px #32A4FF"/></div>
			<div class="panel-body">${boardRecipeDTO.board_recipe_content}</div>
			<div class="panel-body"><hr style="border: solid 10px #32A4FF"/></div>
			&nbsp;&nbsp;&nbsp;<a href="/community.recipe_modify">수정</a>/&nbsp;<a href="#">삭제</a>/&nbsp;<a href="#">목록으로</a>&nbsp;
		</div>
		
		
	</div>
</div>


<jsp:include page="/WEB-INF/views/layout/Footer.jsp" />	
</body>
</html>