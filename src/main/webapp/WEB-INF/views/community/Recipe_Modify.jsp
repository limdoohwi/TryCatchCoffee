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
<!-- Naver SmartEditor -->
<script src="/resources/smarteditor/js/HuskyEZCreator.js"></script>
<script>
$(function(){
	$("#recipe_goback").click(function(){
		location.href="/community.Recipe_List";
	})
})
$(function(){
    var editor_object = [];
     
    nhn.husky.EZCreator.createInIFrame({
        oAppRef: editor_object,
        elPlaceHolder: "smarteditor1",
        sSkinURI: "/../resources/smarteditor/SmartEditor2Skin.html", 
        htParams : {
            bUseToolbar : true,             
            bUseVerticalResizer : false,     
            bUseModeChanger : false, 
        }
    });
    $("#board_recipe_submit").click(function(){
        editor_object.getById["smarteditor1"].exec("UPDATE_CONTENTS_FIELD", []);
        $("#frm").submit();
    });
});
</script>
<body>
<jsp:include page="/WEB-INF/views/layout/Header.jsp" />

<div class="container">
	<form method="post" action="/community.recipe_modify">
		<input type="hidden" name="board_recipe_no" value="${boardRecipeDTO.board_recipe_no}"/>
		<div class="row col-md-offset-2">
			<div class="panel panel-info">
				<div class="panel-heading">	</div>
				<div class="panel-body">TITLE : &nbsp;&nbsp;&nbsp;<input type="text" placeholder="${boardRecipeDTO.board_recipe_title}" class="form-control" name="board_recipe_title"/></div>
				<div class="panel-body">COUTENT : <textarea name="board_recipe_content" id="smarteditor1" rows="10" cols="100" style="width:900px; height:500px;">${boardRecipeDTO.board_recipe_content}</textarea></div>
				<button type="submit" class="btn btn-default"  style="background-color:#18bc9c">write</button> &nbsp;<button type="button" id="recipe_goback" class="btn btn-default" style="background-color:#18bc9c">list</button>
			</div>
		</div>
	</form>
</div>

<jsp:include page="/WEB-INF/views/layout/Footer.jsp" />