<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<!-- jstl -->
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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

	<title>밍구 페이지</title>

	<!-- Custom fonts for this template-->
	<link href="/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
	<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

	<!-- Custom styles for this template-->
	<link href="/resources/css/sb-admin-2.min.css" rel="stylesheet">
		<!-- selectBox CSS -->
		<link href="/resources/css/selectbox.css" rel="stylesheet">
	
	<!-- jQuery -->
	<script src="/resources/jQuery/jquery-3.4.1.min.js"></script>
	
	<!-- Chart.js -->
	<script src="/resources/chart.js2.8.0/Chart.min.js"></script>
	<script src="/resources/chart.js2.8.0/Chart.bundle.min.js"></script>

</head>
<body id="page-top">

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

				<!-- Begin Page Content 동네예보 -->
				<div class="container-fluid">
					<!-- Area Chart -->
					<div class="card shadow mb-4" style="min-width: 850px;">
						<!-- Card Header - Dropdown -->
						<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
							<h6 class="m-0 font-weight-bold text-primary">동네예보</h6>
						</div>
						<!-- Card Body -->
						<div class="card-body">
						<!-- <div class="card-body" style="height: 500px;"> -->
							<div style="margin-top: 40px">
							<select class="selectpicker" id="city"></select>
							<select class="selectpicker" id="gu"></select>
							<select class="selectpicker" id="dong"></select>
							<button class="btn" id="weatherSearch">날씨 조회</button>
						</div>
							
							<div class="chart-area">
								<canvas id="myChart"></canvas>
							</div>
							<table class="table table-bordered" id="tbl1">
								<thead>
									<tr>
										<th scope="col" style="min-width: 95px; height : 50px;">지역\날짜</th>
										<th scope="col" style="height : 50px;">오늘</th>
										<th scope="col" style="height : 50px;">내일</th>
										<th scope="col" style="height : 50px;">모레</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<th scope="row" id="areaD"></th>
										<td style="min-width:240px"></td>
										<td style="min-width:240px"></td>
										<td style="min-width:240px"></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<!-- /.container-fluid 동네예보-->
				
				<!-- Begin Page Content 중기에보-->
				<div class="container-fluid">
					<!-- Area Chart -->
					<div class="card shadow mb-4" style="min-width: 850px;">
						<!-- Card Header - Dropdown -->
						<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
							<h6 class="m-0 font-weight-bold text-primary">날씨</h6>
						</div>
						<!-- Card Body -->
						<div class="card-body">
						<!-- <div class="card-body" style="height: 500px;"> -->
							<div style="margin-top: 40px">
							<select class="selectpicker" id="city"></select>
							<select class="selectpicker" id="gu"></select>
							<select class="selectpicker" id="dong"></select>
							<button class="btn" id="weatherSearch">날씨 조회</button>
						</div>
							
							<div class="chart-area">
								<canvas id="myChart"></canvas>
							</div>
							<table class="table table-bordered" id="tbl2">
								<thead>
									<tr>
										<th scope="col" rowspan="2" style="min-width: 95px; height : 50px;">지역\날짜</th>
										<th scope="col" colspan="2" style="height : 50px;"></th>
										<th scope="col" colspan="2" style="height : 50px;"></th>
										<th scope="col" colspan="2" style="height : 50px;"></th>
										<th scope="col" colspan="2" style="height : 50px;"></th>
										<th scope="col" colspan="2" style="height : 50px;"></th>
										<th scope="col" rowspan="2" style="height : 50px;"></th>
										<th scope="col" rowspan="2" style="height : 50px;"></th>
										<th scope="col" rowspan="2" style="height : 50px;"></th>
									</tr>
									<tr>
										<th scope="col" style="min-width: 95px; height : 50px;">지역\날짜</th>
										<th scope="col" style="height : 50px;"></th>
										<th scope="col" style="height : 50px;"></th>
										<th scope="col" style="height : 50px;"></th>
										<th scope="col" style="height : 50px;"></th>
										<th scope="col" style="height : 50px;"></th>
										<th scope="col" style="height : 50px;"></th>
										<th scope="col" style="height : 50px;"></th>
										<th scope="col" style="height : 50px;"></th>
										<th scope="col" style="height : 50px;"></th>
										<th scope="col" style="height : 50px;"></th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<th scope="row" id="areaD"></th>
										<td style="min-width:240px"></td>
										<td style="min-width:240px"></td>
										<td style="min-width:240px"></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<!-- /.container-fluid 중기에보-->
				
				
				
				

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

	

<script>
var weather = {};
var date;
var myChart;
var wIdx=0;

$(document).ready(function(){
	fn_getDate();			//서버시간 받아오기
	fn_setSelectBox();	//초기 시, 구, 동 세팅
	fn_setWeather();	//날씨 세팅
	
	//시 선택시 구,동 selectBox 내용 병경
	$('#city').change(function(){
		setGu($('#city option:selected').val());
		setDong($('#gu option:selected').val());
	});
	
	//구 선택시 동 selectBox 내용 변경
	$('#gu').change(function(){
		setDong($('#gu option:selected').val());
	});
	
	//조회버튼 클릭
	$('#weatherSearch').click(function(){
		myChart.destroy();	//차트 지우기
		wIdx++;
		fn_setWeather();
	});
});

function fn_setSelectBox(){
	setCity();
	setGu($('#city option:selected').val());
	setDong($('#gu option:selected').val());
}

function fn_setWeather(){
	fn_getWeather("str");	//초단기 예보
	fn_getWeather("tw");	//동네 예보
	fn_drawChart();			//날씨 차트 그리기
	fn_setTbl1();			//오늘 / 내일 / 모레 날씨 테이블 세팅
}

//서버시간 받아오기
function fn_getDate(){
	$.ajax({
		url : "${pageContext.request.contextPath}/getDate.do",
		type: "GET",
		async: false,
		success: function(data){
			date = new Date(data);
		},error: function(){
			console.log("getDate Error")
		}
	});
}

/* select box */	
//시의 selectBox옵션 세팅 함수
function setCity(){
	$.ajax({
		url : "${pageContext.request.contextPath}/getCity.do",
		type: "GET",
		async: false,
		success: function(data){
			var city = jQuery.parseJSON(data);
			var html="";
			for(var i=0;i<city.length;i++){
				html+="<option value='"+city[i].code+"'>"+city[i].value+"</option>";
			}
			$('#city').html(html);
		}
	});
}

//구의 selectBox옵션 세팅 함수		비동기
function setGu(cityCode,setSelected){
	$.ajax({
		url: "${pageContext.request.contextPath}/getGu.do",
		type: "GET",
		async: false,
		data: {
			"cityCode": cityCode
		},
		success: function(data){
			var gu = jQuery.parseJSON(data);
			var html="";
			for(var i=0;i<gu.length;i++){
				html+="<option value='"+gu[i].code+"'>"+gu[i].value+"</option>";
			}
			$('#gu').html(html);
			if(setSelected != null){
				//$('#gu').val(setSelected).attr("selected","selected");
			}
		},
		error: function(){
			console.log("에러");
		}
	});
}

//동의 selectBox옵션 세팅 함수
function setDong(guCode, setSelected){
	$.ajax({
		url: "${pageContext.request.contextPath}/getDong.do",
		type: "GET",
		async: false,
		data: {
			"guCode": guCode
		},
		success: function(data){
			var dong = jQuery.parseJSON(data);
			var html="";
			for(var i=0;i<dong.length;i++){
				html+="<option value='"+dong[i].x+","+dong[i].y+"'>"+dong[i].value+"</option>";
			}
			$('#dong').html(html);
			if(setSelected != null){
				$('#dong').val(setSelected).attr("selected","selected");
			}
		},
		error: function(){
			console.log("에러");
		}
	});
}
/* select box end*/
/* weather start*/
function fn_getWeather(param){
	$.ajax({
		url: '${pageContext.request.contextPath}/weather/getWeather.do',
		type: 'GET',
		async: false,
		cache: false,
		data: {
			"param":param,
			"x":$('#dong option:selected').val().split(",")[0],
			"y":$('#dong option:selected').val().split(",")[1]
		},
		success:function(data){
			eval("weather."+param+" = JSON.parse(data)");
		},
		error:function(){
			console.log("getWeather Error");
		}
		
	});
}

//차트 그리기
function fn_drawChart(){
	var str = weather.str;	//초단기 예보
	var tw = weather.tw;	//동네 예보
	
	//초단기와 동네에보 합치기
	if (str[str.length-1].time == tw[0].time){
		var wData = str.concat(tw);
		console.log(weather);
	}
	else
		var wData = str.concat(tw);

	var min=wData[0].TPT;
	var max=wData[0].TPT;
	var labels = [];
	var data = [];
	
	//라벨과 데이터 설정하고 min과 max과 구하기
	for(var i=0;i<7;i++){
		
		var time = wData[i].time+"";
		labels.push(time.substr(0,2)+"시");
		data.push(wData[i].TPT);	//온도
		
		if(wData[i].TPT < min)
			min = wData[i].TPT;
		if(wData[i].TPT > max)
			max = wData[i].TPT;
	}
	
	Chart.pluginService.register({
			afterUpdate: function(chart) {
				
				for(var i=0;i<7;i++){
					var time = wData[i].time;
					var sky = wData[i].SKY;
					var pty = wData[i].PTY;
					var skyState = fn_getSkyState(sky,pty);
					var img = fn_getWeatherImg(skyState,time);
					img.width=30;
					img.height=30;
					var label = function(){
						return img.alt;
					};
					console.log(chart.config.data.datasets[0]);
					chart.config.data.datasets[0]._meta[wIdx].data[i]._model.pointStyle = img;
					chart.config.options.tooltips.callbacks.label = label;
				}
			}
	});
	
	//차트 그리기
	var ctx = document.getElementById('myChart');
	myChart = new Chart(ctx, {
		type: 'line',
		data: {
			labels: labels,
			datasets: [{
				data: data,
				backgroundColor: 'rgba(0, 0, 0, 0.0)',
				borderColor: [
					'rgba(102, 102, 102, 1)'
				],
				borderWidth: 2
			}]
		},
		options: {
			//responsive: false,
			maintainAspectRatio: false,
			hover: {
				animationDuration: 0
			},
			animation: {
				duration: 1,
				onComplete: function () {
					var chartInstance = this.chart,
						ctx = chartInstance.ctx;
					ctx.font = "14px \"Helvetica Neue\", Helvetica, Arial, sans-serif";
					ctx.fontSize = 15;
					ctx.fillSize = 15;
					ctx.textSize = 15;
					ctx.fillStyle = 'black';
					ctx.textAlign = 'center';
					ctx.textBaseline = 'bottom';

					this.data.datasets.forEach(function (dataset, i) {
						var meta = chartInstance.controller.getDatasetMeta(i);
						meta.data.forEach(function (bar, index) {
							var data = dataset.data[index];							
							ctx.fillText(data, bar._model.x, bar._model.y - 5);
						});
					});
				}
			},
			legend: {
				display: false
			},
			scales: {
				yAxes: [{
					ticks:{
						min: min-2,
						max: max+3,
						stepSize : 3,
						},
						display: false
				}],
				xAxes: [{
					ticks:{
						//fontColor : "#fff",
						fontSize : 14
					},
					gridLines:{
						lineWidth: 0
					}
				 }]
			}
		}
	});
}

//동네에보 세팅
function fn_setTbl1(){
	
	var dongNM = $('#dong option:selected').text();
	$('#areaD').text(dongNM);
	
	var str = weather.str;	//초단기 예보
	var tw = weather.tw;	//동네 예보
	
	//초단기와 동네에보 합치기
	if (str[str.length-1].time == tw[0].time)
		var wData = str.concat(tw.splice(1));
	else
		var wData = str.concat(tw);
	
	//현재 날씨
	var tpt = wData[0].TPT;	//온도
	var pty = wData[0].PTY;	//강수형태 코드
	var sky = wData[0].SKY;	//하늘 상태 코드
	var skyState = fn_getSkyState(sky,pty);
	var img = fn_getWeatherImg(skyState);
	var html;
	
	img.align = "left";

	html ="<ul style='margin-left: 50px'>";
	html +="<li>"+skyState+"</li>";
	html +="<li>기온 : "+tpt+"℃</li>";
	html +="</ul>";
	
	$('#tbl1 tbody td').eq(0).empty();
	$('#tbl1 tbody td').eq(0).append(html);
	$("#tbl1 tbody td").eq(0).prepend(img);
	
	//내일과 모레 날씨
	var tmpDate = new Date(date);
	tmpDate.setDate(tmpDate.getDate()+1);
	var skyStateArr = [];
	var min=100;
	var max=-50;
	var tdNum = 1;

	console.log("----------------");
	for(var i=1;i<wData.length;i++){
		
		var weatherDate = wData[i].date;
		//내일 날씨부터 구하기 위해 오늘 날씨 정보면 continue;
		if(weatherDate == date.format("yyyyMMdd")){
			continue;
		}
		var tpt = wData[i].TPT;	//온도
		var pty = wData[i].PTY;	//강수형태 코드
		var sky = wData[i].SKY;	//하늘 상태 코드
		
		//내일과 모레날씨 세팅
		if(weatherDate != tmpDate.format("yyyyMMdd")) {
			var rainCnt=0;	//비
			var cloudCnt=0;	//구름 많음
			var blurCnt=0;	//흐림
			var sleetCnt=0;	//진눈깨비
			var showerCnt=0;//소나기
			var snowCnt=0;	//눈
			
			for(var j=0;j<skyStateArr.length;j++){
				if(skyStateArr[j] == "비")
					rainCnt++;
				else if(skyStateArr[j] == "구름많음")
					cloudCnt++;
				else if(skyStateArr[j] == "흐림")
					blurCnt++;
				else if(skyStateArr[j] == "진눈깨비")
					sleetCnt++;
				else if(skyStateArr[j] == "소나기")
					showerCnt++;
				else if(skyStateArr[j] == "눈")
					snowCnt++;
			}
			
			if(rainCnt > 0 && snowCnt > 0){
				str = "비/눈";	
			}else if(rainCnt > 0){
				if (rainCnt > 2) str = "비";
				else str = "한때 비";
			}else if(snowCnt > 0){
				if (rainCnt > 2) str = "눈";
				else str = "한때 눈";
			}else if(sleetCnt > 0){
				str = "진눈깨비";
			}else if(showerCnt > 0){
				str = "소나기";
			}else if(blurCnt > 2){
				str = "흐림";
			}else{
				str = "맑음";
			}

			html ="<ul style='margin-left: 50px'>";
			html += "<li>"+str+"</li>";
			html += "<li>최저기온 : "+min+"</li>";
			html += "<li>최고기온 : "+max+"℃</li>";
			html += "</ul>";
			
			img = fn_getWeatherImg(str);
			img.align = "left";
			
			$('#tbl1 tbody td').eq(tdNum).empty();
			$('#tbl1 tbody td').eq(tdNum).append(html);
			$('#tbl1 tbody td').eq(tdNum).prepend(img);

			tmpDate.setDate(tmpDate.getDate()+1);
			skyStateArr = [];
			min=50;
			max=-50;
			tdNum++;
		}

		skyStateArr.push(fn_getSkyState(sky,pty));
		
		if (min > tpt)
			min = tpt;
		if(max < tpt)
			max = tpt;
		
	}
}

/**
 * 하늘 상태
 * 강수형태(PTY) 코드 : 없음(0), 비(1), 비/눈(2), 눈(3), 소나기(4)
 * 하늘상태(SKY) 코드 : 맑음(1), 구름많음(3), 흐림(4) 
 */
function fn_getSkyState(sky,pty){
	
	var str="";
	
	switch (pty){
	case 0:
		switch (sky){
		case 1:	//맑음
			str="맑음";
			break;
		case 3:	//구름 많음
			str="구름많음";
			break;
		case 4:	//흐림
			str="흐림";
			break;
		}
		break;
	case 1:	//비
		str="비";
		break;
	case 2:	//진눈깨비
		str="진눈개비";
		break;
	case 3:	//뉸
		str="눈";
		break;
	case 4:	//소나기
		str="소나기";
		break;
	}
	
	return str;
}
 
//이미지 세팅
function fn_getWeatherImg(str,time){
	var src = "${pageContext.request.contextPath}/resources/img/weatherImg/";
	var imgNM="";
	var img = new Image();
	
	if(str == "맑음")
		imgNM="NB01";
	else if(str == "구름조금")
		imgNM="NB02";
	else if(str == "구름많음")
		imgNM="NB03";
	else if(str == "흐림")
		imgNM="NB04";
	else if(str == "구름많고 비")
		imgNM="NB20";
	else if(str.indexOf("비/눈") != -1 || str.indexOf("비 또는 눈") != -1)
		imgNM="NB12";
	else if(str.indexOf("눈/비") != -1 || str.indexOf("눈 또는 비") != -1)
		imgNM="NB13";
	else if(str.indexOf("가끔 비") != -1 || str.indexOf("한때 비") != -1)
		imgNM="NB20";
	else if(str.indexOf("가끔 눈") != -1 || str.indexOf("한때 눈") != -1)
		imgNM="NB21";
	else if(str == "진눈개비")
		imgNM="NB12";
	else if(str == "소나기")
		imgNM="NB07";
	else if(str == "천둥번개")
		imgNM="NB14";
	else if(str == "연무")
		imgNM="NB18";
	else if(str == "안개")
		imgNM="NB15";
	else if(str == "황사")
		imgNM="NB16";
	else if(str == "박무")
		imgNM="NB17";
	else if(str.indexOf("비") != -1)
		imgNM="NB08";
	else if(str.indexOf("눈") != -1)
		imgNM="NB11";
	
	if(time < 600 || time > 1700)
		imgNM+="_N";
		
	img.src = src+imgNM+".png";
	img.alt = str;
	
	return img;
}


/* weather end*/

//날짜 formatter
Date.prototype.format = function (f) {
	if (!this.valueOf()) return " ";

	var weekKorName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
	var weekKorShortName = ["일", "월", "화", "수", "목", "금", "토"];
	var weekEngName = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
	var weekEngShortName = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];

	var d = this;

	return f.replace(/(yyyy|yy|MM|dd|KS|KL|ES|EL|HH|hh|mm|ss|a\/p)/gi, function ($1) {
		switch ($1) {
			case "yyyy": return d.getFullYear(); // 년 (4자리)
			case "yy": return (d.getFullYear() % 1000).zf(2); // 년 (2자리)
			case "MM": return (d.getMonth() + 1).zf(2); // 월 (2자리)
			case "dd": return d.getDate().zf(2); // 일 (2자리)
			case "KS": return weekKorShortName[d.getDay()]; // 요일 (짧은 한글)
			case "KL": return weekKorName[d.getDay()]; // 요일 (긴 한글)
			case "ES": return weekEngShortName[d.getDay()]; // 요일 (짧은 영어)
			case "EL": return weekEngName[d.getDay()]; // 요일 (긴 영어)
			case "HH": return d.getHours().zf(2); // 시간 (24시간 기준, 2자리)
			case "hh": return ((h = d.getHours() % 12) ? h : 12).zf(2); // 시간 (12시간 기준, 2자리)
			case "mm": return d.getMinutes().zf(2); // 분 (2자리)
			case "ss": return d.getSeconds().zf(2); // 초 (2자리)
			case "a/p": return d.getHours() < 12 ? "오전" : "오후"; // 오전/오후 구분
			default: return $1;
		}
	});
};

String.prototype.string = function (len) { var s = '', i = 0; while (i++ < len) { s += this; } return s; };
String.prototype.zf = function (len) { return "0".string(len - this.length) + this; };
Number.prototype.zf = function (len) { return this.toString().zf(len); };
 
</script>
</body>

</html>
