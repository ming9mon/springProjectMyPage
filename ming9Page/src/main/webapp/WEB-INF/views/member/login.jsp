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
	<meta name = "google-signin-client_id"content = "161980541304-kii6sqj3rsk46pei121ag4b20i2ro46p.apps.googleusercontent.com">
	

	<title>ming9</title>

	<!-- Custom fonts for this template-->
	<link href="${pageContext.request.contextPath}/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
	<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

	<!-- Custom styles for this template-->
	<link href="${pageContext.request.contextPath}/resources/css/sb-admin-2.min.css" rel="stylesheet">
	
	<!-- common CSS -->
	<link href="${pageContext.request.contextPath}/resources/css/common.css" rel="stylesheet">
	
	<!-- jQuery -->
	<script src="${pageContext.request.contextPath}/resources/jQuery/jquery-3.4.1.min.js"></script>
	
	<!-- Bootstrap core JavaScript-->
	<script src="${pageContext.request.contextPath}/resources/vendor/jquery/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script src="${pageContext.request.contextPath}/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="${pageContext.request.contextPath}/resources/js/sb-admin-2.min.js"></script>
	
	<!-- 구글 로그인 버튼 커스텀 -->
	<link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet" type="text/css">
	<script src="https://apis.google.com/js/api:client.js"></script>
	<script>
	  var googleUser = {};
	  var id_token;
	  var startApp = function() {
	    gapi.load('auth2', function(){
	      // Retrieve the singleton for the GoogleAuth library and set up the client.
	      auth2 = gapi.auth2.init({
	    	client_id: '131755993986-uuhe4blnhc3a46adeh4rq1ic5gl2g3l4.apps.googleusercontent.com',	//로컬용
	    	//client_id: '131755993986-98lb6vl38c23oj9ofrej584o17amfqe6.apps.googleusercontent.com',	//운영서버용
	        cookiepolicy: 'single_host_origin',
	        // Request scopes in addition to 'profile' and 'email'
	        //scope: 'additional_scope'
	      });
	      attachSignin(document.getElementById('customBtn'));
	    });
	  };
	  
	  function attachSignin(element) {
	    auth2.attachClickHandler(element, {},
	        function(googleUser) {
	    		id_token = googleUser.getAuthResponse().id_token;
	    		
	    		var xhr = new XMLHttpRequest();
	    		xhr.open('POST', '${pageContext.request.contextPath}/member/googleLogin.do');
	    		xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	    		xhr.onload = function() {
	    			console.log(xhr.responseText);
	    		  if(xhr.responseText == "success") location.href="/";
	    		  else if(xhr.responseText == "new") $('#gSignUpModal').modal("show");
	    		  else	alert("로그인 실패");
	    		};
	    		xhr.send('idtoken=' + id_token);
	    		
	        }, function(error) {
	          console.log(JSON.stringify(error, undefined, 2));
	        });
	  }
	  
	  function googleSignUp(){
		  /* $.post({
			  url:"${pageContext.request.contextPath}/member/googleSignUp.do",
			  data:{
				  id_token : id_token,
				  nickName : nickName
			  },success:function(rst){
				  if(rst == "success") location.href="/";
				  else if(rst == "old") alert('뭐다용');
				  else if(rst == "fail") alert('회원가입 실패');
				  else alert('뭐야');
					  
			  },error:function(e){
				  alert('회원가입 실패');
			  }
		  }); */
		  
		/* $.post({
			url:"${pageContext.request.contextPath}/member/googleSignUp.do",
			data:{
				  id_token : id_token,
				  nickName : nickName
			},
			success:function(rst){
				console.log();
			},
			error:function(e){
				alert("글 작성 실패");
			}
		}); */
	}
  </script>
  <style type="text/css">
    #customBtn {
      text-align: center;
      display: inline-block;
      background: white;
      color: #444;
      width: 100%;
      border-radius: 5px;
      border: thin solid #888;
      box-shadow: 1px 1px 1px grey;
      white-space: nowrap;
      border-radius: 10rem;
    }
    #customBtn:hover {
      cursor: pointer;
    }
    span.label {
      font-family: serif;
      font-weight: normal;
    }
    span.icon {
      background: url('${pageContext.request.contextPath}/resources/img/googleImg.png') transparent 5px 50% no-repeat;
      display: inline-block;
      vertical-align: middle;
      width: 42px;
      height: 42px;
    }
    span.buttonText {
      display: inline-block;
      vertical-align: middle;
      padding-left: 42px;
      padding-right: 42px;
      font-size: 14px;
      font-weight: bold;
      /* Use the Roboto font that is loaded in the <head> */
      font-family: 'Roboto', sans-serif;
    }
  </style>
</head>
<!-- <body background="${pageContext.request.contextPath}/resources/img/security.png" style="background-size: 100% 100%;"> -->
<body>
<!-- 구글 닉네임 입력 Modal 창 -->
<div class="modal fade" id="gSignUpModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">회원가입</h5>
				<button class="close" type="button" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">X</span>
				</button>
			</div>
			<div class="modal-body">
				<span>닉네임을 입력하여 주세요 : </span>
				<input id="nickName" type="text">
				<div id="nickCk"></div>
			</div>
			<div class="modal-footer">
				<a class="btn" id="gSignUp" href="#">가입</a>
			</div>
		</div>
	</div>
</div>
	<div class="container">
		<!-- Outer Row -->
		<div class="row justify-content-center">

			<div class="col-xl-10 col-lg-12 col-md-9">

				<div class="card o-hidden border-0 shadow-lg my-5">
					<div class="card-body p-0">
						<!-- Nested Row within Card Body -->
						<div class="row">
							<div class="col-lg-6 d-none d-lg-block" style="background-image: url('${pageContext.request.contextPath}/resources/img/loginImg.png'); background-size: 100% 100%;"></div>
							<div class="col-lg-6">
								<div class="p-5">
									<div class="text-center">
										<h1 class="h4 text-gray-900 mb-4">Welcome Back!</h1>
									</div>
									<form class="user" id="loginFrm" action="/member/loginCheck" method="post">
										<input type="hidden" id="joinInfo" name="joinInfo" value="l"/>
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
										<div>
											<a href="#" id="login" class="btn btn-primary btn-user btn-align">
												로그인
											</a>
											<a href="#" id="signUp" class="btn btn-primary btn-user btn-align">
												회원가입
											</a>
										</div>
										<hr>
										<div id="gSignInWrapper">
										    <div id="customBtn" class="customGPlusSignIn">
										      <span class="icon"></span>
										      <span class="buttonText">Google Login</span>
										    </div>
										</div>
										<!-- <a href="#" class="btn btn-facebook btn-user btn-block">
											<i class="fab fa-facebook-f fa-fw"></i> Login with Facebook
										</a> -->
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

<script src="https://apis.google.com/js/platform.js" async defer></script>
<script>
startApp();

$(document).keydown(function(key) {
    //키의 코드가 13번일 경우 (13번은 엔터키)
    if (key.keyCode == 13) {
    	fn_login();
    }
});


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
	fn_login();
});

function fn_login(){
	var result = nullCheck($('#loginFrm'),$('#loginFrm').find('input').length-1);
	if(result){
		$.ajax({
			url: "${pageContext.request.contextPath}/member/loginCheck.do",
			type: "POST",
			dataType: "json",
			data: $("#loginFrm").serializeArray(),
			success: function(result){
				if(result){
					location.href="${pageconText.request.ContextPath}/";
				}else{
					alert("아이디 또는 패스워드가 틀렸습니다.");
				}
			},
			error: function(){
				alert("서버에러");
			}
		});
	}
}

$('#signUp').click(function(){
	location.href="${pageContext.request.contextPath}/member/signUpPage.do";
});

	$(document).ready(function(){
		
		//회원가입 결과 모달창 보여주기
		var result = '${result}';
		
		modalCheck(result);
		
		function modalCheck(result){
			if(result == ""){
				return;
			}else{
				$('.modal-body').html("회원가입을 "+result+"하였습니다.");
				$('#resultModal').modal("show");
			}
		}
		
	});
	
	startApp();
	

	
	//닉네임 중복 검사
	var ck = false;
	$('#nickName').keydown(function(){
		var nickRegExp = RegExp(/^[A-Za-z0-9_\-가-힣]{1,10}$/);
		$.post({
			url:"${pageContext.request.contextPath}/member/nickNmCheck.do",
			data:{
				nickNm : $('#nickName').val().trim()
			},success:function(rst){
				if(rst == 0){
					if(nickRegExp.test($('#nickName').val())){
						ck = true;
						$('#nickCk').text('사용 가능한 닉네임 입니다.');
						$('#nickCk').css('color','green');
					}else rst=1;
				}
				if(rst > 0){
					ck = false;
					$('#nickCk').text('사용 불가가능한 닉네임 입니다.');
					$('#nickCk').css('color','red');
				}
			},error:function(e){
				alert('회원가입 실패');
			}
		});
	});
	
	//구글 가입 눌렀을 때
	$('#gSignUp').click(function(){
		if(ck){
			var nickName = $('#nickName').val().trim();
			$.post({
				url:"${pageContext.request.contextPath}/member/googleSignUp.do",
				data:{
					id_token : id_token,
					nickName : nickName
				},success:function(rst){
					if(rst == "success") location.href="/";
					else if(rst == "old") alert('뭐다용');
					else if(rst == "fail") alert('회원가입 실패');
					else alert('뭐야');
				},error:function(e){
					alert('회원가입 실패');
				}
			});
		}else{
			alert('사용 불가능한 닉네임 입니다.');
		}
	});
</script>
</body>
</html>