<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<!-- jstl -->
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>


<!DOCTYPE html>
<html>
<head>

	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<!-- <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"> -->
	<meta name="description" content="">
	<meta name="author" content="">

	<%@ include file="/WEB-INF/views/include/head.jsp" %>
	
	<style>
	    td{width:15px;height:15px;}
	    .n{background-color: dimgrey;}
	    .red{color: red;}
	    .green{color: green;}
	    #textArea{background:#FFE8E8; width:360px; height:120px;font-size:16px;color:black;margin-bottom: 10px;}
	    #textArea span{border: ridge;display:inline-block;width:90px;height:30px;text-align: center;font-size: 16px;}
	</style>
</head>
<body id="page-top">

<div id="bg"></div>
<div class="loading"><img src="/resources/img/common/gif_loading.gif" alt="로딩"></div>

	<!-- Page Wrapper -->
	<div id="wrapper">

		<!-- Sidebar -->
			<%@include file="/WEB-INF/views/include/sideBar.jsp" %>
		<!-- End of Sidebar -->

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">
				
				<!-- Topbar -->
				<%@include file="/WEB-INF/views/include/header.jsp" %>
				<!-- End of Topbar -->

				<!-- Begin Page Content 지도 -->
				<div class="container-fluid">
					<!-- Area Chart -->
					<div class="card shadow mb-4" style="min-width: 500px;min-height: 500px;">
						<!-- Card Header - Dropdown -->
						<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
							<h6 class="m-0 font-weight-bold text-primary">게슈탈트 붕괴 타자연습</h6>
						</div>
						
						<!-- Card Body -->
						<div class="card-body">
					  		<c:choose>
								<c:when test="${empty sessionScope.loginDto }">
									<h1>로그인 후 이용가능</h1><br>
									<h1>로그인 후 이용가능</h1><br>
									<h1>로그인 후 이용가능</h1>
								</c:when>
							</c:choose>
							<div id="gameDiv">
								<div style="float:left">
									입력창에 입력 후 엔터
									<div id="textArea">
								    </div>
								    <div>
								        <input type="text" id="in">
								    </div>
								    <div>
								        <span><button type="button" id="startBtn">시작</button></span>
								    </div>
								    <div>
								                        레벨 : <span id="lv">0</span>
								    </div>
								    <div>
								                        점수 : <span id="score">0</span>
								    </div>
								</div>
							    <div  style="float:right">
									<table id="rankTbl">
										<thead>
											<tr>
												<th colspan="3">랭킹</th>
											</tr>
										</thead>
										<tbody>
											
										</tbody>
									</table>
								</div>
							</div>
						</div><!-- Card Body -->
					</div>
				</div>
				<!-- /.container-fluid 지도-->
				
			</div>
			<!-- End of Main Content -->

		<!-- Footer -->
		<%@include file="/WEB-INF/views/include/footer.jsp" %>
		<!-- End of Footer -->

		</div>
		<!-- End of Content Wrapper -->

	</div>
	<!-- End of Page Wrapper -->

	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top">
		<i class="fas fa-angle-up"></i>
	</a>

<%@ include file="/WEB-INF/views/include/script.jsp" %>
<script type="text/javaScript" language="javascript">
var textArr = [
    "않되", "간고키부탁", "이따뵈요", '않되',
    "몯질", "몾질", "오랫만", '외글애',
    "퇴사", "월루", "원숭2", '외승모',
    "왜국어", "햬자네", "구밍구", '참숫가마',
    "볻물", "집가고십다", "잭스초코", '웬지',
    "왜갔집", "왜갓집", "맛춤법", '왠일이니',
    "왜갇집", "곧간", "소라곧옹", '어떻해', '어떻게',
    "바발이맨", "아랟이", "문재", '어의없다',
    "재택근무", "봉구집비어", "봉구스", '솟뚜껑',
    "곳감", "곧감", "바질악", '솢뚜껑',
    "든킨드나쓰", "스브웨이", "맞다시", '맛장구',
    "사용문이", "종갇집", "종갖집", '발암기억',
    "그게낳아", "그럼으로", "깎두기", '아메릭하노',
    "코로나", "깨끗히", "끼여들기", '받이사장',
    "야근", "꾿꾿히", "새무사", '곤뇽',
    "낢기다", "넓죽", "횅단보도", '가레떡',
    "도롱용", "까마기", "올곳다", '소사올라',
    "올곶다", "곳통", "머릿말", '돼지겁대기',
    "멋적다", "않히", "멎적다", '왜국인',
    '거희', "먿적다", '틀리', '도련변이',
    '외않해', '않되', '실허', '푸줃간',
    '곹홍', '성공율', '숫가락', '푸줒간',
    '휘리릭', '덜렁덜렁', '숮가락', '웨국인',
    '아뭏든', '아뭇튼', '장사않해', '갖히다',
    '맞다시', '어떻해요', '꼰머', '갇고싶다',
    '머머리', '머머리에오', '이게낳아', '넉우리',
    '외떼문에', '맛춤법곤부', '맛춤법곤부', '임심매매',
    '실어', '왜근', '맏춤법', '빨리낳아', '임신매매',
    '골아니', '산기슥', '바람물질', '딲새우', '횡하다',
    '문직이', '거짖말', '거짓불엉', '간폅', '엊박자', '수박겁탈기',
    '맛사지', '숩속', '압접시', '압잡이', '하숙우' ,'야왜취침',
    '샆질', '샆화', '숯채화', '명란잦코난', '명란젖', '오징어젖깔',
    '낙지젖깔', '슷하필드', '타코약히', '틀늬', '취긹얽렯짉', '젓소',
    '수밖', '참왜', '바잌흐', '마국간', '팔부채', '섣다', '섲다',
    '얼룩문희', '얼룩무니', '으사선생님', '늬앙스', '니앙스', '숔홀라',
    '왜지감자', '외지감자', '콤퓨타', '수퍼마켙', '발암막이', '직밖구리',
    '않부', '애기낫다', '역활', '문안하다', '설겆이', '개자번호', '괴자번호',
    '가오캥이', '골이따분', '권투를빈다', '일치얼짱', '부랄이던눈','왜승모'
];


var interval;
var lever = 1;
var time;
var score = 0;

function setEvt(){
    $('#in').keydown(function(e){

        if(e.keyCode == 13){
            var text = $('#in').val();
            $('#in').val('');

            $('#textArea span').each(function(idx,item){
                if($(this).text() == text){
                    $(this).remove();
                    score+=100;
                    return;
                }
            });
            
            $('#lv').text(level);
            $('#score').text(score);
        } 
     });
}

function fn_setInterval(){
    interval = setInterval(function(){
        if($('#textArea span').length >= 16) {
            clearInterval(interval);    //interval 끄기
            $('#in').unbind('keydown'); //이벤트 종료
            alert('죽었다 멍청아 ! ㅋ');
            saveScore(score);
            return;
        }
        
        var r = Math.floor(Math.random()*textArr.length);
        var html = "<span>"+textArr[r]+"</span>";
        $('#textArea').append(html);
        
        if(score < 1000) level = 1;
        else if(score < 2000) level = 2;
        else if(score < 3000) level = 3;
        else if(score < 4000) level = 4;
        else if(score < 5000) level = 5;
        else if(score < 6000) level = 6;
        else if(score < 7000) level = 7;
        else if(score < 8000) level = 8;
        else if(score < 9000) level = 9;
        else if(score < 10000) level = 10;
        else if(score < 11000) level = 11;
        else if(score < 12000) level = 12;
        else if(score < 13000) level = 13;
        else if(score < 14000) level = 14;
        else if(score < 15000) level = 15;
        else level = 16;
        
        time = 2200 - (level*100);
        
        clearInterval(interval);
        fn_setInterval();
        
    },  time);
}

function getRank(){
	
	$.get({
		url : '${pageContext.request.contextPath}/game/getRank.do',
		data : {gameType : 'typingGame'},
		success: function(data){
			$('#rankTbl tbody').text('');
			var html;
			for(var i=0;i<data.length;i++){
				html = '<tr>';
				html += '<td>'+(i+1)+'</td>';
				html += '<td style="width: 100%;">'+data[i].nickName+'</td>';
				html += '<td style="width: 100%;">'+data[i].score+'</td>';
				html += '</tr>';
				$('#rankTbl tbody').append(html);
			}
		},
		error: function(e){
			console.log(e);
		}
	});
}

function saveScore(score){
	var data = {
		usrIdx : '${sessionScope.loginDto.usrIdx}',
		score : score,
		gameType : 'typingGame'
	};
	$.get({
		url:'${pageContext.request.contextPath}/game/insertScore.do',
		data: data,
		success: function(rst){
			getRank();	//랭킹 정보
		},
		error: function(e){
			console.log(e);
		}
	});
}

$('#startBtn').click(function(){
    $('#in').unbind('keydown'); //이벤트 종료
    $('#textArea').empty(); //비우기
    clearInterval(interval);    //interval 끄기
    setEvt();
    score = 0;
    level = 1;

    $('#lv').text(level);
    $('#score').text(score);
    
    fn_setInterval();
    
});

$(document).ready(function(){
	getRank();
	
	if('${sessionScope.loginDto}' == '') $('#gameDiv').hide();
});
</script>
</body>
</html>
