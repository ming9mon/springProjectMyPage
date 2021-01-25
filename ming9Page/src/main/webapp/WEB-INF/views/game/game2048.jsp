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
let gameMap;
const mapSize = 4;
let score = 0;
let played = true;

//화면 그리기
function drawMap(){
    var html="";
    for(var i=0;i<mapSize;i++){
        html+="<tr>";
        for(var j=0;j<mapSize;j++){
            if(gameMap[i][j]!=0) html+="<td>"+gameMap[i][j]+"</td>";
            else html+="<td></td>";
        }
        html+="</tr>";
    }
    $('#gameTbl').html(html);
}

//게임 초기화
function initMap(){
    gameMap = new Array(5);
    for(var i=0;i<mapSize;i++){
        gameMap[i] = new Array(5);
        for(var j=0;j<mapSize;j++) gameMap[i][j]=0;
    }
}

// 끝났는지 체크
function endCheck(){
    // 비어있는 칸이 있으면 return;
    for(var i=0;i<mapSize;i++){
        for(var j=0;j<mapSize;j++){
            if(gameMap[i][j] == 0){
                return;
            }
        }
    }
    
    for(var i=0;i<mapSize;i++){
        for(var j=0;j<mapSize-1;j++){
            if(gameMap[i][j] == gameMap[i][j+1]){   //가로 검사
                return;
            }
            if(gameMap[j][i] == gameMap[j+1][i]){   //세로 검사
                return;
            }
        }
    }

	played = false;
    saveScore(score);
    $('#startBtn').show();
    var txt = $('#score').text()+" Game End!";
    alert(txt);
}

// 방향에 따라 모으기
function pull(direction, moved){
    for(var k=0;k<mapSize-1;k++){
        if(direction == 'u' || direction == 'l'){
            for(var i=1;i<mapSize;i++){
                for(var j=0;j<mapSize;j++){
                    if(direction == 'u'){
                        if(gameMap[i-1][j]==0 && gameMap[i][j]!=0) {
                            moved=true;
                            gameMap[i-1][j] = gameMap[i][j];
                            gameMap[i][j] = 0;
                        }
                    }else{
                        if(gameMap[j][i-1]==0 && gameMap[j][i]!=0) {
                            moved=true;
                            gameMap[j][i-1] = gameMap[j][i];
                            gameMap[j][i] = 0;
                        }
                    }
                }
            }
        }
        else if(direction == 'd' || direction == 'r'){
            for(var i=mapSize-2;i>=0;i--){
                for(var j=0;j<mapSize;j++){
                    if(direction == 'd'){
                        if(gameMap[i+1][j]==0 && gameMap[i][j]!=0) {
                            moved=true;
                            gameMap[i+1][j] = gameMap[i][j];
                            gameMap[i][j] = 0;
                        }
                    }else{
                        if(gameMap[j][i+1]==0 && gameMap[j][i]!=0) {
                            moved=true;
                            gameMap[j][i+1] = gameMap[j][i];
                            gameMap[j][i] = 0;
                        }
                    } 
                }
            }
        }
    }
    
    return moved;
}

//숫자가 같으면 더하기
function sum(direction, moved){
    if(direction == 'u' || direction == 'l'){
        for(var i=1;i<mapSize;i++){
            for(var j=0;j<mapSize;j++){
                if(direction == 'u'){
                    if(gameMap[i-1][j]==gameMap[i][j] && gameMap[i][j]!=0) {
                        moved = true;
                        score += gameMap[i][j]*2;
                        gameMap[i-1][j] *= 2;
                        gameMap[i][j] = 0;
                        pull();
                    }
                }else{
                    if(gameMap[j][i-1]==gameMap[j][i] && gameMap[j][i]!=0) {
                        moved = true;
                        score += gameMap[j][i]*2;
                        gameMap[j][i-1] *= 2;
                        gameMap[j][i] = 0;
                        pull();
                    }
                }
            }
        }
    }else if(direction == 'd' || direction == 'r'){
        for(var i=mapSize-2;i>=0;i--){
            for(var j=0;j<mapSize;j++){
                if(direction == 'd'){
                    if(gameMap[i+1][j]==gameMap[i][j] && gameMap[i][j]!=0) {
                        moved = true;
                        score += gameMap[i][j]*2;
                        gameMap[i+1][j] *= 2;
                        gameMap[i][j] = 0;
                        pull();
                    }
                }else{
                    if(gameMap[j][i+1]==gameMap[j][i] && gameMap[j][i]!=0) {
                        moved = true;
                        score += gameMap[j][i]*2;
                        gameMap[j][i+1] *= 2;
                        gameMap[j][i] = 0;
                        pull();
                    }
                }
            }
        }
    }
    return moved;
}

// 방컁키 클릭
function move(direction){
	
	if(!played) return;

    var moved = false;
    
    moved = pull(direction,moved);
    moved = sum(direction,moved);
    moved = pull(direction,moved);
    
    if(moved) makeNum();
    drawMap();
    endCheck();
}

function drawScore(){
    $('#score').text(score+"점");
}

// 키 이벤트
$(document).keydown(function(e){
    var keyCode = e.keyCode;

    if(keyCode == 38 || keyCode == 87){          //위
        move("u");
    }else if(keyCode == 40 || keyCode == 83){    //아래
        move("d");
    }else if(keyCode == 37 || keyCode == 65){    //왼쪽
        move("l");
    }else if(keyCode == 39 || keyCode == 68){    //오른쪽
       move("r");
    }else return;
    
    drawScore();
});

// 랜덤 숫자 생성
function makeNum(){
    
    var num = Math.random()*7 < 5 ? 2 : 4;
    var i,j;
    do{
        i = Math.floor(Math.random()*mapSize);
        j = Math.floor(Math.random()*mapSize);
    }while(gameMap[i][j] != 0);
    gameMap[i][j]=num;
    drawMap();
}

// 랭킹 정보 가져오기
function getRank(){
	
	$.get({
		url : '${pageContext.request.contextPath}/game/getRank.do',
		data : {gameType : '2048'},
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

// 랭킹 정보 저장
function saveScore(score){
	var data = {
		usrIdx : '${sessionScope.loginDto.usrIdx}',
		score : score,
		gameType : '2048'
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
	init();
});

function init(){
	$('#startBtn').hide();
	played = true;
    score = 0;
	getRank();
    initMap();
    drawScore();
    makeNum();
    drawMap();
}

$(document).ready(function(){
    init();
});
</script>
</body>
</html>
