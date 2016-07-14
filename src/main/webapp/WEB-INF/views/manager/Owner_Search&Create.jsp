<!-- 
/*
 *  Description :  점장 생성 및 검색 페이지
 *  Created : 2016-06-29
 *  Author : 김준혁
 *  
 *  Revisions :
 */
 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="/resources/bootstrab/css/bootstrap.min.css" rel="stylesheet">
<!-- jQuery -->
<script src="/resources/bootstrab/js/jquery.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="/resources/bootstrab/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="http://www.prepbootstrap.com/Content/shieldui-lite/dist/css/light/all.min.css" />
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css"
	rel='stylesheet' type='text/css'>
</head>
<body>
<div class="container">
		<div class="row">
			<div class="col-lg-6" style="display: inline-block;">
				<div class="panel panel-default panel-table">
					<div class="panel-heading">
						<div class="row">
							<div class="col col-xs-6">
								<h3 class="panel-title">점장 검색</h3>
							</div>
						</div>
					</div>
					<div class="panel-body">
						<div id="Search-Owner-Form-Div" class="row col-md-offset-4">
							<form class="form-horizontal">
								<!-- Owner-Search -->
								<div class="form-group">
									<div class="col-sm-6 input-group">
										<input type="text" class="form-control" id="Input-Owner"
											placeholder="점장 검색"> <a
											class="btn btn-success input-group-addon"><em
											class="fa fa-search" aria-hidden="true"></em></a>
									</div>
								</div>
							</form>
						</div>
						<!-- Result Owner-Search -->
						<div>
							<div id="Result-Owner-Search-Div" class="row list-group""
								style="margin-left: 0px !important">
								<br/><hr/>
								<a href="#" class="list-group-item active">
									 <h4 id="Result-Owner-Name" class="list-group-item-heading">점장1</h4>
   									 <p id="Result-Owner-Email" class="list-group-item-text">test@co.kr</p>
								</a>
								<br />
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-lg-6" style="display: inline-block;">
				<div class="panel panel-default panel-table">
					<div class="panel-heading">
						<div class="row">
							<div class="col col-xs-6">
								<h3 class="panel-title">점장 생성</h3>
							</div>
						</div>
					</div>
					<div class="panel-body">
						<div class="row col-md-offset-2">
							<form class="form-horizontal">
								<!-- Email -->
								<div class="form-group">
									<label for="inputEmail3" class="col-sm-2 control-label">Email</label>
									<div class="col-sm-6">
										<input type="email" class="form-control" id="inputEmail3"
											placeholder="Email">
									</div>
								</div>
								<!-- Password -->
								<div class="form-group">
									<label for="inputPassword3" class="col-sm-2 control-label">Password</label>
									<div class="col-sm-6">
										<input type="password" class="form-control"
											id="inputPassword3" placeholder="Password">
									</div>
								</div>
								<!-- Password-Check -->
								<div class="form-group">
									<label for="inputPassword3" class="col-sm-2 control-label">Password-Check</label>
									<div class="col-sm-6">
										<input type="password" class="form-control"
											id="inputPassword3" placeholder="Password-Check">
									</div>
								</div>
								<!-- Name -->
								<div class="form-group">
									<label for="inputPassword3" class="col-sm-2 control-label">Name</label>
									<div class="col-sm-6">
										<input type="text" class="form-control" id="inputPassword3"
											placeholder="Name">
									</div>
								</div>
								<!-- Tel -->
								<div class="form-group">
									<label for="inputPassword3" class="col-sm-2 control-label">Tel</label>
									<div class="col-sm-6">
										<input type="text" class="form-control" id="inputPassword3"
											placeholder="010xxxxyyyy">
									</div>
								</div>
								<!-- Submit Btn -->
								<div class="form-group">
									<div class="col-sm-offset-2 col-sm-10">
										<button id="User-Log-In-Btn" type="button"
											class="btn btn-default">점장 생성</button>
										&nbsp;&nbsp;
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>