<!-- 
/*
 *  Description :  Main 페이지
 *  Created : 2016-06-25
 *  Author : 김준혁
 *  
 *  Revisions :
 *  1.WHEN & WHO : 2016-07-14 임두휘
 *  2.WHAT : Log_in 성공여부 Register
 */
 -->

<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

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
		
<style>
body {
	background-color: #18bc9c
}
</style>
<script>
var lat;
var lng;
var storeNoList = new Array();
var storeNameList = new Array();
var storeAddrList = new Array();
var final_distances = new Array();
var final_stores = new Array();
var arrayDistance = new Array();
var address = new Array();
var callBackCnt = 0;
	$(function(){
			if("${login_success}"=="true"){
				alert("로그인에 성공하였습니다.");
			}
			if("${register_success}"=="true"){
				alert("회원가입에 성공하였습니다.");
			}
			else if("${register_success}"=="false"){
				alert("회원가입에 실패하였습니다. 다시 시도해 주세요");
			}
			if("${store_dto}" == ""){
				//GPS 실행
				startGPS();
			}
	});
	//접속한 클라이언트의 위치 정보를 받고 가장 가까운 매장으로 연결해주는 함수
	function startGPS(){
		//geolocation을 지원하는 브라우저
		if(navigator.geolocation){
			navigator.geolocation.getCurrentPosition(success, fail);
			//클라이언트의 위치정보를 받아왔을 시
			function success(position){
				lat=position.coords["latitude"];
				lng=position.coords["longitude"];
			}
			//클라이언트의 위치정보를 받아올 수 없을 때
			function fail(err){
				switch (err.code){
					case err.PERMISSION_DENIED:
						msg = "GPS 사용자 거부";
						break;
				   case err.PERMISSION_UNAVAILABLE:
						msg = "지리정보를 얻을 수 없음";
				    	break;
				   case err.TIMEOUT:
				 	    msg = "GPS 시간초과";
				   		break;
				   case err.UNKNOWN_ERROR:
				        msg = "GPS 알 수 없는 오류 발생";
				        break;
			   }
			   alert(msg);
			   errorGPS();
			}
			function errorGPS(){
				return false;
			}
		}
		//브라우저가 geolocation을 지원하지 않음
		else{
			alert("위치 정보 확인을 지원하지 않는 브라우저 입니다.");
			//loaction.href="front?cmd=main";
		}
	}
		function initMap() {
			$.ajax({
				url:"/gps.storeList.store.manager",
				type:"post",
				dataType:"json",
				data:{isGPSgetStoreList:true},
				success:function(data){
					if(data.StoreAddrList.length != 0){
						for(var i=0; i<data.StoreAddrList.length; i++){
							var index = (decodeURI(data.StoreAddrList[i].store_addr + ' ').replace(/\+/g, ' ')).indexOf("(");
							var store_addr = (decodeURI(data.StoreAddrList[i].store_addr + ' ').replace(/\+/g, ' ')).substring(0, Number(index));
							storeNoList.push(data.StoreAddrList[i].store_no);
							storeNameList.push(decodeURI(data.StoreAddrList[i].store_name));
							storeAddrList.push(store_addr);
						}
						for(var j=0; j<storeAddrList.length; j++){
							//DB에서 받아온 매장 주소
							address.push(storeAddrList[j]);
						}
						var map = new google.maps.Map(document.getElementById('map'), {
						    zoom: 8,
						    center: {lat: -34.397, lng: 150.644}
						});
						
							var geocoder = new google.maps.Geocoder();
							$('#Geocode_submit').bind('click', function() {
								geocodeAddress(geocoder, map);
							});
							$('#Geocode_submit').trigger('click');
							
					}
					else{
						alert("불러올 매장이 없습니다..");
					}
				},
				error:function(){
					alert("매장 목록을 불러오는데 실패하였습니다.");
					return false;
				}
			});	
			}
		//GeoCoding, 주소를 위도,경도로 전환해주는 함수
		function geocodeAddress(geocoder, resultsMap) {
				//GeoCoding 시작
				geocoder.geocode({'address': address.shift()}, function(results, status) {
			    	//매장 주소를 위도 경도로 전환이 잘 되었을 시
					if (status === google.maps.GeocoderStatus.OK){
			      		resultsMap.setCenter(results[0].geometry.location);
			      		var marker = new google.maps.Marker({
				        	map: resultsMap,
				        	position: results[0].geometry.location
			      		});
			      		
				    	//매장의 위도 경도 저장
			      		var store_lat = marker.position.lat();
				    	var store_lng = marker.position.lng();
				    	//클라이언트 접속위치 위도 경도
				    	var client_lat = lat;
				    	var client_lng = lng;
				    	//거리 계산
				    	var final_lat = store_lat - client_lat;
				    	var final_lng = store_lng - client_lng;
				    	var final_distances = Math.sqrt(Math.pow(final_lat,2) + Math.pow(final_lng,2));
				    	//거리 계산 값 저장
				    	arrayDistance.push(final_distances);
				    	geocodeAddress(geocoder, resultsMap);
			    	} 
					//GeoCoding 중 에러
					else {
						callBack();
			    	}
			  });
		}
		//클라이언트와 매장의 거리계산 값을 비교하여 최소거리를 찾는 함수
		function callBack(){
			if("${store_dto}" == ""){
				var min_distance = arrayDistance[0];
				var index = 0;
				for(var i=1; i<arrayDistance.length; i++){
					if(arrayDistance[i] < min_distance){
					   	min_distance = arrayDistance[i];
					   	index = i;
					} 
				}
				//최소거리의 매장 번호
				var	final_store_no = storeNoList[index];
				$.ajax({
					url:"/gps.set_store.main",
					type:"post",
					dataType:"json",
					data:{store_no:final_store_no},
					success:function(data){
					}
				});
			}
		}
</script>
</head>
<body id="page-top" class="index">
	<!-- GPS -->
	<div id="floating-panel" style="display:none">
		<input id="Geocode_address" type="hidden" value="Sydney, NSW"> 
		<input id="Geocode_submit" type="hidden" value="Geocode">
	</div>
	<div id="map" hidden="hidden"></div>
	
	<!-- Header -->
	<jsp:include page="/WEB-INF/views/layout/Header.jsp" />
	<!-- Main-Content Field -->
	<header id="Main-Header" style="margin-bottom: 0px !important;">
		<div id="Main-Container" class="container">
			<div id="Main-Row" class="row">
				<div id="Main-Div" class="col-lg-12">
					<!-- First Main Page  -->
					<div id="Main-Content" class="intro-text div-fade">
						<span class="name">Start TryCoffee</span> <span class="skills">Order
							Use Online and Save your Time</span>
					</div>
				</div>
			</div>
		</div>
	</header>

	<!-- Footer -->
	<jsp:include page="/WEB-INF/views/layout/Footer.jsp" />
	<!-- Google GeoCoding JavaScript -->
	<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBuydEoBs8fFlyL6tDOb8sUNVu4hV82y9U&signed_in=true&callback=initMap"
	        async defer></script>
</body>
</html>