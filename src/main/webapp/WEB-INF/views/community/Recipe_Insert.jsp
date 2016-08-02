<%@ page contentType="text/html; charset=UTF-8" %>
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
        elPlaceHolder: "smarteditor",
        sSkinURI: "/../resources/smarteditor/SmartEditor2Skin.html", 
        htParams : {
            bUseToolbar : true,             
            bUseVerticalResizer : false,     
            bUseModeChanger : false, 
        }
    });
    $("#board_recipe_submit").click(function(){
        editor_object.getById["smarteditor"].exec("UPDATE_CONTENTS_FIELD", []);
        $("#frm").submit();
    });
});


</script>
<body>
<jsp:include page="/WEB-INF/views/layout/Header.jsp" />

<div class="container">
	<form method="post" action="/community.recipe_insert" id="frm" enctype="multipart/form-data">
		<div class="row col-md-offset-2">
			<div class="panel panel-info">
				<div class="panel-heading">	</div>
				<div class="panel-body">TITLE : &nbsp;&nbsp;&nbsp;<input type="text" class="form-control" name="board_recipe_title"/></div>
				&nbsp;&nbsp;<input type="file" name = "board_recipe_file" id="board_recipe_file">

				<div class="panel-body">CONTENT : <textarea name="board_recipe_content" id="smarteditor" rows="10" cols="100" style="width:900px; height:500px;"></textarea></div>
				<button type="button" id="board_recipe_submit" class="btn btn-default" style="background-color:#18bc9c">write</button> &nbsp;<button type="button" id="recipe_goback" class="btn btn-default" style="background-color:#18bc9c">목록으로</button>
			</div>
		</div>
	</form>
</div>
<script type="text/javascript" src="/resources/smarteditor/quick_photo_uploader/plugin/hp_SE2M_AttachQuickPhoto.js" charset="utf-8"> </script>
<jsp:include page="/WEB-INF/views/layout/Footer.jsp" />
</body>
</html>
