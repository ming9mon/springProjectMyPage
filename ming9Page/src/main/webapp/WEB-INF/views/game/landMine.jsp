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
		td{width:25px;height:25px;}
		.n{background-color: #757575;}
		.mine{background-image: url(/resources/img/gameImg/landMine.png);background-size: cover;}
		.flag{background-image: url(/resources/img/gameImg/flag.png);background-size: cover;}
		.qmark{background-image: url(/resources/img/gameImg/qMark.png);background-size: cover;}
		.rankTbl{font-size: 12px;}
	</style>
</head>
<body oncontextmenu='return false' id="page-top">

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
							<h6 class="m-0 font-weight-bold text-primary">지뢰 찾기</h6>
						</div>
						
						<!-- Card Body -->
						<div class="card-body">
					  		<c:choose>
								<c:when test="${empty sessionScope.loginDto }">
									<h2>로그인을 하면 점수 자동 기록</h2>
								</c:when>
							</c:choose>
							조작법 : 키보드 ↑ ↓ ← → 또는 버튼 클릭 (버튼 클릭 시 반응 느림)
							<div>
								<div style="float:left">
									<div>
										<span>사이즈 : </span><input type="text" id="size">
									</div>
									<div>
										<span>폭탄 갯수 : </span><input type="text" id="landMineCnt">
									</div>
									<div>
										<button type="button" id="start">시작</button>
									</div>
									<div>
										<h3 id="msg"></h1>
									</div>
									<div>
										<h3>플레이 시간 : <span id="tme">00:00:00</span></h3>
									</div>
									<div>
										<span>
											min size = 5;<br>
											max size = 20;<br>
											min landMine = size;<br>
											max landSize = size*size-(size*2)</span>
									</div>
		
									<div>
										<table id="tbl" border=1></table>
									</div>
								</div>
								<div  style="float:right">
									<table id="rankTbl" style="font-size: 12px;">
										<thead>
											<tr>
												<th colspan="5">랭킹</th>
											</tr>
											<tr>
												<th>순위</th>
												<th>닉네임</th>
												<th>지뢰</th>
												<th>사이즈</th>
												<th>플레이시간</th>
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
</body>
<script>
const numCkReg = RegExp(/[^0-9]$/);
var map;
let first = true;
var mineCnt;	//지뢰 갯수
var size;	   //맵 가로 세로 크기
var tme;		//시간
var interval;   //시간 interval

//지뢰 생성
function makeLandMine(x, y){
	for(var i=0;i<mineCnt;i++){
		var mx = Math.floor(Math.random()*size);
		var my = Math.floor(Math.random()*size);

		if(mx == x && my == y) {
			i--;
			continue;
		}
		
		if(!map[mx][my]) map[mx][my]='mine';
		else i--;
	}
}

// 주변에 지뢰가 존재하는지 체크
function mineExistCheck(x, y){
	if(x >= 0 && y >= 0 && x < size && y < size){
		if(map[x][y] == 'mine') return true;
	}
	return false;
}

// 지뢰 근처 숫자 생성
function makeNum(){
	for(var i=0;i<size;i++){
		for(var j=0;j<size;j++){
			var cnt = 0;
			if(map[i][j] != 'mine') {
				if(mineExistCheck(i-1,j-1)) cnt++;
				if(mineExistCheck(i-1,j)) cnt++;
				if(mineExistCheck(i-1,j+1)) cnt++;
				if(mineExistCheck(i,j-1)) cnt++;
				if(mineExistCheck(i,j+1)) cnt++;
				if(mineExistCheck(i+1,j-1)) cnt++;
				if(mineExistCheck(i+1,j)) cnt++;
				if(mineExistCheck(i+1,j+1)) cnt++;
				map[i][j]=cnt;
			}
		}
	}
}

//x y 체크
function existCheck(x, y){
	if(x >= 0 && y >= 0 && x < size && y < size)
	   if(map[x][y] != 'mine')
		  return true;
	return false;
}

// 클릭 한 곳 기준으로 가려진거 풀기
function delMarker(x,y){
	
	var n = size*x+y;
	var td = $('#tbl td')[n];
	
	if(!$(td).hasClass('n')) return;
	
	$(td).removeClass('n');
	if(map[x][y] != 0) $(td).text(map[x][y]);
	else{
		if(existCheck(x-1,y-1)) delMarker(x-1,y-1);
		if(existCheck(x-1,y)) delMarker(x-1,y);
		if(existCheck(x-1,y+1)) delMarker(x-1,y+1);
		if(existCheck(x,y-1)) delMarker(x,y-1);
		if(existCheck(x,y+1)) delMarker(x,y+1);
		if(existCheck(x+1,y-1)) delMarker(x+1,y-1);
		if(existCheck(x+1,y)) delMarker(x+1,y);
		if(existCheck(x+1,y+1)) delMarker(x+1,y+1);
	}
	
}

// 클리어 체크
function clearCk(){
	var markCnt = $('#tbl .n').length;
	var flagCnt = $('#tbl .flag').length;
	
	if(markCnt != 0) return;
	if(flagCnt != mineCnt) return;
	
	alert('Clear!!!');
	if('${sessionScope.loginDto.usrIdx}' != '') saveScore();
	
	clearInterval(interval);
}

//좌 클릭
function leftClick(x, y){
	if(first) {
		makeLandMine(x, y);	 // 지뢰 생성
		makeNum();			  // 지뢰 근처 숫자 생성
	}
	
	var n = size*x+y;
	var td = $('#tbl td')[n];

	// 해당 태그가 flag이면 클릭 못하도록 리턴
	if($(td).hasClass('flag')) return;
	
	if(map[x][y] == 'mine') {
		alert('DIE !');
		evtOff();
		$(td).attr('class','mine');
		
		clearInterval(interval);
		
		//전체 맵 보여주기
		var html = "";
		for(var i=0;i<size;i++){
			html+="<tr>";
			for(var j=0;j<size;j++){
				for(var j=0;j<size;j++){
					if (map[i][j] == 0 ) html += "<td></td>";
					else if (map[i][j] == 'mine' ) html += "<td class='mine'></td>";
					else html += "<td>"+map[i][j]+"</td>";
				}
			}
			html+="</tr>";
		}
		$('#tbl').html(html);
	}
	else delMarker(x, y);
	
	//끝났는지 체크
	clearCk();
}

// 우클릭
function rightClick(x,y){
	var n = size*x+y;
	var td = $('#tbl td')[n];
	
	if($(td).hasClass('n')) {
		console.log('abcd');
		$(td).removeClass('n');
		$(td).addClass('flag');
	}else if($(td).hasClass('flag')) {
		$(td).removeClass('flag');
		$(td).addClass('qmark');
	}else if($(td).hasClass('qmark')) {
		$(td).removeClass('qmark');
		$(td).addClass('n');
	}
	clearCk(); //끝났는지 체크
}

//테이블 클릭 이벤트
$(document).on('mouseup','#tbl td',function(e){
	if($(this).hasClass('n'))
		$(this).css('background-color','');
	
	var x = $(this).parent().parent().children().index($(this).parent())/2;
	var y = $(this).parent().children().index($(this));
	
	if(e.which == 1){   //좌클릭
		leftClick(x,y);
		first = false;
	}else if(e.which == 3){ //우클릭
		rightClick(x,y);
	}else{
		console.log(e.which);
	}
});

//마우스 다운 시 색상 변경
$(document).on('mousedown','#tbl td',function(e){
	if($(this).hasClass('n'))
		$(this).css('background-color','#CCCCCC');
});

// 마우스 오버 시 색상 변경
$(document).on('mouseover','#tbl td',function(e){
	if($(this).hasClass('n'))
		$(this).css('background-color','rgba(105, 105, 105, 0.66)');
});

// 포커스 아웃 색상 변경
$(document).on('mouseout','#tbl td',function(e){
	if($(this).hasClass('n'))
		$(this).css('background-color','');
});

function evtOn(){
	$('#tbl td').on('mouseup');	 // 테이블 클릭 이벤트
	$('#tbl td').on('mousedown');   //마우스 다운 시 색상 변경
	$('#tbl td').on('mouseover');   // 마우스 오버 시 색상 변경
	$('#tbl td').on('mouseout');	// 포커스 아웃 색상 변경
}

function evtOff(){
	$('#tbl td').off('mouseup');	// 테이블 클릭 이벤트
	$('#tbl td').off('mousedown');  //마우스 다운 시 색상 변경
	$('#tbl td').off('mouseover');  // 마우스 오버 시 색상 변경
	$('#tbl td').off('mouseout');   // 포커스 아웃 색상 변경
}

// 맵 그리기
function drawMap(){
	var size = $('#size').val();
	var html="";
	map = new Array();
	
	for(var i=0;i<size;i++){
		map[i] = new Array();
		html += "<tr>";
		for(var j=0;j<size;j++){
			html += "<td class='n'></td>";
		}
		html += "<tr>";
	}
	$('#tbl').html(html);
}

//숫자인지 체크 후 아니면 replace
function numCk(tag){
	if(numCkReg.test(tag.val())){
		tag.val(tag.val().replace(/[^0-9]$/gi,''));
	}
}

//유효성 검사
function valueCk(){
	numCk($('#size'));  //숫자인지 체크
	numCk($('#landMineCnt'));  //숫자인지 체크
	
	if($('#size').val() == ''){
		alert('사이즈 입력.');
		return false;
	}
	if($('#landMineCnt').val() == ''){
		$('#landMineCnt').val($('#size').val());
	}
	
	var mapSize = $('#size');
	var landCnt = $('#landMineCnt');

	
	if(mapSize.val() < 5) mapSize.val(5);
	if(mapSize.val() > 20) mapSize.val(20);
	if(landCnt.val()*1 < mapSize.val()*1) landCnt.val(mapSize.val()); 
	if(landCnt.val()*1 > mapSize.val()*mapSize.val()-(mapSize.val()*2)) landCnt.val(mapSize.val()*mapSize.val()-(mapSize.val()*2));
	
	size = parseInt(mapSize.val());
	mineCnt = parseInt(landCnt.val());
	
	return true;
}

function showTime(){
	tme.setSeconds(tme.getSeconds()+1);
	
	var hour = tme.getHours();
	var minut = tme.getMinutes();
	var second = tme.getSeconds();

	if(hour/10 < 1) hour="0"+hour;
	if(minut/10 < 1) minut="0"+minut;
	if(second/10 < 1) second="0"+second;
	
	$('#tme').html(hour+":"+minut+":"+second);
}

$('#start').click(function(){
	if(!valueCk()) return;  //값 검사
	
	drawMap();
	evtOn();
	first = true;
	
	tme = new Date();
	tme.setHours(0);
	tme.setMinutes(0);
	tme.setSeconds(0);

	$('#tme').html("00:00:00");
	clearInterval(interval);
	interval = setInterval(showTime,1000)
});

function saveScore(){
	var time = tme.getHours()*3600+tme.getMinutes()*60+tme.getSeconds();
	var data = {
		usrIdx : '${sessionScope.loginDto.usrIdx}',
		score : mineCnt,
		size : size,
		playTime : time,
		gameType : 'landMine'
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

function getRank(){
	$.get({
		url : '${pageContext.request.contextPath}/game/getRank.do',
		data : {gameType : 'landMine'},
		success: function(data){
			$('#rankTbl tbody').text('');
			var html;
			for(var i=0;i<data.length;i++){
				console.log(data);
				html = '<tr>';
				html += '<td>'+(i+1)+'</td>';
				html += '<td>'+data[i].nickName+'</td>';
				html += '<td>'+data[i].score+'</td>';
				html += '<td>'+data[i].size+'</td>';
				html += '<td>'+data[i].playTime+'초</td>';
				html += '</tr>';
				$('#rankTbl tbody').append(html);
			}
		},
		error: function(e){
			console.log(e);
		}
	});
}

$(document).ready(function(){
	getRank();
})
</script>
</html>
