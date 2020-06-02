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
		table{border: 4px solid #444444;}
		#gameTbl td {background-color:#c4c4c4;border: 2px solid #444444; width:20px;height:20px;}
		.a {background-color:#0ac6de !important;border: 2px solid #444444 !important;}
		.b {background-color:#ecda3c !important;border: 2px solid #444444 !important;}
		.c {background-color:#ff9800 !important;border: 2px solid #444444 !important;}
		.d {background-color:#71d200 !important;border: 2px solid #444444 !important;}
		.e {background-color:#deb887 !important;border: 2px solid #444444 !important;}
		.f {background-color:#ee3f00 !important;border: 2px solid #444444 !important;}
		.g {background-color:#9c27b0 !important;border: 2px solid #444444 !important;}
		#nextBlk {align:left;width:100px;height:300px;margin-left:10px;}
		#nextBlk div{width:100px;height:80px;background-color:#f6dede;margin-bottom:10px;border: 2px solid #000000;text-align:center;color: black;}
		#nextBlk table{border: 0px;margin: auto;margin-top:5px;}
		#nextBlk td{width:20px;height:20px;}
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
							<h6 class="m-0 font-weight-bold text-primary">테트리스</h6>
						</div>
						
						<!-- Card Body -->
						<div class="card-body">
					  		<c:choose>
								<c:when test="${empty sessionScope.loginDto }">
									<h2>로그인을 하면 점수 자동 기록</h2>
								</c:when>
							</c:choose>
							조작법 : 키보드 ↑ ↓ ← → 또는 W S A D - Space Bar는 아래로 뚝
							<br>점수 : <span id="score"></span>
							<div>
								<button id="startBtn" type="button">게임 시작!</button>
							</div>
							<div>
								<div style="float:left">
									<table id="gameTbl">
									</table>
								</div>
								<div style="float:left">
									<div id="nextBlk">
										<div></div>
										<div></div>
										<div></div>
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
const blockCnt = 7;	//블럭 종류 갯수
let nowBlk;
let nextBlks;
let map;
let score = 0;
let interval;
let time = 3000;
let played = false;
let line = 1;

//블록 생성
function mkBlk(){
	//1번 라인에 있으면 죽은거(0번 라인부터 시작)
	
	//블록 생성
	if(nowBlk == 0) {
		console.log(map[1][3]);
		if(map[1][3]=='' && map[1][4]=='' && map[1][5]=='' && map[1][6]==''){
			map[1][3]='a';
			map[1][4]='a';
			map[1][5]='a';
			map[1][6]='a';
		}
	}
}

$('#startBtn').click(function(e){

	nowBlk = nextBlks.shift();
	setNextBlock();
	
	played = true;
	$(this).hide();
	mkBlk();	//블록 생성
	interval = setInterval(function(){
		move('d');
	},3000);
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

//이동
function move(direction){
	let tr = $('#gameTbl tr');
	let tds = $('#gameTbl td');
	let td = $('#gameTbl tr:eq('+line+') td');
	
	//console.log(tds);
	
	if(direction == 'u'){
		
	}else if(direction == 's'){
		
	}else if(direction == 'l'){
		
	}else if(direction == 'd'){
		drawMap();
	}else if(direction == 'un'){	//스페이스바 클릭 바닥으로 바로 보내기
		
	}
	line--;
}

//다음 블럭
function setNextBlock(){
	next = Math.floor(Math.random()*blockCnt);
	var html;
	
	nextBlks.push(next);
	
	$($('#nextBlk div')[2]).html($($('#nextBlk div')[1]).html());
	$($('#nextBlk div')[1]).html($($('#nextBlk div')[0]).html());
	switch (next){
		case 0:
			html = "<table><tr><td class='a'></td><td class='a'></td><td class='a'></td><td class='a'></td><td class='a'></td></tr></table>";
			break;
		case 1:
			html = "<table><tr><td class='b'></td><td></td><td></td><td></td></tr>"
			+"<tr><td class='b'></td><td class='b'></td><td class='b'></td><td class='b'></td></tr></table>";
			break;
		case 2:
			html = "<table><tr><td></td><td></td><td></td><td class='c'></td></tr>"
				+"<tr><td class='c'></td><td class='c'></td><td class='c'></td><td class='c'></td></tr></table>";
			break;
		case 3:
			html = "<table><tr><td class='d'></td><td class='d'></td>"
				+"<tr><td class='d'></td><td class='d'></td></tr><table>";
			break;
		case 4:
			html = "<table><tr><td class='e'></td><td class='e'></td><td></td></tr>"
				+ "<td></td><td class='e'></td><td class='e'></td></tr></table>";
			break;
		case 5:
			html = "<table><tr><td></td><td class='f'></td><td class='f'></td></tr>"
				+ "<td class='f'></td><td class='f'></td><td></td></tr></table>";
			break;
		case 6:
			html = "<table><tr><td></td><td class='g'></td><td></td></tr>"
				+ "<td class='g'></td><td class='g'></td><td class='g'></td></tr></table>";
			break;
	}

	$($('#nextBlk div')[0]).html(html);
	$($('#nextBlk div')[2]).prepend("<span>다음 블럭</span>");
}

function mapSetting(){
	map = new Array();
	for(let i=0;i<21;i++){
		map[i] = new Array();
		for(let j=0;j<10;j++){
			map[i][j]='';
		}
	}
	console.log(map);
}

function drawMap(){
	//console.log($('#gameTbl').attr('class'));
	$('#gameTbl').html("");
	var html = "";
	
	for(var i=0;i<20;i++){
		html += "<tr>";
		for(var j=0;j<10;j++)
			html += "<td class='"+map[i+1][j]+"'></td>";
			//if (map[i+1][j]=='a') html += "<td></td>";
			//else if (map[i+1][j]=='a') html += "<td clas></td>"
		html += "</tr>";
	}
	
	$('#gameTbl').html(html);
}

function init(){
	nextBlks = new Array();
	mapSetting();
	drawMap();
	for(let i=0;i<3;i++) setNextBlock();
}

$(document).ready(function(){
	init();
});
</script>
</html>
