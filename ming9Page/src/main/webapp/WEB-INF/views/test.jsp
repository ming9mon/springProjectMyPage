<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<!doctype html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="ko">

<head>
    <meta charset="utf-8">
    <title>test</title>
    <style>
		.dot {overflow:hidden;float:left;width:12px;height:12px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/mini_circle.png');}    
		.dotOverlay {position:relative;bottom:10px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;float:left;font-size:12px;padding:5px;background:#fff;}
		.dotOverlay:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}    
		.number {font-weight:bold;color:#ee6152;}
		.dotOverlay:after {content:'';position:absolute;margin-left:-6px;left:50%;bottom:-8px;width:11px;height:8px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white_small.png')}
		.distanceInfo {position:relative;top:5px;left:5px;list-style:none;margin:0;}
		.distanceInfo .label {display:inline-block;width:50px;}
		.distanceInfo:after {content:none;}
	</style>
</head>
<body>

<div id="map" style="width:100%;height:350px;"></div>
<button id="draw" type="button">그리기</button>
<button id="del" type="button">지우기</button>
<p id="result"></p>

<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7da9fd70c241ad23bc401bf6108b947e&libraries=services"></script>

<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
mapOption = { 
    center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
    level: 5 // 지도의 확대 레벨
};

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성

var distanceOverlay; // 선의 거리정보를 표시할 커스텀오버레이
var line;			 // 선

var linePath = [
    new kakao.maps.LatLng(33.452344169439975, 126.56878163224233),
    new kakao.maps.LatLng(33.452739313807456, 126.5709308145358)
];

$('#draw').click(function(){

	//라인 그리기
	line = new kakao.maps.Polyline({
	    map: map, // 선을 표시할 지도입니다 
	    path: linePath, // 선을 구성하는 좌표 배열입니다 클릭한 위치를 넣어줍니다
	    strokeWeight: 3, // 선의 두께입니다 
	    strokeColor: '#db4040', // 선의 색깔입니다
	    strokeOpacity: 1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
	    strokeStyle: 'solid' // 선의 스타일입니다
	});


	var distance = Math.round(line.getLength()), // 선의 총 거리를 계산합니다
	content = getTimeHTML(distance); // 커스텀오버레이에 추가될 내용입니다

	var position = line.getPath();
	console.log(position[1]);

	//그려진 선의 거리정보를 지도에 표시합니다
	showDistance(content, position[position.length - 1]);
});

$('#del').click(function(){
	//지도 위에 선이 표시되고 있다면 지도에서 제거합니다
	deleteLine();

	// 지도 위에 커스텀오버레이가 표시되고 있다면 지도에서 제거합니다
	deleteDistnce();
});


// 선의 정보
function showDistance(content, position) {
        
	// 커스텀 오버레이를 생성하고 지도에 표시합니다
	distanceOverlay = new kakao.maps.CustomOverlay({
	    map: map, // 커스텀오버레이를 표시할 지도입니다
	    content: content,  // 커스텀오버레이에 표시할 내용입니다
	    position: position, // 커스텀오버레이를 표시할 위치입니다.
	    xAnchor: 0,
	    yAnchor: 0,
	    zIndex: 3  
	});
}

//마우스 우클릭 하여 선 그리기가 종료됐을 때 호출하여 
//그려진 선의 총거리 정보와 거리에 대한 도보, 자전거 시간을 계산하여
//HTML Content를 만들어 리턴하는 함수입니다
function getTimeHTML(distance) {

 // 도보의 시속은 평균 4km/h 이고 도보의 분속은 67m/min입니다
 var walkkTime = distance / 67 | 0;
 var walkHour = '', walkMin = '';

 // 계산한 도보 시간이 60분 보다 크면 시간으로 표시합니다
 if (walkkTime > 60) {
     walkHour = '<span class="number">' + Math.floor(walkkTime / 60) + '</span>시간 '
 }
 walkMin = '<span class="number">' + walkkTime % 60 + '</span>분'

 // 거리와 도보 시간, 자전거 시간을 가지고 HTML Content를 만들어 리턴합니다
 var content = '<ul class="dotOverlay distanceInfo">';
 content += '    <li>';
 content += '        <span class="label">총거리</span><span class="number">' + distance + '</span>m';
 content += '    </li>';
 content += '    <li>';
 content += '        <span class="label">도보</span>' + walkHour + walkMin;
 content += '    </li>';
 content += '</ul>'

 return content;
}


function deleteLine() {
    if (line) {
        line.setMap(null);    
        line = null;        
    }
}

function deleteDistnce () {
    if (distanceOverlay) {
        distanceOverlay.setMap(null);
        distanceOverlay = null;
    }
}






kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
    
    // 클릭한 위도, 경도 정보를 가져옵니다 
    var latlng = mouseEvent.latLng;
    
    var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
    message += '경도는 ' + latlng.getLng() + ' 입니다';
    
    var resultDiv = document.getElementById('result'); 
    resultDiv.innerHTML = message;
    
});
</script>
</body>

</html>