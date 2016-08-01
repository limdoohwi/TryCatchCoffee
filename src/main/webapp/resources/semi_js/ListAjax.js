function callList_Ajax(url, SuccessfunctionName, ErrorfunctionName, jsonData){
	  $.ajax({
		  url:url,
		  type:"post",
		  data:jsonData,
		  success:function(data){SuccessfunctionName(data)},
		  error:function(){ErrorfunctionName},
	  });
}
