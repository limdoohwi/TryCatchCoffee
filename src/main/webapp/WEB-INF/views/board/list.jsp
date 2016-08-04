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
			$(".board_subject_td").click(
				function(){
					var a = $(".board_subject_td").index(this);
					$("#post_board_num").val($(".board_num_td").eq(a).text());
					$("#board_hits").val($(".board_hits_td").eq(a).text());
					$(".board_read_form").submit();
				}		
			);
			
			$(".board_password_td").click(
					function(){
						var a = $(".board_password_td").index(this);
						$("#pass_board_num").val($(".pass_board_num_td").eq(a).text());
						$("#pass_board_hits").val($(".pass_board_hits_td").eq(a).text());
						$(".board_password_form").submit();
					}		
				);
		}		
	);
</script>
<!-- 페이지 넘버 -->
<c:set var="totalRecord_Board" value="${fn:length(list)}"/>
<c:set var="numPerPage_Board" value="5"/>
<c:set var="pagePerBlock_Board" value="5"/>
<fmt:formatNumber var="fmt_totalPage_Board" value="${totalRecord_Board / numPerPage_Board}" pattern="#.#" />
<c:if test="${fmt_totalPage_Board%1 > 0}">
	<fmt:parseNumber var="totalPage_Board" integerOnly="true" value="${(totalRecord_Board / numPerPage_Board)+1}" scope="session"/>
</c:if>
<c:if test="${fmt_totalPage_Board%1 == 0}">
	<fmt:parseNumber var="totalPage_Board" integerOnly="true" value="${totalRecord_Board / numPerPage_Board}" scope="session"/>
</c:if>
<fmt:formatNumber var="fmt_totalBlock_Board" value="${totalPage_Board/ pagePerBlock_Board}" pattern="#.#" />
<c:if test="${fmt_totalBlock_Board%1 > 0}">
	<fmt:parseNumber var="totalBlock_Board" integerOnly="true" value="${(totalPage_Board / pagePerBlock_Board)+1}" scope="session"/>
</c:if>
<c:if test="${fmt_totalBlock_Board%1 == 0}">
	<fmt:parseNumber var="totalBlock_Board" integerOnly="true" value="${totalPage_Board / pagePerBlock_Board}" scope="session"/>
</c:if>
<c:if test="${param.nowPage_Board == null }">
	<c:set var="nowPage_Board" value="0"/>
</c:if>
<c:if test="${param.nowPage_Board != null }">
	<c:set var="nowPage_Board" value="${param.nowPage_Board}"/>
</c:if>
<c:if test="${param.nowBlock_Board == null }">
	<c:set var="nowBlock_Board" value="0"/>
</c:if>
<c:if test="${param.nowBlock_Board != null }">
	<c:set var="nowBlock_Board" value="${param.nowBlock_Board}"/>
</c:if>
<c:set var="beginPerPage_Board" value="${nowPage_Board * numPerPage_Board}"/>


<jsp:include page="/WEB-INF/views/layout/Header.jsp" />
<h2 align="center">고객의 소리함 게시판</h2>

<table class=table style="border: none; ">
<tr>
	<td align=center colspan=2>
		<table class=table>
			<tr align=center bgcolor=#D0D0D0 height=120%>
				<td> 번호 </td>
				<td>작성자</td>
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
					<c:forEach begin="${beginPerPage_Board}" end="${(beginPerPage_Board + numPerPage_Board) -1}" items="${list}"  var="board">
						<c:if test="${board.board_depth ==0 }">
							<c:if test="${board.board_password==''}">
								<tr align=center >
									<td class="board_num_td" width="10%">${board.board_num }</td>
									<td>${member_dto.member_name }</td>
									<td class="board_subject_td" width="25%" style="cursor:pointer;" align="left">${board.board_subject}</td>
									<td>${board.board_date}</td>
									<td class="board_hits_td" width="10%">${board.board_hits }</td>
								</tr>
							</c:if>
							<c:if test="${board.board_password !=''}">
								<c:if test="${member_dto.member_code ==1}">
									<tr align=center >
										<td class="pass_board_num_td" width="10%">${board.board_num }</td>
										<td>${member_dto.member_name }</td>
										<td class="board_password_td" width="25%" style="cursor:pointer;" align="left">비밀글 입니다.</td>
										<td>${board.board_date}</td>
										<td class="pass_board_hits_td" width="10%">${board.board_hits }</td>
									</tr>
								</c:if>
								<c:if test="${member_dto.member_code ==2 || member_dto.member_code ==3 }">
									<tr align=center >
										<td class="board_num_td" width="10%">${board.board_num }</td>
										<td>${member_dto.member_name }</td>
										<td class="board_subject_td" width="25%" style="cursor:pointer;" align="left">${board.board_subject}</td>						
										<td>"${board.board_date}</td>
										<td class="board_hits_td" width="10%">${board.board_hits }</td>
									</tr>	
								</c:if>
							</c:if>
						</c:if>
						<c:if test="${board.board_depth !=0 }">
							<c:if test="${board.board_password == ''}">
								<tr align=center >
									<td class="board_num_td" width="10%">${board.board_num }</td>
									<td>${member_dto.member_name }</td>
									<td class="board_subject_td" width="25%" style="cursor:pointer;" align="left"><img src="/resources/img/re.gif" />${board.board_subject}</td>
									<td>${board.board_date}</td>
									<td class="board_hits_td"width="10%">${board.board_hits }</td>
								</tr>
							</c:if>
							<c:if test="${board.board_password !='' }">
								<c:if test="${member_dto.member_code==1 }">
									<tr align=center >
										<td class="pass_board_num_td" width="10%">${board.board_num }</td>
										<td>${member_dto.member_name }</td>
										<td class="board_password_td" width="25%" style="cursor:pointer;" align="left"><img src="/resources/img/re.gif"/>비밀글 답변 입니다.</td>				
										<td>${board.board_date}</td>
										<td class="pass_board_hits_td" width="10%">${board.board_hits }</td>
									</tr>
								</c:if>
								<c:if test="${member_dto.member_code==2 || member_dto.member_code==3 }">
									<tr align=center >
										<td class="board_num_td" width="10%">${board.board_num }</td>
										<td>${member_dto.member_name }</td>
										<td class="board_subject_td" width="25%" style="cursor:pointer;" align="left"><img src="/resources/img/re.gif" />${board.board_subject}</td>
										<td>${board.board_date}</td>
										<td class="board_hits_td" width="10%">${board.board_hits }</td>
									</tr>
								</c:if>
							</c:if>
						</c:if>		
					</c:forEach>
				</c:if>
			<form method="post" action="/read.client.board" class="board_read_form">
				<input type="hidden" id="post_board_num" name="board_num"/>
				<input type="hidden" name="board_password" value="${board.board_password }"/>
				<input type="hidden" name="board_poss" value="${board.board_pos }"/>
				<input type="hidden" name="member_no" value="${member_dto.member_no}"/>	
				<input type="hidden" name="board_hits" id="board_hits" />
			</form>
			<form method="post" action="/pass.client.board" class="board_password_form">
				<input type="hidden" id="pass_board_num" name="board_num"/>
				<input type="hidden" name="board_password" value="${board.board_password }"/>
				<input type="hidden" name="member_no" value="${member_dto.member_no}"/>
				<input type="hidden" name="board_hits" id="pass_board_hits" />			
			</form>
			</table>
			<table>
				<div class="span6 offset3" align="left">
					<div class="pagination">
			  			<ul>
			  				<c:if test="${nowBlock_Board > 0}">
			    				<td><a href="/board.list?beginPerPage_Board">Prev</a></td>
			    			</c:if>	
			    			<c:set var="BlockisCreate_Board" value="true"/>
			    			<c:forEach var="index_Board" begin="0" end="${pagePerBlock_Board-1}" varStatus="BlockNum_Board">
			   					<c:if test="${BlockisCreate_Board}">
			   						<c:if test="${(nowBlock_Board * pagePerBlock_Board) + index_Board == totalPage_Board-1}">
			   							<c:set var="BlockisCreate_Board" value="false"/>
			   						</c:if>
			   						<td width="30px">
			   						<a href="/board.list?nowPage_Board=${(nowBlock_Board* pagePerBlock_Board) + index_Board}&nowBlock_Board=${nowBlock_Board}&keyword=${param.keyWord}">${(nowBlock_Board * pagePerBlock_Board) + index_Board + 1}</a></td>
			   					</c:if>
			   				</c:forEach>
			   				<c:if test="${totalBlock_Board > nowBlock_Board + 1}">
			    				<td><a href="/board.list?nowPage_Board=${(nowBlock_Board + 1) * pagePerBlock_Board}&nowBlock_Board=${nowBlock_Board + 1}">Next</a></td>
			    			</c:if>
			  			</ul>
					</div>
				</div>
			</table>
	</td>
</tr>
<tr>
	<td><BR><BR></td>
</tr>
<tr>
	<td align="left">
		<form action="/board.list" method="post">
			<select name="keyValue">
				<option value="board_subject"> 글 제목
				<option value="board_content"> 글 내용
			</select>
			<input type="text" name="keyWord" value="${keyWord}"/>
			<button type="submit" id="search_button" class ="btn add-on">찾기<i class="icon-search"></i></button>
		</form>
	</td>
	<td align=right>
	<form method="post" action="/insert.client.board" id="post_form">
		<button type="submit" id="post_button" class ="btn add-on">글쓰기<i class="icon-pencil"></i></button>
		<input type="hidden" name="member_no" value="${member_dto.member_no}"/>
	</form>	
	</td>
</tr>
</table>
<BR>

<jsp:include page="/WEB-INF/views/layout/Footer.jsp" />
