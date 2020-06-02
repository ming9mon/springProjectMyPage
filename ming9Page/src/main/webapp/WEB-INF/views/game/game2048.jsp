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
		#rankTbl td {width: 20px;height: 20px;text-align: center;font-size:10px;}
		#gameTbl td {width: 50px;height: 50px;}
		.test{
		  top:200px;
		  width:200px;
		  height:200px;
		  background-color:black;
		  animation-duration:900ms;
		}
		
		@-webkit-keyframes duration{
		  from{
		    left:100px;
		    background-color:#fff;
		  }
		  to{
		    left:300px;
		    background-color:#999;
		  }
		}
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
							<h6 class="m-0 font-weight-bold text-primary">2048 게임</h6>
						</div>
						
						<!-- Card Body -->
						<div class="card-body">
					  		<c:choose>
								<c:when test="${empty sessionScope.loginDto }">
									<h2>로그인을 하면 점수 자동 기록</h2>
								</c:when>
							</c:choose>
							조작법 : 키보드 ↑ ↓ ← → 또는 W S A D 또는 버튼 클릭
							<h5>점수 : <span id="score"></span></h5>
							<div>
								<button id="startBtn" type="button">게임 시작!</button>
							</div>
							<div>
								<div style="float:left">
									<table id="gameTbl" border=1>
									</table>
										<div class="test"></div>
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
							<div id="gameBtn" style="margin-top:230px;position:relative;">
								<button id="up" type="button" style="position:absolute;top:0px;left:40px;">△</button>
								<button id="down" type="button" style="position:absolute;top:60px;left:40px;">▽</button>
								<button id="left" type="button" style="position:absolute;top:30px;left:0px;">◁</button>
								<button id="right" type="button" style="position:absolute;top:30px;left:80px;">▷</button>
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
</body>
<script>
let played = false;
let gameMap = new Array();
let score = 0;

$('.test').click(function(){ 
    $(this).css('-webkit-animation-name','duration');
});

//키 이벤트
$(document).keydown(function(event){
	if(played){
		if(event.keyCode == 38 || event.keyCode == 87) //up
			move('u');
		else if(event.keyCode == 40 || event.keyCode == 83) //down
			move('d');
		else if(event.keyCode == 37 || event.keyCode == 65) //left
			move('l');
		else if(event.keyCode == 39 || event.keyCode == 68) //right
			move('r');
		else if(event.keyCode == 32)
			move('un');
	}
});

//버튼 이벤트
$('#gameBtn button').click(function(){
	if(played){
		if($(this).attr('id') == 'up') move('u');
		else if($(this).attr('id') == 'down') move('d');
		else if($(this).attr('id') == 'left') move('l');
		else if($(this).attr('id') == 'right') move('r');
	}
});

function move(direction){
	let start;
	let end;
	
	if(direction == 'u' && direction == 'l'){
		start = 0;
		end = 3;
	}else{
		start = 3;
		end = 1;
	}
	if(direction == 'u'){
		for(let i=0; i<3; i++){		//위로 올리기
			for(let j=0;j<4;j++){
				if(gameMap[i][j] == 0){
					for(let k=i+1;k<4;k++){	//0이 아닐 때 까지 찾아서 있으면 당기기
						if(gameMap[k][j] != 0){
							for(let l=k;l>=i;l++){
								gameMap[l][j] = gameMap[l-1][j];
								gameMap[l-1][j] = 0;
							}
						}
					}
				}
			}
		}
		for(let i=0; i<3; i++){		//합치기
			for(let j=0;j<4;j++){
				if(gameMap[i][j] == gameMap[i+1][j]){
					gameMap[i][j]*=2;
					gameMap[i+1][j]=0;
					
					for(let k=i;k<3;k++){
						gameMap[k][j] = gameMap[k+1][j];
						gameMap[k+1][j] = 0;
					}
				}
			}
		}
	}

	mkNum();
	drawMap();
}

//게임 맵 위에 숫자 생성
function mkNum(){
	let r = Math.floor(Math.random()*7);
	let n,x,y;
	if(r < 4) n = 2;
	else n = 4;
	
	while(true){
		x = Math.floor(Math.random()*4);
		y = Math.floor(Math.random()*4);
		console.log(x+" "+y);
		if(gameMap[x][y] == 0){
			gameMap[x][y] = n;
			break;
		}
	}
}

$('#startBtn').click(function(){
	score = 0;
	gameMapInit();
	$(this).hide();
	played = true;
	mkNum();
	drawMap();
});

function drawMap(){
	let html="";
	for(let i=0;i<4;i++){
		html+="<tr>";
		for(let j=0;j<4;j++){
			if (gameMap[i][j] != 0) html+="<td>"+gameMap[i][j]+"</td>";
			else html+="<td></td>";
		}
		html+="</tr>";
	}
	$('#gameTbl').empty();
	$('#gameTbl').append(html);
}

function gameMapInit(){
	gameMap = new Array();
	for(let i=0; i<4; i++){
		gameMap[i] = new Array();
		for(let j=0; j<4; j++){
			gameMap[i][j] = 0;
		}
	}
}

$(document).ready(function(){
	gameMapInit();
	drawMap();
});
</script>
</html>
