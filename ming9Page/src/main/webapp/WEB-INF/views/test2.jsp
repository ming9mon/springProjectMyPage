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
	</style>
</head>
<body>

<div id="map" style="width:100%;height:350px;"></div>
<button id="draw" type="button">그리기</button>
<button id="del" type="button">지우기</button>
<p id="result"></p>

<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7da9fd70c241ad23bc401bf6108b947e&libraries=services"></script>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=5se8nlkpym"></script>
<script>
var mapOptions = {
	    center: new naver.maps.LatLng(37.359924641705476, 127.1148204803467),
	    zoom: 15
	};

var contentString = [
    '<div class="iw_inner">',
    '   <h3>서울특별시청</h3>',
    '   <p>서울특별시 중구 태평로1가 31 | 서울특별시 중구 세종대로 110 서울특별시청<br>',
    '       <img src="./img/hi-seoul.jpg" width="55" height="55" alt="서울시청" class="thumb" /><br>',
    '       02-120 | 공공,사회기관 > 특별,광역시청<br>',
    '       <a href="http://www.seoul.go.kr" target="_blank">www.seoul.go.kr/</a>',
    '   </p>',
    '</div>'
].join('');

var map = new naver.maps.Map('map', mapOptions);

var marker;
var infowindow;
var markerEvt;
var mapEvt;
var polyline;
var polyInfo;
var polyInfoContent;

infowindow = new naver.maps.InfoWindow({

    content: contentString,

    maxWidth: 140,
    backgroundColor: "#eee",
    borderColor: "#2db400",
    borderWidth: 5,
    anchorSize: new naver.maps.Size(30, 30),
    anchorSkew: true,
    anchorColor: "#eee",

    pixelOffset: new naver.maps.Point(20, -20)
});

$('#draw').click(function(){
	// 마커 생성
	marker = new naver.maps.Marker({
	    position: new naver.maps.LatLng(37.3595704, 127.105399),
	    map: map
	});
	
	// 마커 클릭 이벤트
	markerEvt = naver.maps.Event.addListener(marker, "click", function(e) {
		if (infowindow.getMap()) {
	        infowindow.close();
	    } else {
	        infowindow.open(map, marker);
	    }
	});
	
	// 지도 클릭 이벤트
	mapEvt = naver.maps.Event.addListener(map, 'click', function(e) {
		var latlng = e.latlng;

	    marker.setPosition(latlng);
	    
	    if (infowindow.getMap()) {
	        infowindow.close();
	    }
	});
	
	// 선 그리기
	polyline = new naver.maps.Polyline({
	    map: map,
	    path: [
	        new naver.maps.LatLng(37.359924641705476, 127.1148204803467),
	        new naver.maps.LatLng(37.36343797188166, 127.11486339569092)
	    ]
	});
	
	// 미터(M)표시
	console.log(polyline.getDistance());
	polyInfoContent = $([
	    '<div class="pin_nation">',
	    '   <a href="http://www.naver.com/" target="_blank" class="pin_a">',
	    '       <img src="./img/hi-seoul.jpg" width="38" height="26" alt="" class="pin_flag_m">',
	    '       <span class="pin_txt"><em>캐나다</em> <span class="spr spr_arrow"></span></span>',
	    '       <span class="spr spr_arr"></span>',
	    '   </a>',
	    '   <div class="pin"><span class="pin_blur"></span></div>',
	    '</div>'].join(''));
	
	polyInfo = new naver.maps.InfoWindow({

	    content: polyInfoContent[0],

	    maxWidth: 140,
	    backgroundColor: "#eee",
	    borderColor: "#2db400",
	    borderWidth: 5,
	    anchorSize: new naver.maps.Size(30, 30),
	    anchorSkew: true,
	    anchorColor: "#eee",

	    pixelOffset: new naver.maps.Point(20, -20)
	});

	//선 infoWindow
	if (!polyInfo.getMap()) {
	   	var latlng = new naver.maps.LatLng(37.359924641705476, 127.1148204803467);
	   	polyInfo.open(map, latlng);
	}
});



$('#del').click(function(){
	if(marker){
		marker.setMap(null);
	}
	if (infowindow.getMap()) {
        infowindow.close();
    }
	if (polyline) {
		polyline.setMap(null);
    }
	if (polyInfo.getMap()) {
		polyInfo.close();
    }
	naver.maps.Event.removeListener(markerEvt);
	naver.maps.Event.removeListener(mapEvt);
});
</script>
</body>

</html>