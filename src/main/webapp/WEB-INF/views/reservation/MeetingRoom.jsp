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
var store_num = "${store_dto.store_num}";
var member_num = "${member_dto.member_num}";
	$(document).ready(function(){
		//Ķ���� ���۽�, ������ �� �� ��¥�� ã�´�
		$.post("front",{cmd:"ajax", param:"search_meeting_reservation_this_day", startCalendar:"true", store_num:store_num}, function(){}, 'json').done(function(data){
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
		});
		
		$("#meeting_calendar_work_div").hide();
		//������ ������ ���÷��� �ҷ��´�
		
		$.post("front", {cmd:"ajax", param:"store_meeting", store_num:store_num}, function(){}, 'json').done(function(data){
				for(var i =0; i<data.store_meetingList.length; i++){
					$("#client_select_meeting_room").append("<option>"+data.store_meetingList[i].meeting_num+"</option>");
				}
		});
		//�ش� ������ ���÷� ���� ���� �ð��� �ҷ��´�
		$("#client_select_meeting_room").change(function(){
			//��ư �ʱ�ȭ
			$("#theModal").find("#meeting_time_table input[type=hidden]").each(
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
				$.post("front",{cmd:"ajax", param:"search_meeting_reservation_this_day", date:post_date, meeting_num:$("#client_select_meeting_room").val()}, function(){}, 'json').done(function(data){
					for(var i=0; i<data.meetingTimeList.length; i++){
						if(data.meetingTimeList[0].flag == "false"){
							alert("���� ���� :: �ش��ϴ� �����Ͱ� �����ϴ�.");
							return false;
						}
						meetingArray.push(data.meetingTimeList[i].meeting_reservation_time);
					}
					//�޾ƿ� �ð��� ��ġ�ϴ� ��ư�� ���ɿ��� �Ұ��� ����
						$("#theModal").find("#meeting_time_table input[type=hidden]").each(
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
				});
		
		});
	
			
		$('#calendar').fullCalendar({
				defaultDate: sysdate,
				editable: true,
				selectable : true, 
			
			    //dayClick �� �� ����Ǵ� ���		    
			dayClick: function(date, jsEvent, view) {
			
					//Ŭ���̾�Ʈ�� Ŭ���� ��¥�� ���÷� Data�� �ҷ���
					post_date = date.format();
							
				
				$(".re-modal-header").find("#re-h3").html("&nbsp;&nbsp;&nbsp;"+"������ : " + date.format());
			 		 //alert("�����Ͻ� ��¥��?" + date.format());
			        //change the day's background color just for fun
		    	
				//���� ������ ��¥�� 20160606�̷������� ����
				date = date.format().split("-");
			
		         var diffDay = ((60*60*24*365*date[0] - 60*60*24*365*newDate[0]) + (60*60*24*30*date[1] - 60*60*24*30*newDate[1]) + (60*60*24*date[2] - 60*60*24*newDate[2])) / (60 * 60 * 24);
		         if(diffDay < 0 || diffDay > 3){
		          alert("�����Ͻ� �� ���� ��¥ �Դϴ�.");
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
		//�ݱ� ��ư
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
					alert("���� ���� �� ���� ���� �߻� :: �ٽ� �ѹ� �õ����ּ���");
					return;
				}
				//����� time�� ��ġ�ϴ� button�� ã�� �Ұ��� ����
				$("#theModal").find("#meeting_time_table input[type=hidden]").each(
						function(){
								if(time==$(this).val()){
									$(this).parent().find("button").text("�Ұ�");
									$(this).parent().find("button").removeClass("btn-success");
									$(this).parent().find("button").addClass("btn-danger");
									$(this).parent().find("button").attr("disabled", true);
									alert("������ �Ϸ� �Ǿ����ϴ�.");
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
	<h2 style="color:#000000">���÷� ����</h2>
	<h4>��¥�� ���ó�¥���� +3�ϱ����� ������ �����մϴ�.</h4>
	<div id='calendar'></div>
</div>
	<div class="modal hide" id="theModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel1" aria-hidden="true" style="width:450px;">
 				<div class="re-modal-header">
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
 					<button class="btn btn-danger" data-dismiss="modal" id="btnModalClose">�ݱ�</button>
 				</div>
 				</div>
 			
 			<br/><br/>
 <script src="/resources/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>