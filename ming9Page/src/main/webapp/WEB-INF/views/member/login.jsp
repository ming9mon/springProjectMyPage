<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="">
	<meta name="author" content="">

	<title>SB Admin 2 - Login</title>

	<!-- Custom fonts for this template-->
	<link href="/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
	<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

	<!-- Custom styles for this template-->
	<link href="/resources/css/sb-admin-2.min.css" rel="stylesheet">

</head>
<!-- <body background="/resources/img/security.png" style="background-size: 100% 100%;"> -->
<body>
	<div class="container">
		<!-- Outer Row -->
		<div class="row justify-content-center">

			<div class="col-xl-10 col-lg-12 col-md-9">

				<div class="card o-hidden border-0 shadow-lg my-5">
					<div class="card-body p-0">
						<!-- Nested Row within Card Body -->
						<div class="row">
							<div class="col-lg-6 d-none d-lg-block" style="background-image: url('/resources/img/Anonymous.jpg'); background-size: 100% 100%;"></div>
							<div class="col-lg-6">
								<div class="p-5">
									<div class="text-center">
										<h1 class="h4 text-gray-900 mb-4">Welcome Back!</h1>
									</div>
									<form class="user" id="loginFrm" action="/member/loginCheck" method="post">
										<div class="form-group">
											<input type="text" class="form-control form-control-user" id="userId" name="userId" aria-describedby="emailHelp" placeholder="아이디 ">
										</div>
										<div class="mingError" id="userIdDiv" style="margin-bottom: 10px; font-color: red; display:none" >
											아이디를 입력해 주세요.
										</div>
										<div class="form-group">
											<input type="password" class="form-control form-control-user" id="passwd" name="passwd" placeholder="비밀번호">
										</div>
										<div class="mingError" id="passwdDiv" style="margin-bottom: 10px; font-color: red; display:none" >
											비밀번호를 입력해 주세요.
										</div>
										<div class="form-group">
											<div class="custom-control custom-checkbox small">
												<input type="checkbox" class="custom-control-input" id="customCheck">
												<label class="custom-control-label" for="customCheck">Remember Me</label>
											</div>
										</div>
										<a href="#" id="login" class="btn btn-primary btn-user btn-block">
											로그인
										</a>
										<hr>
										<a href="#" class="btn btn-google btn-user btn-block">
											<i class="fab fa-google fa-fw"></i> Login with Google
										</a>
										<a href="#" class="btn btn-facebook btn-user btn-block">
											<i class="fab fa-facebook-f fa-fw"></i> Login with Facebook
										</a>
									</form>
									<hr>
									<div class="text-center">
										<a class="small" href="forgot-password.html">Forgot Password?</a>
									</div>
									<div class="text-center">
										<a class="small" href="register.html">Create an Account!</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

			</div>
	
		</div>
	</div>
	
	<!-- 회원가입 확인 Modal-->
	<div class="modal fade" id="resultModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">회원가입</h5>
					<button class="close" type="button" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">X</span>
					</button>
				</div>
				<div class="modal-body"></div>
				<div class="modal-footer">
					<button class="btn" type="button" data-dismiss="modal">확인</button>
				</div>
			</div>
		</div>
	</div>

	<!-- Bootstrap core JavaScript-->
	<script src="/resources/vendor/jquery/jquery.min.js"></script>
	<script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script src="/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="/resources/js/sb-admin-2.min.js"></script>
	
	<!-- jQuery -->
	<script src="/resources/jQuery/jquery-3.4.1.min.js"></script>
	<!-- 
										
	 -->
	<script>
		$(document).ready(function(){
			
			function nullCheck(frm,size){
				
				var result=true;
				
				for(var i=0;i<size;i++){
					var inputId = frm[0][i].getAttribute('id');
					if($.trim($('#'+inputId+'').val()) == ''){
						$('#'+inputId+'Div').css('display','block');
						result=false;
					}else{

						$('#'+inputId+'Div').css('display','none');
					}
				}
				
				return result;
			}
			
			$('#login').click(function(e){
				
				var result = nullCheck($('#loginFrm'),$('#loginFrm').find('input').length-1);
				if(result){
					$.ajax({
						url: "${pageContext.request.contextPath}/member/loginCheck",
						type: "POST",
						dataType: "json",
						data: $("#loginFrm").serializeArray(),
						success: function(result){
							if(result){
								location.href="/";
							}else{
								alert("아이디 또는 패스워드가 틀렸습니다.");
							}
						},
						error: function(){
							alert("서버에러");
						}
					});
				}
			});
			
			//회원가입 결과 모달창 보여주기
			var result = '<c:out value="${result}"/>';
			
			modalCheck(result);
			
			function modalCheck(result){
				if(result == ''){
					return;
				}else{
					$(".modal-body").html("회원가입을 "+result+"하였습니다.");
					$('#resultModal').modal("show");
				}
			}
			
		});
		
		
	</script>

</body>
</html>