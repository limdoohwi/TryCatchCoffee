<!-- 
/*
 *  Description :  ���÷� ���� ������
 *  Created : 2016-06-13
 *  Author : ������
 *  
 *  Revisions :
 *   1. When & Who : 2016-06-14 �ӵ���
 *     	What : �޷�ȭ�� ��� �߰�
 *   2. When & Who : 2016-06-20 ������
 *     	What : ��ü���� ��� ����
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
//������ �� �� ��¥�� �޾ƿ�
var fulldate = null;
var events = new Array(); 
//i������ for���� ��������..


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
var day = new Date();  //day�� ���ó�¥
var newDate = new Array();
var flag = true;
var selectedDate = null;
newDate[0] = day.getFullYear(); //���ÿ��� ����
newDate[1] = day.getMonth()+1; //���ÿ� ����
if((newDate[1]+"").length < 2){ 
 newDate[1] = "0" + newDate[1];
}

newDate[2] = day.getDate(); // ������ ����
if((newDate[2]+"").length < 2){
 newDate[2] = "0" + newDate[2];
}
//var store_no = "${store_dto.store_no}";
var store_no = 1;
//var member_no = "${member_dto.member_no}";
var member_no = 1;

	$(document).ready(function(){
		$("#Meeting-Reservation-List-Div").hide();
		
		//���â �ݱ� ��ư Ŭ���� Meeting-Reservation-List-Div hide
		
		//������ ������ ���÷��� �ҷ��´�
		$.ajax({
			url:"meeting_room.store.meeting_room.order",
			type:"post",
			dataType:"json",
			data:{store_no:store_no},
			success:function(data){
				for(var i =0; i<data.meetingList.length; i++){
					$("#client_select_meeting_room").append("<option value='"+ data.meetingList[i].meeting_no +"'>" + data.meetingList[i].meeting_no+"�� ���÷�</option>");
				}
			},
			error:function(){
				alert("���÷��� �ҷ����µ� �����Ͽ����ϴ�. �ٽ� �õ��� �ּ���.");
			}
		});
		
		//�ش� ������ ���÷� ���� ���� �ð��� �ҷ��´�
		$("#client_select_meeting_room").change(function(){
			//��ư �ʱ�ȭ
			$("#Meeting-Reservation-List-Div").find("#meeting_time_table input[type=hidden]").each(
					function(){
						$(this).parent().find("button").text("����");
						$(this).parent().find("button").removeClass("btn-danger");
						$(this).parent().find("button").addClass("btn-success");
						$(this).parent().find("button").attr("disabled", false);
					});
			
			if($(this).val() == "���÷� ����"){
				alert("���÷��� �������ּ���");
				return false;
			}
			$("#meeting_calendar_work_div").show();
				var meetingArray = new Array();
				//�ش� ��¥ Ŭ�� �� �ش� ��¥�� ����Ǿ� �ִ� ���� ����� DB���� �ҷ��� �� ���úҰ��� ����
				$.ajax({
					url:"/search.reservation.meeting_room.order",
					type:"post",
					dataType:"json",
					data:{meeting_reservation_date:post_date, meeting_no:$("#client_select_meeting_room").val()},
					success:function(data){
						for(var i=0; i<data.meetingReservationTimeList.length; i++){
							meetingArray.push(data.meetingReservationTimeList[i].meeting_reservation_time);
						}
						//�޾ƿ� �ð��� ��ġ�ϴ� ��ư�� ���ɿ��� �Ұ��� ����
							$("#Meeting-Reservation-List-Div").find("#meeting_time_table input[type=hidden]").each(
								function(i){
									for(var j=0; j<meetingArray.length; j++){
										if($(this).val() ==  meetingArray[j]){
											$(this).parent().find("button").text("�Ұ�");
											$(this).parent().find("button").removeClass("btn-success");
											$(this).parent().find("button").addClass("btn-danger");
											$(this).parent().find("button").attr("disabled", true);
											}
										}
									}		
								); 
					},
					error:function(){
						alert("����");
					}
				});
		});
		
		//Ķ���� ���۽�, ������ �� �� ��¥�� ã�´�
		$.ajax({
			url:"/search.full_reservation_day.meeting_room.order",
			type:"post",
			dataType:"json",
			data:{store_no:store_no},
			success:function(data){
				if(data.meetingFullList[0].flag == "false"){
					alert("���� ����");
					return false;
				}
				for(var i=0; i<data.meetingFullList.length; i++){
					fulldate = data.meetingFullList[0].fullDate;
					fulldate = fulldate.substring(0,8);
					
					//������ �� ä������ ��� �߻��ϴ� �̺�Ʈ
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
					//���� ������ �� background �̺�Ʈ
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
			
			    //dayClick �� �� ����Ǵ� ���		    
			dayClick: function(date, jsEvent, view) {
				//���÷� ���� select box �ʱ�ȭ
				 Meeting_Reservation_List_Div_Initialize();
				//Ŭ���̾�Ʈ�� Ŭ���� ��¥�� ���÷� Data�� �ҷ���
				post_date = date.format();
							
				$(".modal-header").find("#re-h3").html("&nbsp;&nbsp;&nbsp;"+"������ : " + date.format());
			 		 //alert("�����Ͻ� ��¥��?" + date.format());
			        //change the day's background color just for fun
		    	
				//���� ������ ��¥�� 20160606�̷������� ����
				date = date.format().split("-");
			
		         var diffDay = ((60*60*24*365*date[0] - 60*60*24*365*newDate[0]) + (60*60*24*30*date[1] - 60*60*24*30*newDate[1]) + (60*60*24*date[2] - 60*60*24*newDate[2])) / (60 * 60 * 24);
		         if(diffDay < 0 || diffDay > 3){
		          alert("�����Ͻ� �� ���� ��¥ �Դϴ�.");
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
							alert("���Ա���");
							element.css('background','red');
						}else{
							alert("���� ����");
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
	
	//������ ���� �ð��� ȸ������, ���������� �Բ� DB�� ����
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
						alert("���� ���� �� ���� ���� �߻� :: �ٽ� �ѹ� �õ����ּ���");
						return;
					}
					//����� time�� ��ġ�ϴ� button�� ã�� �Ұ��� ����
					$("#Meeting-Reservation-List-Div").find("#meeting_time_table input[type=hidden]").each(
							function(){
									if(time==$(this).val()){
										$(this).parent().find("button").text("�Ұ�");
										$(this).parent().find("button").removeClass("btn-success");
										$(this).parent().find("button").addClass("btn-danger");
										$(this).parent().find("button").attr("disabled", true);
										alert("������ �Ϸ� �Ǿ����ϴ�.");
									}
						}); 
				}
			});
		});
	
		//���â �ݱ� ��ư
		$("#Show-Meeting-Reservation-List-Div-Hide-Btn").click(function(){
			Meeting_Reservation_List_Div_Initialize();
			$("#meeting_calendar_work_div").hide();
			$("#Meeting-Reservation-List-Div").hide();
		});
	})
	
	
	function Meeting_Reservation_List_Div_Initialize(){
		$("#client_select_meeting_room").val("���÷� ����");
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
	<h2 style="color:#000000">���÷� ����</h2>
	<h4>��¥�� ���ó�¥���� +3�ϱ����� ������ �����մϴ�.</h4>
	<div id='calendar'></div>
</div>

<div id="Meeting-Reservation-List-Div">
	<div class="modal-header">
 		<h3 id="re-h3">&nbsp;</h3>
 	</div>
	
	<div class="modal-body">
 				<select id="client_select_meeting_room">
 					<option>���÷� ����</option>
 				</select>
	 				<div id="meeting_calendar_work_div">
		 				<table id="meeting_time_table" class="table table-bordered">
									<thead>
										<tr bgcolor="#f5f2ed">
											<th>&nbsp;&nbsp;�ð�</th>
											<th>&nbsp;&nbsp;�ִ� �ο���</th>
											<th>&nbsp;&nbsp;&nbsp;&nbsp;���� Ȯ��</th>
										</tr>
										
									</thead>
								
								<tr>
									<input type="hidden" value="1" />
		 							<td id="meeting_time_td" style="font-size:10px; width:140px;text-align:left;vertical-align: middle;">&nbsp;&nbsp;&nbsp;10:00~<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;12:00</td>
		 							<td style="font-size:10px; width:140px;text-align:left;vertical-align: middle;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;6��</td>
		 							<td ><div class="span1"><button class="btn btn-success" onclick="">����</button></div></td>
		 						<!--<td ><div class="span1"><button class="btn btn-danger disabled">�Ұ�</button></div></td>-->
		 							
		 						</tr>
		 						
		 						<tr bgcolor="#f5f2ed">
		 							<input type="hidden" value="2" />
		 							<td id="meeting_time_td" style="font-size:10px; width:140px;text-align:left;vertical-align: middle;">&nbsp;&nbsp;&nbsp;12:00~<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;14:00</td>
		 							<td style="font-size:10px; width:140px;text-align:left;vertical-align: middle;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;6��</td>
		 							<td ><div class="span1"><button class="btn btn-success">����</button></div></td>
		 						</tr>
		 						
		 						<tr>
		 							<input type="hidden" value="3" />
		 							<td id="meeting_time_td" style="font-size:10px; width:140px;text-align:left;vertical-align: middle;">&nbsp;&nbsp;&nbsp;14:00~<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;16:00</td>
		 							<td style="font-size:10px; width:140px;text-align:left;vertical-align: middle;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;6��</td>
		 							<td ><div class="span1"><button class="btn btn-success">����</button></div></td>
		 						</tr>
		 						
		 						<tr bgcolor="#f5f2ed">
		 							<input type="hidden" value="4" />
		 							<td id="meeting_time_td" style="font-size:10px; width:140px;text-align:left;vertical-align: middle;">&nbsp;&nbsp;&nbsp;16:00~<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;18:00</td>
		 							<td style="font-size:10px; width:140px;text-align:left;vertical-align: middle;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;6��</td>
		 							<td ><div class="span1"><button class="btn btn-success">����</button></div></td>
		 						</tr>
		 						
		 						<tr>
		 							<input type="hidden" value="5" />
		 							<td id="meeting_time_td" style="font-size:10px; width:140px;text-align:left;vertical-align: middle;">&nbsp;&nbsp;&nbsp;18:00~<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;20:00</td>
		 							<td style="font-size:10px; width:140px;text-align:left;vertical-align: middle;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;6��</td>
		 							<td ><div class="span1"><button class="btn btn-success">����</button></div></td>
		 						</tr>
		 						
		 						<tr bgcolor="#f5f2ed">
		 							<input type="hidden" value="6" />
		 							<td id="meeting_time_td" style="font-size:10px; width:140px;text-align:left;vertical-align: middle;">&nbsp;&nbsp;&nbsp;20:00~<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;22:00</td>
		 							<td style="font-size:10px; width:140px;text-align:left;vertical-align: middle;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;6��</td>
		 							<td ><div class="span1"><button class="btn btn-success">����</button></div></td>
		 						</tr>	
		 				</table>
	 				</div>
 	</div>
 	<div class="modal-footer">
 			<button id="Show-Meeting-Reservation-List-Div-Hide-Btn" type="button"
			class="btn btn-default">�ݱ�</button>
 	</div>
</div>
</body>
</html>