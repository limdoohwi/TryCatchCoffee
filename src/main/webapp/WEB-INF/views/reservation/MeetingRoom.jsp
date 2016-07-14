<!-- 
/*
 *  Description :  미팅룸 예약 페이지
 *  Created : 2016-06-13
 *  Author : 손현민
 *  
 *  Revisions :
 *   1. When & Who : 2016-06-14 임두휘
 *     	What : 달력화면 기능 추가
 *   2. When & Who : 2016-06-20 김준혁
 *     	What : 전체적인 기능 개선
 */
 -->
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/resourcesbootstrap/css/bootstrap.min.css">
<script src="/resources/bootstrap/js/jquery-2.2.3.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<script type="text/javascript"></script>
 
<link href='js/fullcalendar.css' rel='stylesheet' />
<link href='js/fullcalendar.print.css' rel='stylesheet' media='print' />
<script src='js/moment.min.js'></script>
<script src='js/jquery.min.js'></script>
<script src='js/fullcalendar.min.js'></script>
<script>

var date = new Date();
var year = date.getFullYear();
var mon = date.getMonth()+1;
var day = date.getDate() ;
var day2 = date.getDate()+1;
var day3 = date.getDate()+4;
if((mon+"").length < 2){
	mon = "0" + mon;
}
//예약이 다 찬 날짜를 받아옴
var fulldate = null;
var events = new Array(); 
//i값으로 for문을 돌려보자..


if((day+"").length < 2){
	day = "0" + day;
}

var sysdate = year+"-"+mon+"-"+day
var firstdate = year+"-"+mon+"-"+day2
var lastdate = year+"-"+mon+"-"+day3
var selectdates = new Array();
for(var i = 0; i<4; i++){
	var day4 = day + i;
	selectdates[i] = year + "-" + mon + "-" + day4;
}
var post_date = "";
var meetingTime = 0;
var day = new Date();  //day는 오늘날짜
var newDate = new Array();
var flag = true;
var selectedDate = null;
newDate[0] = day.getFullYear(); //오늘연도 저장
newDate[1] = day.getMonth()+1; //오늘월 저장
if((newDate[1]+"").length < 2){ 
 newDate[1] = "0" + newDate[1];
}

newDate[2] = day.getDate(); // 오늘일 저장
if((newDate[2]+"").length < 2){
 newDate[2] = "0" + newDate[2];
}
var store_num = "${store_dto.store_num}";
var member_num = "${member_dto.member_num}";
	$(document).ready(function(){
		//캘린더 시작시, 예약이 다 찬 날짜를 찾는다
		$.post("front",{cmd:"ajax", param:"search_meeting_reservation_this_day", startCalendar:"true", store_num:store_num}, function(){}, 'json').done(function(data){
			if(data.meetingFullList[0].flag == "false"){
				alert("서버 오류");
				return false;
			}
			for(var i=0; i<data.meetingFullList.length; i++){
				fulldate = data.meetingFullList[0].fullDate;
				fulldate = fulldate.substring(0,8);
				
				//예약이 다 채워졌을 경우 발생하는 이벤트
				var fulldateArray = fulldate.split('-');
				var fulldateObj = new Date(fulldateArray[0],Number(fulldateArray[1])-1,fulldateArray[2]);
				var sysdateArray = sysdate.split('-');
				var sysdateObj = new Date(sysdateArray[0],Number(sysdateArray[1])-1,sysdateArray[2]);
				if(fulldateObj.getTime()>=sysdateObj.getTime()){
					event = new Object();        
					event.start = fulldates[i];    // its a date string 
					event.rendering = "background";
					event.color = "red";
					events.push(event);
				}
				//예약 가능한 날 background 이벤트
				for(var i=0; i< 4; i++){	
					var dateArray = sysdate.split('-');
					var dateObj = new Date(dateArray[0],Number(dateArray[1])-1,Number(sysdateArray[2])+i);
					var reddate = true;
					var fulldateArray = fulldate.split('-');
					var fulldateObj = new Date(fulldateArray[0],Number(fulldateArray[1])-1,fulldateArray[2]);
					if(fulldateObj.getTime()==dateObj.getTime()){
						reddate=false;
					}
					if(reddate == true){
						event = new Object();
						var realday = Number(dateArray[2])+i;
						var realdate = dateArray[0] + "-" + dateArray[1] + "-" + realday;
						event.start = realdate;
						event.rendering = "background";
						event.color = "#53FF4C";
						events.push(event);
					}
				}
			}
		});
		
		$("#meeting_calendar_work_div").hide();
		//접속한 매장의 미팅룸을 불러온다
		
		$.post("front", {cmd:"ajax", param:"store_meeting", store_num:store_num}, function(){}, 'json').done(function(data){
				for(var i =0; i<data.store_meetingList.length; i++){
					$("#client_select_meeting_room").append("<option>"+data.store_meetingList[i].meeting_num+"</option>");
				}
		});
		//해당 매장의 미팅룸 예약 가능 시간을 불러온다
		$("#client_select_meeting_room").change(function(){
			//버튼 초기화
			$("#theModal").find("#meeting_time_table input[type=hidden]").each(
					function(){
						$(this).parent().find("button").text("가능");
						$(this).parent().find("button").removeClass("btn-danger");
						$(this).parent().find("button").addClass("btn-success");
						$(this).parent().find("button").attr("disabled", false);
					});
			
			if($(this).val() == "미팅룸 선택"){
				alert("미팅룸을 선택해주세요");
				return false;
			}
			$("#meeting_calendar_work_div").show();
				var meetingArray = new Array();
				$.post("front",{cmd:"ajax", param:"search_meeting_reservation_this_day", date:post_date, meeting_num:$("#client_select_meeting_room").val()}, function(){}, 'json').done(function(data){
					for(var i=0; i<data.meetingTimeList.length; i++){
						if(data.meetingTimeList[0].flag == "false"){
							alert("서버 오류 :: 해당하는 데이터가 없습니다.");
							return false;
						}
						meetingArray.push(data.meetingTimeList[i].meeting_reservation_time);
					}
					//받아온 시간과 일치하는 버튼은 가능에서 불가로 변경
						$("#theModal").find("#meeting_time_table input[type=hidden]").each(
							function(i){
								for(var j=0; j<meetingArray.length; j++){
									if($(this).val() ==  meetingArray[j]){
										$(this).parent().find("button").text("불가");
										$(this).parent().find("button").removeClass("btn-success");
										$(this).parent().find("button").addClass("btn-danger");
										$(this).parent().find("button").attr("disabled", true);
										}
									}
								}		
							); 
				});
		
		});
	
			
		$('#calendar').fullCalendar({
				defaultDate: sysdate,
				editable: true,
				selectable : true, 
			
			    //dayClick 할 때 실행되는 기능		    
			dayClick: function(date, jsEvent, view) {
			
					//클라이언트가 클릭한 날짜의 미팅룸 Data를 불러옴
					post_date = date.format();
							
				
				$(".re-modal-header").find("#re-h3").html("&nbsp;&nbsp;&nbsp;"+"예약일 : " + date.format());
			 		 //alert("선택하신 날짜는?" + date.format());
			        //change the day's background color just for fun
		    	
				//고객이 선택한 날짜를 20160606이런식으로 나눔
				date = date.format().split("-");
			
		         var diffDay = ((60*60*24*365*date[0] - 60*60*24*365*newDate[0]) + (60*60*24*30*date[1] - 60*60*24*30*newDate[1]) + (60*60*24*date[2] - 60*60*24*newDate[2])) / (60 * 60 * 24);
		         if(diffDay < 0 || diffDay > 3){
		          alert("예약하실 수 없는 날짜 입니다.");
		          return false;
		         }
		             
		         $("#theModal").show();
			},
			
			events: [
						{
							start: firstdate ,
							end: lastdate ,
							overlap: false,
							rendering: 'background',
							color: '#53FF4C'
						}
						
			],
			/*eventRender: function(event, element) {
				alert(event.id);
				for(var i=0;i<4;i++){
					for(var j=0; j<fulldates.length; j++){
						alert(typeof selectdates[i]);
						alert(typeof fulldates[j]);
						if(selectdates[i]==fulldates[j]){
							alert("들어왔구나");
							element.css('background','red');
						}else{
							alert("같지 않음");
						}
					}
				}
			}*/
				
			//for(i=0;i<){
				
		//}
				/*eventClick :  function ( event ){ 
			         $("<div>").dialog({ modal: true, title: event.title, width:350});
	    		 }*/

		});
	
		
		
		$('#calendar').fullCalendar('addEventSource',events);
		//닫기 버튼
		$("#btnModalClose").click( 
		    	function(){
					$("#theModal").modal('toggle');
				}			
		    );
		
	});
	
	$(document).ready(function() {
		$("#meeting_time_table button").click(function(){
	
			var selectedTime = $(this).parent().parent().parent().find("input").val();
			$.post("front" , {cmd:"ajax", param:"meetingroom_insert",selectedTime:selectedTime, selectedDate:post_date, meeting_num:$("#client_select_meeting_room").val(), member_num:member_num}, function(){}, 'json').done(function(data){
				var time = data.meeting_time;
				if(time == 0){
					alert("예약 진행 중 서버 오류 발생 :: 다시 한번 시도해주세요");
					return;
				}
				//예약된 time과 일치하는 button을 찾아 불가로 변경
				$("#theModal").find("#meeting_time_table input[type=hidden]").each(
						function(){
								if(time==$(this).val()){
									$(this).parent().find("button").text("불가");
									$(this).parent().find("button").removeClass("btn-success");
									$(this).parent().find("button").addClass("btn-danger");
									$(this).parent().find("button").attr("disabled", true);
									alert("예약이 완료 되었습니다.");
							}
						}); 
			});
		});
	}
	)
	

</script>

<style>

	body {
		margin: 40px 10px;
		padding: 0;
		font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
		font-size: 14px;
	}

	#calendar {
		max-width: 800px;
		margin-top:20px;
		margin-left:6px
	}

</style>
</head>
<body>
<div class="container">
	<h2 style="color:#000000">미팅룸 예약</h2>
	<h4>날짜는 오늘날짜에서 +3일까지만 예약이 가능합니다.</h4>
	<div id='calendar'></div>
</div>
	<div class="modal hide" id="theModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel1" aria-hidden="true" style="width:450px;">
 				<div class="re-modal-header">
 					<h3 id="re-h3">&nbsp;</h3>
 				</div>
 				<div class="modal-body">
 				<select id="client_select_meeting_room">
 					<option>미팅룸 선택</option>
 				</select>
	 				<div id="meeting_calendar_work_div">
		 				<table id="meeting_time_table" class="table table-bordered">
									<thead>
										<tr bgcolor="#f5f2ed">
											<th>&nbsp;&nbsp;시간</th>
											<th>&nbsp;&nbsp;최대 인원수</th>
											<th>&nbsp;&nbsp;&nbsp;&nbsp;예약 확인</th>
										</tr>
										
									</thead>
								
								<tr>
									<input type="hidden" value="1" />
		 							<td id="meeting_time_td" style="font-size:10px; width:140px;text-align:left;vertical-align: middle;">&nbsp;&nbsp;&nbsp;10:00~<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;12:00</td>
		 							<td style="font-size:10px; width:140px;text-align:left;vertical-align: middle;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;6인</td>
		 							<td ><div class="span1"><button class="btn btn-success" onclick="">가능</button></div></td>
		 						<!--<td ><div class="span1"><button class="btn btn-danger disabled">불가</button></div></td>-->
		 							
		 						</tr>
		 						
		 						<tr bgcolor="#f5f2ed">
		 							<input type="hidden" value="2" />
		 							<td id="meeting_time_td" style="font-size:10px; width:140px;text-align:left;vertical-align: middle;">&nbsp;&nbsp;&nbsp;12:00~<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;14:00</td>
		 							<td style="font-size:10px; width:140px;text-align:left;vertical-align: middle;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;6인</td>
		 							<td ><div class="span1"><button class="btn btn-success">가능</button></div></td>
		 						</tr>
		 						
		 						<tr>
		 							<input type="hidden" value="3" />
		 							<td id="meeting_time_td" style="font-size:10px; width:140px;text-align:left;vertical-align: middle;">&nbsp;&nbsp;&nbsp;14:00~<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;16:00</td>
		 							<td style="font-size:10px; width:140px;text-align:left;vertical-align: middle;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;6인</td>
		 							<td ><div class="span1"><button class="btn btn-success">가능</button></div></td>
		 						</tr>
		 						
		 						<tr bgcolor="#f5f2ed">
		 							<input type="hidden" value="4" />
		 							<td id="meeting_time_td" style="font-size:10px; width:140px;text-align:left;vertical-align: middle;">&nbsp;&nbsp;&nbsp;16:00~<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;18:00</td>
		 							<td style="font-size:10px; width:140px;text-align:left;vertical-align: middle;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;6인</td>
		 							<td ><div class="span1"><button class="btn btn-success">가능</button></div></td>
		 						</tr>
		 						
		 						<tr>
		 							<input type="hidden" value="5" />
		 							<td id="meeting_time_td" style="font-size:10px; width:140px;text-align:left;vertical-align: middle;">&nbsp;&nbsp;&nbsp;18:00~<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;20:00</td>
		 							<td style="font-size:10px; width:140px;text-align:left;vertical-align: middle;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;6인</td>
		 							<td ><div class="span1"><button class="btn btn-success">가능</button></div></td>
		 						</tr>
		 						
		 						<tr bgcolor="#f5f2ed">
		 							<input type="hidden" value="6" />
		 							<td id="meeting_time_td" style="font-size:10px; width:140px;text-align:left;vertical-align: middle;">&nbsp;&nbsp;&nbsp;20:00~<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;22:00</td>
		 							<td style="font-size:10px; width:140px;text-align:left;vertical-align: middle;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;6인</td>
		 							<td ><div class="span1"><button class="btn btn-success">가능</button></div></td>
		 						</tr>
		 						
		 						
		 				</table>
	 				</div>
 				</div>
 				
 				<div class="modal-footer">
 					<button class="btn btn-danger" data-dismiss="modal" id="btnModalClose">닫기</button>
 				</div>
 				</div>
 			
 			<br/><br/>
 <script src="/resources/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>