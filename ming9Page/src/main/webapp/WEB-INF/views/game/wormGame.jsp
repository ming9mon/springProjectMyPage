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
		td {width: 20px;height: 20px;text-align: center;font-size:10px;}
		.body {background-color:black;}
		.head {background-color:red;}
		.item {background-color:yellow;}
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
							<h6 class="m-0 font-weight-bold text-primary">지렁이 게임</h6>
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
									<table id="gameTbl" border=1 style="width:200px;height:200px;">
										<tr>
											<td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
										</tr>
										<tr>
											<td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
										</tr>
										<tr>
											<td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
										</tr>
										<tr>
											<td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
										</tr>
										<tr>
											<td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
										</tr>
										<tr>
											<td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
										</tr>
										<tr>
											<td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
										</tr>
										<tr>
											<td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
										</tr>
										<tr>
											<td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
										</tr>
										<tr>
											<td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
										</tr>
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
	var played = false;
	var size;	//길이
	var rows = $('#gameTbl').find('tr').length;	//열
	var cols = $($('#gameTbl').find('tr')[0]).find('td').length; //행
	var $tr = $('#gameTbl tr');
	var $td = $('#gameTbl td');
	var bodyArr = new Array();		//몸통
	var interval;
	var nowAroma;	//현재 방향
	var intervalTme;
	var headShape;
	var itemX;
	var itemY;
	
	init();

	//키 이벤트
	$(document).keydown(function(event){
		switch(event.keyCode){
		case 38:	//up
			move('u');
			break;
		case 40:	//down
			move('d');
			break;
		case 37:	//left
			move('l');
			break;
		case 39:	//right
			move('r');
			break;
		}
	});
	
	//버튼 이벤트
	/* $('#gameBtn button').keydown(function(e){
		if($(this).attr('id') == 'up') move('u');
		else if($(this).attr('id') == 'down') move('d');
		else if($(this).attr('id') == 'left') move('l');
		else if($(this).attr('id') == 'right') move('r');
	}); */
	$('#gameBtn button').click(function(){
		if($(this).attr('id') == 'up') move('u');
		else if($(this).attr('id') == 'down') move('d');
		else if($(this).attr('id') == 'left') move('l');
		else if($(this).attr('id') == 'right') move('r');
	});
	
	function move(mv){
		nowAroma = mv;
		
		if(mv == 'u'){
			headShape = '▲';
		}else if(mv == 'd'){
			headShape = '▼';
		}else if(mv == 'l'){
			headShape = '◀';
		}else if(mv == 'r'){
			headShape = '▶';
		}

		$('.head').text(headShape);
		
		if(!played) gameStart();
	}
	
	function gameStart(){
		init();	//테이블 초기화 및 데이터 초기화
		played = true;
		
		interval = setInterval(playGame,intervalTme);
	}
	
	function playGame(){
		var nowRow = $('.head')[0].cellIndex;
		var nowCol = $('#gameTbl tr').index($('.head').parent());
		

		
		if(bodyArr.length == size) bodyArr.shift();	//첫 번째 그린거 지우기
		if(bodyArr.length < size){	//몸통 갯수가 size보다 작으면 원래 대가리 자리 body배열에 저장
			bodyArr.push(nowRow+","+nowCol);
		}
		
		//대가리 다음 위치 계산
		if(nowAroma == 'u') nowCol-=1;
		else if(nowAroma == 'd') nowCol+=1;
		else if(nowAroma == 'l') nowRow-=1;
		else if(nowAroma == 'r') nowRow+=1;
		
		/* 뒤진거 체크 */
		if(nowRow == rows || nowRow < 0 || nowCol == cols || nowCol < 0){	//범위 벗어났는지 확인
			gameEnd();
			return;
		}
		for(var i=0;i<bodyArr.length;i++){	//몸통 밟았는지 확인
			var body = bodyArr[i].split(',');
			if(body[0] == nowRow && body[1] == nowCol){	
				gameEnd();
				return;
			}
		}
		
		//아이템 먹었는지 확인
		if(nowRow == itemX && nowCol == itemY){
			$('.item').removeClass('item');
			size++;
			if(intervalTme > 60) intervalTme-=15;
			clearInterval(interval);
			interval = setInterval(playGame,intervalTme);
		}
		
		//대가리 지우기
		$('#gameTbl td').removeClass('head');
		$('#gameTbl td').text('');
		
		//대가리 이동시키기
		var headTd = $($($tr[nowCol]).children()[nowRow]);
		headTd.addClass('head');
		headTd.text(headShape);
		
		//몸통 지우기
		$('.body').each(function(index,item){
			$(item).removeClass('body');
		});
		
		//몸통 그리기
		for(var i=0;i<bodyArr.length;i++){
			var body = bodyArr[i].split(',');
			var bodyTd = $($($tr[body[1]]).children()[body[0]]);
			bodyTd.addClass('body');
		}
		
		//아이템 생성
		if($('.item').length == 0){
			var ck = true;
			while(ck){
				ck = false;
				itemX = Math.floor(Math.random()*9);
				itemY = Math.floor(Math.random()*9);
				
				for(var i=0;i<bodyArr.length;i++){
					var body = bodyArr[i].split(',');
					if(body[0] == itemX && body[1]== itemY){
						ck=true;
						break;
					}
					if(!ck) break;
				}
				if(nowRow == itemX && nowCol == itemY) ck = true;
			}
			$($($tr[itemY]).children()[itemX]).addClass('item');
		}
	}
	
	function gameEnd(){
		played = false;
		clearInterval(interval);
		alert("멍청아 !! "+(size+1)*100+"점이다 !");
		if('${sessionScope.loginDto.usrIdx}' != '') saveScore((size+1)*100);
	}
	
	function init(){
		intervalTme = 300;
		bodyArr = new Array();
		size = 4;

		$('#gameTbl td').removeClass('head');
		$('#gameTbl td').removeClass('body');
		
		//대가리 그리기
		var headTd = $($($tr[5]).children()[5]);
		headTd.addClass('head')
		headTd.text("◆");

		getRank();	//랭킹 정보
	}
	
	function getRank(){
		
		$.get({
			url : '${pageContext.request.contextPath}/game/getRank.do',
			data : {gameType : 'worm'},
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
			gameType : 'worm'
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
</script>
</html>
