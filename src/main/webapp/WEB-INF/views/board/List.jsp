<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
	function check(){
		if(document.search.keyWord.value == ""){
			alert("검색어를 입력하세요.");
			document.search.keyWord.focus();
			return;
		}
		document.search.submit();
	}
	
		$(function(){
			$("#board_subject_td").click(
				function(){
					var a = $("#board_subject_td").index(this);
					$("#board_num").val($("#board_num_td").eq(a).text());
					$("#board_read_form").submit();
				}		
			);
			$("#board_passsword_td").click(
					function(){
						var a = $("#board_password_td").index(this);
						$("#board_num").val($("#board_num_td").eq(a).text());
						$("#board_password_form").submit();
					}		
				);
		}		
	);
	
</script>
<jsp:include page="/WEB-INF/views/layout/Header.jsp" />
<h2 align="center">고객의 소리함 게시판</h2>

<c:set var="totalRecord_Board" value="${fn:length(list)}"/>
<table class=table>
<tr>
	<td align=left>Total :  Articles(
		<font color=red>  1 / 10 Pages </font>)
	</td>
</tr>
</table>

<table class=table style="border: none; ">
<tr>
	<td align=center colspan=2>
		<table class=table>
			<tr align=center bgcolor=#D0D0D0 height=120%>
				<td> 번호 </td>
				<td> 제목 </td>
				<td> 날짜 </td>
				<td> 조회수 </td>
			</tr>
			<tr>
				<c:if test="${totalRecord_Board == 0 }" >
					<td>데이터가 없습니다.</td>
				</c:if>
			</tr>
				<c:if test="${totalRecord_Board != 0 }" >
					<c:forEach items="${list}"  var="board">
						<c:if test="${board.board_depth ==0 }">
							<c:if test="${board.board_password==null }">
								<tr align=center >
								<td id="board_num_td" width="10%">${board.board_num }</td>
								<td id="board_subject_td" width="25%" style="cursor:pointer;">${board.board_subject}</td>
								<td width="10%">${board.board_date}</td>
								<td width="10%">${board.board_hits }</td>
								</tr>
							</c:if>
							<c:if test="${board.board_password !=null }">
								<tr align=center >
								<td id="board_num_td" width="10%">${board.board_num }</td>
								<td id="board_password_td" width="25%" style="cursor:pointer;">비밀글 입니다.</td>
								<td width="10%">${board.board_date}</td>
								<td width="10%">${board.board_hits }</td>
								</tr>
							</c:if>
						</c:if>
						<c:if test="${board.board_depth !=0 }">
							<c:if test="${board.board_password==null }">
								<tr align=center >
								<td id="board_num_td" width="10%">${board.board_num }</td>
								<td id="board_subject_td" width="25%" style="cursor:pointer;"><img src="/WEB-INF/img/re.gi"/>${board.board_subject}</td>
								<td width="10%">${board.board_date}</td>
								<td width="10%">${board.board_hits }</td>
								</tr>
							</c:if>
							<c:if test="${board.board_password !=null }">
								<tr align=center >
								<td id="board_num_td" width="10%">${board.board_num }</td>
								<td id="board_password_td" width="25%" style="cursor:pointer;"><img src="/WEB-INF/img/re.gif">비밀글 답변 입니다.</td>
								<td width="10%">${board.board_date}</td>
								<td width="10%">${board.board_hits }</td>
								</tr>
							</c:if>
						</c:if>		
					</c:forEach>
				</c:if>
			<form method="post" action="read.client.board" id="board_read_form">
				<input type="hidden" id="board_num" name="board_num"/>		
			</form>
			<form method="post" action="pass.client.board" id="board_password_form">
				<input type="hidden" id="board_num" name="board_num"/>			
			</form>
		</table>
	</td>
</tr>
<tr>
	<td><BR><BR></td>
</tr>
<tr>
	<td align="left">Go to Page </td>
	<td align=right>
	<form method="post" action="insert.client.board" id="post_form">
		<button type="submit" id="post_button" class ="btn add-on">글쓰기<i class="icon-pencil"></i></button>
	<!--  <a href="javascript:list()">[처음으로]</a> -->
	</form>	
	</td>
</tr>
</table>
<BR>
<form action="List.jsp" name="search" method="post">
	<table >
	<tr>
		<td align=center valign=bottom>
			<select name="keyField" size="1">
				<option value="name"> 이름
				<option value="subject"> 제목
				<option value="content"> 내용
			</select>
			<input type="text" size="16" name="keyWord" >
			<input type="button" value="찾기" onClick="check()">
			<input type="hidden" name="page" value= "0">
		</td>
	</tr>
	</table>
</form>

<jsp:include page="/WEB-INF/views/layout/Footer.jsp" />
