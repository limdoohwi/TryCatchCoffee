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
<script>
$(function(){
	$("#recipe_goback").click(function(){
		location.href="/community/Recipe_List";
	})
})
</script>
<body>
<jsp:include page="/WEB-INF/views/layout/Header.jsp" />

<div class="container">
	<form method="post" action="/community.recipe_insert">
		<div class="row col-md-offset-2">
			<div class="panel panel-info">
				<div class="panel-heading">	</div>
				<div class="panel-body">TITLE : &nbsp;&nbsp;&nbsp;<input type="text" class="form-control" name="board_recipe_title"/></div>
				<div class="panel-body">WRITER :<input type="text" class="form-control" name="board_recipe_writer"/></div>
				<div class="panel-body">COUNT : <textarea class="form-control" row="15" cols="50" name="board_recipe_content"></textarea> </div>
				<button type="submit" class="btn btn-default" style="background-color:#18bc9c">write</button> &nbsp;<button type="button" id="recipe_goback" class="btn btn-default" style="background-color:#18bc9c">목록으로</button>
			</div>
		</div>
	</form>
</div>

<jsp:include page="/WEB-INF/views/layout/Footer.jsp" />