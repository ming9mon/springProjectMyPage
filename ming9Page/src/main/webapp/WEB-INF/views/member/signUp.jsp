<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- jstl -->
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>SB Admin 2 - Dashboard</title>

	
  <!-- 부트스트랩 -->
  <!-- <link href="/resources/bootstrap/css/bootstrap.css" rel="stylesheet">
  <link href="/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
 -->
  <!-- Custom fonts for this template-->
  <link href="/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="/resources/css/sb-admin-2.min.css" rel="stylesheet">
  <!-- 회원가입 페이지 css -->
  <link href="/resources/css/signUp.css" rel="stylesheet">
  
  
  
  <!-- jQuery -->
  <script src="/resources/jQuery/jquery-3.4.1.min.js"></script>

</head>
<style>
select {
width: 200px;
padding: .8em .5em;
border: 1px solid #999;
font-family: inherit;
background: url('/resources/img/arrow.jpg') no-repeat 95% 50%;
border-radius: 0px;
-webkit-appearance: none;
-moz-appearance: none;
appearance: none;
}

select::-ms-expand {
    display: none;
}


</style>


<body class="bg-gradient-primary">

  <div class="container">

    <div class="card o-hidden border-0 shadow-lg my-5">
      <div class="card-body p-0">
        <!-- Nested Row within Card Body -->
        <div class="row">
          <div class="col-lg-12">
            <div class="p-5">
              <div class="text-center">
                <h1 class="h4 text-gray-900 mb-4">회원가입</h1>
              </div>
              <form id="signUpFrm" class="user" style="margin-left: auto">
                <div class="form-group row">
                  <div class="col-sm-2 mb-3 mb-sm-0" align="center" style="margin-top: 12px;">
                    <b>아이디 * </b>
                  </div>
                  <div class="col-sm-6">
                    <input type="text" class="form-control form-control-user" id="userId" name="userId" placeholder="숫자 또는 영문, 특수문자는( _ , - )만 사용 가능합니다">
                  </div>
                </div>
                <div class="form-group msgMargin" style="display:none"  id="userId_msg">
                </div>
                <div class="form-group row">
                  <div class="col-sm-2 mb-3 mb-sm-0" align="center" style="margin-top: 12px">
                    <b>패스워드 * </b>
                  </div>
                  <div class="col-sm-6">
                    <input type="password" class="form-control form-control-user" id="passwd" name="passwd" placeholder="패스워드 ">
                  </div>
                </div>
                <div class="form-group msgMargin" style="display:none"  id="passwd_msg">
                </div>
                <div class="form-group row">
                  <div class="col-sm-2 mb-3 mb-sm-0" align="center" style="margin-top: 12px">
                    <b>패스워드 확인 * </b>
                  </div>
                  <div class="col-sm-6">
                    <input type="password" class="form-control form-control-user" id="passwdCheck" name="passwdCheck" placeholder="패스워드 확인">
                  </div>
                </div>
                <div class="form-group msgMargin" style="display:none"  id="passwdCheck_msg">
                </div>
                <div class="form-group row">
                  <div class="col-sm-2 mb-3 mb-sm-0" align="center" style="margin-top: 12px">
                    <b>이름 * </b>
                  </div>
                  <div class="col-sm-6">
                    <input type="text" class="form-control form-control-user" id="name" name="name" placeholder="이름">
                  </div>
                </div>
                <div class="form-group msgMargin" style="display:none"  id="name_msg">
                </div>
                <div class="form-group row">
                  <div class="col-sm-2 mb-3 mb-sm-0" align="center" style="margin-top: 12px">
                    <b>닉네임 * </b>
                  </div>
                  <div class="col-sm-6">
                    <input type="text" class="form-control form-control-user" id="nickName" name="nickName" placeholder="닉네임">
                  </div>
                </div>
                <div class="form-group msgMargin" style="display:none"  id="nickName_msg">
                </div>
                <div class="form-group row">
                  <div class="col-sm-2 mb-3 mb-sm-0" align="center" style="margin-top: 12px">
                    <b>성별 * </b>
                  </div>
                  <div class="col-sm-6">
                    <select class="selectpicker" id="sex" name="sex">
                      <option value="" selected>-- 선택 --</option> 
                        <option value="m">남성</option>
                        <option value="f">여성</option>
                    </select>
                  </div>
                </div>
                <div class="form-group msgMargin" style="display:none"  id="sex_msg">
                </div>
                <div class="form-group row ">
                  <div class="col-sm-2 mb-3 mb-sm-0" align="center" style="margin-top: 12px">
                    <b>생년월일 * </b>
                  </div>
                  <div class="col-sm-6">
                    <input type="text" class="form-control form-control-user" id="birthday" name="birthday" placeholder="생년월일 ex)19990215">
                  </div>
                </div>
                <div class="form-group msgMargin" style="display:none"  id="birthday_msg">
                </div>
                <div class="form-group row">
                  <div class="col-sm-2 mb-3 mb-sm-0" align="center" style="margin-top: 12px">
                    <b>전화번호 * </b>
                  </div>
                  <div class="col-sm-6">
                    <input type="text" class="form-control form-control-user" id="phonNumber" name="phonNumber" placeholder="핸드폰 번호 ex) 01012345678">
                  </div>
                </div>
                <div class="form-group msgMargin" style="display:none"  id="phonNumber_msg">
                </div>
                <div class="form-group row">
                  <div class="col-sm-2 mb-3 mb-sm-0" align="center" style="margin-top: 12px">
                    <b>이메일 * </b>
                  </div>
                  <div class="col-sm-6">
                    <input type="text" class="form-control form-control-user" id="email" name="email" placeholder="이메일 (비밀번호 분실시 사용)">
                  </div>
                </div>
                <div class="form-group msgMargin" style="display:none"  id="email_msg">
                </div>
                <div class="form-group row" align="right">
                <div class="col-sm-2 marginAuto" >
                  <a href="" id="signUp" class="btn btn-primary btn-user btn-block">
                               회원가입
                  </a>
                </div>
                </div>
                <hr>
                <div class="form-group row" align="right">
                <div class="col-sm-3 marginAuto">
                  <a href="index.html" class="btn btn-google btn-user btn-block">
                    <i class="fab fa-google fa-fw"></i> Register with Google
                  </a>
                  <a href="index.html" class="btn btn-facebook btn-user btn-block">
                    <i class="fab fa-facebook-f fa-fw"></i> Register with Facebook
                  </a>
                </div>
                </div>
                <div class="col-sm-3 marginAuto" >
                </div>
                
              </form>
              <hr>
              <div class="text-center">
                <a class="small" href="forgot-password.html">Forgot Password?</a>
              </div>
              <div class="text-center">
                <a class="small" href="login.html">Already have an account? Login!</a>
              </div>
            </div>
          </div>
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
  <script type="text/javascript">
  
    //var idCheck="";
    //var emailCheck="RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);";
    
  
  	//널 체크
    function nullCheck(data){
		if(data.value == ""){
			$('#'+data.name).addClass('borderRed');
			$('#'+data.name+'_msg').attr('style','display: block');
			$('#'+data.name+'_msg').html('<span style="color: red">필수 입력 정보입니다.</span>');
		}else{
			$('#'+data.name).removeClass('borderRed');
		}
	}
  
    $(document).ready(function(){

        var emailCheck="RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);";
    	//회원가입 버튼 눌렀을 때
    	$('#signUp').click(function(e){
    		e.preventDefault();
    		
    		var size=$('#signUpFrm')[0].length;
        	for(var i=0;i<size;i++){
        		nullCheck($('#signUpFrm').serializeArray()[i]);
        	}
    	});
    	
    	//포커스 아웃
    	$('#email').blur(function(){
    		if(emailCheck.test('aa')){
    			console.log("aa");
    		}else{
    			console.log('bb');
    		}
    	});
    	
    	
    	
    });
  </script>
</body>
