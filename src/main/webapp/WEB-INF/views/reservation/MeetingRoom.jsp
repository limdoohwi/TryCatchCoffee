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
 
<link href='/resources/calendar/fullcalendar.css' rel='stylesheet' />
<link href='/resources/calendar/fullcalendar.print.css' rel='stylesheet' media='print' />
<script src='/resources/calendar/moment.min.js'></script>
<script src='/resources/calendar/jquery.min.js'></script>
<script src='/resources/calendar/fullcalendar.min.js'></script>

<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>

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
//var store_no = "${store_dto.store_no}";
var store_no = 1;
//var member_no = "${member_dto.member_no}";
var member_no = 1;

	$(document).ready(function(){
		$("#Meeting-Reservation-List-Div").hide();
		
		//모달창 닫기 버튼 클릭시 Meeting-Reservation-List-Div hide
		
		//설정된 매장의 미팅룸을 불러온다
		$.ajax({
			url:"meeting_room.store.meeting_room.order",
			type:"post",
			dataType:"json",
			data:{store_no:store_no},
			success:function(data){
				for(var i =0; i<data.meetingList.length; i++){
					$("#client_select_meeting_room").append("<option value='"+ data.meetingList[i].meeting_no +"'>" + data.meetingList[i].meeting_no+"번 미팅룸</option>");
				}
			},
			error:function(){
				alert("미팅룸을 불러오는데 실패하였습니다. 다시 시도해 주세요.");
			}
		});
		
		//해당 매장의 미팅룸 예약 가능 시간을 불러온다
		$("#client_select_meeting_room").change(function(){
			//버튼 초기화
			$("#Meeting-Reservation-List-Div").find("#meeting_time_table input[type=hidden]").each(
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
				//해당 날짜 클릭 후 해당 날짜에 예약되어 있는 예약 목록을 DB에서 불러온 후 선택불가로 변경
				$.ajax({
					url:"/search.reservation.meeting_room.order",
					type:"post",
					dataType:"json",
					data:{meeting_reservation_date:post_date, meeting_no:$("#client_select_meeting_room").val()},
					success:function(data){
						for(var i=0; i<data.meetingReservationTimeList.length; i++){
							meetingArray.push(data.meetingReservationTimeList[i].meeting_reservation_time);
						}
						//받아온 시간과 일치하는 버튼은 가능에서 불가로 변경
							$("#Meeting-Reservation-List-Div").find("#meeting_time_table input[type=hidden]").each(
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
					},
					error:function(){
						alert("실패");
					}
				});
		});
		
		//캘린더 시작시, 예약이 다 찬 날짜를 찾는다
		$.ajax({
			url:"/search.full_reservation_day.meeting_room.order",
			type:"post",
			dataType:"json",
			data:{store_no:store_no},
			success:function(data){
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
			}
		});
		
		$("#meeting_calendar_work_div").hide();
		
		$('#calendar').fullCalendar({
				defaultDate: sysdate,
				editable: true,
				selectable : true, 
			
			    //dayClick 할 때 실행되는 기능		    
			dayClick: function(date, jsEvent, view) {
				//미팅룸 선택 select box 초기화
				 Meeting_Reservation_List_Div_Initialize();
				//클라이언트가 클릭한 날짜의 미팅룸 Data를 불러옴
				post_date = date.format();
							
				$(".modal-header").find("#re-h3").html("&nbsp;&nbsp;&nbsp;"+"예약일 : " + date.format());
			 		 //alert("선택하신 날짜는?" + date.format());
			        //change the day's background color just for fun
		    	
				//고객이 선택한 날짜를 20160606이런식으로 나눔
				date = date.format().split("-");
			
		         var diffDay = ((60*60*24*365*date[0] - 60*60*24*365*newDate[0]) + (60*60*24*30*date[1] - 60*60*24*30*newDate[1]) + (60*60*24*date[2] - 60*60*24*newDate[2])) / (60 * 60 * 24);
		         if(diffDay < 0 || diffDay > 3){
		          alert("예약하실 수 없는 날짜 입니다.");
		          return false;
		         }
		         $("#Meeting-Reservation-List-Div").show();
			},
			
			events: [
						{
							start: firstdate ,
							end: lastdate ,
							overlap: false,
							rendering: 'background',
							color: '#53FF4C'
						},
						{
							start: sysdate ,
							end: sysdate ,
							overlap: false,
							rendering: 'background',
							color: 'yellow'
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
	
	//선택한 예약 시간을 회원정보, 매장정보와 함께 DB에 저장
		$("#meeting_time_table button").click(function(){
			var selectedTime = $(this).parent().parent().parent().find("input").val();
			$.ajax({
				url:"/insert.meeting_room.order",
				type:"post",
				dataType:"json",
				data:{meeting_reservation_time:selectedTime, meeting_reservation_date:post_date, meeting_order_date:sysdate, meeting_no:$("#client_select_meeting_room").val(), member_no:member_no},
				success:function(data){
					var time = selectedTime;
					if(data == false){
						alert("예약 진행 중 서버 오류 발생 :: 다시 한번 시도해주세요");
						return;
					}
					//예약된 time과 일치하는 button을 찾아 불가로 변경
					$("#Meeting-Reservation-List-Div").find("#meeting_time_table input[type=hidden]").each(
							function(){
									if(time==$(this).val()){
										$(this).parent().find("button").text("불가");
										$(this).parent().find("button").removeClass("btn-success");
										$(this).parent().find("button").addClass("btn-danger");
										$(this).parent().find("button").attr("disabled", true);
										alert("예약이 완료 되었습니다.");
									}
						}); 
				}
			});
		});
	
		//모달창 닫기 버튼
		$("#Show-Meeting-Reservation-List-Div-Hide-Btn").click(function(){
			Meeting_Reservation_List_Div_Initialize();
			$("#meeting_calendar_work_div").hide();
			$("#Meeting-Reservation-List-Div").hide();
		});
	})
	
	
	function Meeting_Reservation_List_Div_Initialize(){
		$("#client_select_meeting_room").val("미팅룸 선택");
		$("#meeting_calendar_work_div").hide();
	}

</script>

<style>

	body {
		margin: 40px 10px;
		padding: 0;
		font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
		font-size: 14px;
	}

	#calendar {
		max-width: 1200%;
		margin-top:20px;
		margin-left:6px
	}
	
	#Meeting-Reservation-List-Div {
		padding: 20px;
		border: 4px solid #ddd;
		position: absolute;
	    left: 0px;
	    top: 235px;
		background: #fff;
		
	}
	
	#Meeting-Reservation-List-Div button {
		cursor: pointer;
	}

</style>
</head>
<body>
<div class="container">
	<h2 style="color:#000000">미팅룸 예약</h2>
	<h4>날짜는 오늘날짜에서 +3일까지만 예약이 가능합니다.</h4>
	<div id='calendar'></div>
</div>

<div id="Meeting-Reservation-List-Div">
	<div class="modal-header">
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
 			<button id="Show-Meeting-Reservation-List-Div-Hide-Btn" type="button"
			class="btn btn-default">닫기</button>
 	</div>
</div>
</body>
</html>