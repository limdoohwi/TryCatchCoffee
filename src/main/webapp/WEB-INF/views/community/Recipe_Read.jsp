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
			<div class="panel-body">${boardRecipeDTO.board_recipe_content}  
			<c:choose>
				<c:when test="${boardRecipeDTO.board_recipe_file != ''}">
					<video src="/resources/video_Upload/${boardRecipeDTO.board_recipe_file}" style="width:900px" controls="controls"></video>
				</c:when>
				<c:otherwise>
					<hr/>
				</c:otherwise>
			</c:choose>	
			</div>
			<div class="panel-body"><hr style="border: solid 10px #32A4FF"/></div>
		
			&nbsp;&nbsp;&nbsp;<a href="/community.recipe_modify?board_recipe_no=${boardRecipeDTO.board_recipe_no}">register</a>/&nbsp;<a href="/communty.recipe_delete?board_recipe_no=${boardRecipeDTO.board_recipe_no}">delete</a>/&nbsp;<a href="/community.Recipe_List">list</a>&nbsp;
		</div>
	</div>
</div>


<jsp:include page="/WEB-INF/views/layout/Footer.jsp" />	
</body>
</html>


<jsp:include page="/WEB-INF/views/layout/Footer.jsp" />