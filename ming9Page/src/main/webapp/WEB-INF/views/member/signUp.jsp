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

  <!-- jQuery -->
  <script src="/resources/jQuery/jquery-3.4.1.min.js"></script>

  <!-- Custom styles for this template-->
  <link href="/resources/css/sb-admin-2.min.css" rel="stylesheet">
  <!-- 회원가입 페이지 css -->
  <link href="/resources/css/signUp.css" rel="stylesheet">
  
   <!-- Bootstrap core JavaScript-->
  <script src="/resources/vendor/jquery/jquery.min.js"></script>
  <script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="/resources/js/sb-admin-2.min.js"></script>
  
  

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
              <form id="signUpFrm" action="signUp" method="post" class="user" style="margin-left: auto">
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
                    <input type="password" class="form-control form-control-user" id="passwd2" name="passwd2" placeholder="패스워드 확인">
                  </div>
                </div>
                <div class="form-group msgMargin" style="display:none"  id="passwd2_msg">
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
                    <b>휴대폰 번호 * </b>
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
                <div class="form-group msgMargin" style="display:none"  id="email_msg" >
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
  
  <!-- 회원가입 확인 Modal-->
	<div class="modal fade" id="signUpModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">회원가입</h5>
					<button class="close" type="button" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">X</span>
					</button>
				</div>
				<div class="modal-body">회원가입 하시겠습니까?</div>
				<div class="modal-footer">
					<a class="btn" id="modalY" href="#">예</a>
					<button class="btn" type="button" data-dismiss="modal">아니요</button>
				</div>
			</div>
		</div>
	</div>

 
  <script type="text/javascript">

	//제대로 입력했는지 확인하기 위한 flag
	var check = true;

	//유효성 검사하기 위한 정규표현식
  	var userIdCheck = RegExp(/^[A-Za-z0-9_\-]{5,20}$/);
  	var passwdCheck = RegExp(/^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^*()\-_=+\\\|\[\]{};:\'",.<>\/?]).{8,16}$/);
    var nameCheck = RegExp(/^[가-힣]{2,6}$/);
    var nickNameCheck = RegExp(/^[가-힣a-zA-Z0-9]{2,10}$/);
  	var emailCheck = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);
  	var birthdayCheck = RegExp(/^(19|20)[0-9]{2}(0[1-9]|1[1-2])(0[1-9]|[1-2][0-9]|3[0-1])$/);
  	var phonNumberCheck = RegExp(/^01[0179][0-9]{7,8}/);

  
  	//널 체크
    function nullCheck(data,flag){
		if($.trim(data.value) == ""){
			$('#'+data.name).addClass('borderRed');
			$('#'+data.name+'_msg').attr('style','display: block');
			$('#'+data.name+'_msg').html('<span style="color: red">필수 입력 정보입니다.</span>');
			check=false;
		}else{
			$('#'+data.name+'_msg').attr('style','display: none');
			$('#'+data.name).removeClass('borderRed');
		}
	}
  	
  	//유효성 검사
  	function validityCheck(data,msg,flag){
   		if(!eval(data+"Check").test($('#'+data).val())){
			$('#'+data+'_msg').html('<span style="color: red">'+msg+'</span>');
   			$('#'+data+'_msg').attr('style','display: block');
   			$('#'+data).removeClass('borderGreen');
   			$('#'+data).addClass('borderRed');
   			check=false;
   		}else{
   			$('#'+data+'_msg').attr('style','display: none');
   			$('#'+data).removeClass('borerRed');
   			$('#'+data).addClass('borderGreen');
   		}
  	}
  
    $(document).ready(function(){

    	//회원가입 버튼 눌렀을 때   	
    	$('#signUp').click(function(e){
    		//이벤트 취소
    		e.preventDefault();
			
    		check=true;
    		
    	  	//널체크
    		var frmData = $('#signUpFrm').serializeArray();
    		var size=frmData.length;
        	for(var i=0;i<size;i++){
        		nullCheck(frmData[i]);
        	}
        	if(check==false){
        		alert("필수 항목을 모두 입력해 주세요.");
        		return;
        	}
        	
        	//다시 유효성 검사
        	var dataArr = ["userId","passwd","name","nickName","birthday","phonNumber","email"];
        	for(var i=0;i<dataArr.length;i++){
        		validityCheck(dataArr[i],"올바르게 입력해 주세요.");
        		if(check==false){
        			$('#'+dataArr[i]).focus();
        			return;
        		}
        	}
        	
        	//check 결과값이 true면 modal창 띄우기
        	if(check){
        		$('#signUpModal').modal("show");
        	}
    	});
    	
    	//모달창 예를 눌렀을 때
    	$('#modalY').click(function(e){
			e.preventDefault();
			$('#signUpFrm').submit();
		});
    	
    	//키보드 눌렀을 때
    	$('#phonNumber').keyup(function(e){
    		//숫자가 아니면 지우기
    		if (!(e.keyCode >=37 && e.keyCode<=40)) {
    			$('#phonNumber').val($('#phonNumber').val().replace(/[^0-9]/gi,''));
    		}
    	});
    	
    	//포커스 아웃
    	$('#userId').blur(function(){
    		//id 중복 체크
    		$.ajax({
    			url: "${pageContext.request.contextPath}/member/idCheck",
    			method: "GET",
    			dataType: "json",
    			data:{
    				"userId": $('#userId').val()
    			},
    			success:function(result){
    				// 0보다 크면 중복된 아이디가 있는 것
    				if(result){
    					check=false;
    					$('#userId_msg').attr('style','display: block');
    					$('#userId_msg').html('<span style="color: red">이미 사용중인 아이디 입니다.</span>');
    					$('#userId').addClass('borderRed');
    					$('#userId').removeClass('borderGreen');
    					return;
    				}
    			},
    			error:function(){
    				alert('serverError');
    			}
    		});	
    		
    		//아이디 유효성 검사
    		var msg="5~20글자의 숫자 또는 영문, 특수문자는( _ , - )만 사용 가능합니다.";
    		validityCheck("userId",msg);
    	});
    	
    	$('#passwd').blur(function(){
    		//패스워드 유효성 검사
    		var msg="8~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.";
    		validityCheck("passwd",msg);
    	});
    	$('#passwd2').blur(function(){
    		if($('#passwd').val() != $('#passwd2').val() ){
    			$('#passwd2_msg').html('<span style="color: red">패스워드가 다릅니다.</span>');
    			$('#passwd2_msg').attr('style','display: block');
    			$('#passwd2').val('');
    			$('#passwd2').addClass('borderRed');
    			check=false;
    		}else{
    			$('#passwd2_msg').attr('style','display: none');
    			$('#passwd2').addClass('borderGreen');
    		}
    	});
    	$('#name').blur(function(){
    		var msg="2~6자 한글만 가능합니다.";
    		validityCheck("name",msg);
    	});
    	$('#nickName').blur(function(){
    		var msg="2~6자 한글, 영어, 숫자만 입력 가능합니다.";
    		validityCheck("nickName",msg);
    	});
    	$('#birthday').blur(function(){
    		var msg="생년 월 일을 입력해 주세요. ex)19990102";
    		validityCheck("birthday",msg);
    	});
    	$('#phonNumber').blur(function(){
    		var msg="핸드폰 번호를 확인해 주세요.";
    		validityCheck("phonNumber",msg);
    	});
    	$('#email').blur(function(){
    		var msg="이메일 주소를 올바르게 입력해 주세요.";
    		validityCheck("email",msg);
    	});
    	
    	
    	
    });
  </script>
</body>
