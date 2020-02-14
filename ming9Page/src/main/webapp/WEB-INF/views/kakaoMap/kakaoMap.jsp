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

	<title>밍구 페이지</title>
	

	<!-- Custom fonts for this template-->
	<link href="${pageContext.request.contextPath}/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
	<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

	<!-- Custom styles for this template-->
	<link href="${pageContext.request.contextPath}/resources/css/sb-admin-2.min.css" rel="stylesheet">
	
	<!-- common CSS -->
	<link href="${pageContext.request.contextPath}/resources/css/common.css" rel="stylesheet">
	
	<!-- jQuery -->
	<script src="${pageContext.request.contextPath}/resources/jQuery/jquery-3.4.1.min.js"></script>
	
	<!-- Common -->
	<link href="/resources/css/common.css" rel="stylesheet">
	<script src="/resources/js/common.js"></script>
	
	<style>
		.map_wrap, .map_wrap * {margin:0;padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
		.map_wrap a, .map_wrap a:hover, .map_wrap a:active{color:#000;text-decoration: none;}
		.map_wrap {position:relative;width:100%;height:500px;}
		#menu_wrap {position:absolute;top:0;left:0;bottom:0;width:250px;margin:10px 0 30px 10px;padding:5px;overflow-y:auto;background:rgba(255, 255, 255, 0.7);z-index: 1;font-size:12px;border-radius: 10px;}
		.bg_white {background:#fff;}
		#menu_wrap hr {display: block; height: 1px;border: 0; border-top: 2px solid #5F5F5F;margin:3px 0;}
		#menu_wrap .option{text-align: center;}
		#menu_wrap .option p {margin:10px 0;}  
		#menu_wrap .option button {margin-left:5px;}
		#placesList li {list-style: none;}
		#placesList .item {position:relative;border-bottom:1px solid #888;overflow: hidden;cursor: pointer;min-height: 65px;}
		#placesList .item span {display: block;margin-top:4px;}
		#placesList .item h5, #placesList .item .info {text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
		#placesList .item .info{padding:10px 0 10px 55px;}
		#placesList .info .gray {color:#8a8a8a;}
		#placesList .info .jibun {padding-left:26px;background:url(http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;}
		#placesList .info .tel {color:#009900;}
		#placesList .item .markerbg {float:left;position:absolute;width:36px; height:37px;margin:10px 0 0 10px;background:url(http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;}
		#placesList .item .marker_1 {background-position: 0 -10px;}
		#placesList .item .marker_2 {background-position: 0 -56px;}
		#placesList .item .marker_3 {background-position: 0 -102px}
		#placesList .item .marker_4 {background-position: 0 -148px;}
		#placesList .item .marker_5 {background-position: 0 -194px;}
		#placesList .item .marker_6 {background-position: 0 -240px;}
		#placesList .item .marker_7 {background-position: 0 -286px;}
		#placesList .item .marker_8 {background-position: 0 -332px;}
		#placesList .item .marker_9 {background-position: 0 -378px;}
		#placesList .item .marker_10 {background-position: 0 -423px;}
		#placesList .item .marker_11 {background-position: 0 -470px;}
		#placesList .item .marker_12 {background-position: 0 -516px;}
		#placesList .item .marker_13 {background-position: 0 -562px;}
		#placesList .item .marker_14 {background-position: 0 -608px;}
		#placesList .item .marker_15 {background-position: 0 -654px;}
		#pagination {margin:10px auto;text-align: center;}
		#pagination a {display:inline-block;margin-right:10px;}
		#pagination .on {font-weight: bold; cursor: default;color:#777;}
		
		.label {margin-bottom: 96px;}
		.label * {display: inline-block;vertical-align: top;}
		.label .left {background: url("http://t1.daumcdn.net/localimg/localimages/07/2011/map/storeview/tip_l.png") no-repeat;display: inline-block;height: 24px;overflow: hidden;vertical-align: top;width: 7px;}
		.label .center {background: url(http://t1.daumcdn.net/localimg/localimages/07/2011/map/storeview/tip_bg.png) repeat-x;display: inline-block;height: 24px;font-size: 12px;line-height: 24px;}
		.label .right {background: url("http://t1.daumcdn.net/localimg/localimages/07/2011/map/storeview/tip_r.png") -1px 0  no-repeat;display: inline-block;height: 24px;overflow: hidden;width: 6px;}
		
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
					<div class="card shadow mb-4" style="min-width: 500px;">
						<!-- Card Header - Dropdown -->
						<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
							<h6 class="m-0 font-weight-bold text-primary">카카오 MAP</h6>
							
							<!-- drop down -->
							<div class="dropdown no-arrow">
								<a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
									<i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
								</a>
								<div id="selectDiv" class="dropdown-menu dropdown-menu-right shadow animated--fade-in" aria-labelledby="dropdownMenuLink">
									<div class="dropdown-header">기능</div>
									<a class="dropdown-item active" href="#" id="noWork">일하기싫다</a>
									<a class="dropdown-item" href="#" id="cctv">CCTV</a>
									<a class="dropdown-item" href="#" id="search">검색</a>
									<div class="dropdown-divider"></div>
									<a class="dropdown-item" href="#">Something else here</a>
								</div>
							</div>
						</div>
						
						<a href="#" id="saveLocInfoPop" class="btn btn-block" style="color: #fff;background-color: #7c6593;border-color: #fff;">
							<span>위치 정보 등록</span>
						</a>
						
						<!-- Card Body -->
						<div class="card-body">
						  
				          	<!-- 지도 영역 -->
				          	<div class="map_wrap">
								<div id="map" style="width:100%;height:500px;"></div>
								
								<div id="menu_wrap" class="bg_white" style="display:none;">
							        <div class="option">
							            <div>
							                <form onsubmit="searchPlaces(); return false;">
							                    키워드 : <input type="text" value="" id="keyword" size="15"> 
							                    <button type="submit">검색하기</button> 
							                </form>
							            </div>
							        </div>
							        <hr>
							        <ul id="placesList"></ul>
							        <div id="pagination"></div>
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

<!-- 위치 정보 등록 팝업 -->
<div id="locPop" style="display:none;z-index:100;background:white;position:absolute;top:20%;left:40%;width:500px;height:500px;margin:-50px 0 0 -50px;">
	<div class="container-fluid" style="margin-top:20px;">
		<!-- DataTales Example -->
		<article>
			<div class="container" role="main">
				<h2>정보 등록 !</h2>
				<form name="frm" id="frm" role="form" method="get" action="${pageContext.request.contextPath}/kakao/locInfoSave" enctype="multipart/form-data">
					<div class="mb-3">
						<label for="title">장소명 또는 가게명</label> <input type="text"
							class="form-control" name="title" id="title"
							placeholder="장소명 또는 가게명을 입력해 주세요">
					</div>
					<div class="mb-3">
						<label for="reg_id">작성자</label> <input type="text"
							class="form-control" name="nickName" id="nickName"
							value="${sessionScope.loginDto.nickName}" readonly>
					</div>
					<div class="mb-3">
						<label for="content">사진 등록   </label><input type="file" id="upImg" name="upImg" multiple>
						<div class="form-control" id="contents">
						</div>
					</div>
					<input type="hidden" name="loc" id="loc">
				</form>
				<div>
					<button type="button" class="btn btn-sm btn-primary" id="saveInfo">저장</button>
					<button type="button" class="btn btn-sm btn-primary" id="exitPop">닫기</button>
				</div>
			</div>
		</article>

	</div>
</div>
<!-- 위치 등록 팝업 END -->

<!-- Bootstrap core JavaScript-->
<script src="/resources/vendor/jquery/jquery.min.js"></script>
<script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script src="/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="/resources/js/sb-admin-2.min.js"></script>

<!-- Kakao API -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ed639b8f650bd5b8dc3dceb7c3c64e67&libraries=services"></script>
<script>
	var noWorkOnOff = 'on';
	var cctvOnOff = 'off';
	var searchOnOff = 'off';
	var markers = [];
	var infowindow = new kakao.maps.InfoWindow();

	var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
	var options = { //지도를 생성할 때 필요한 기본 옵션
		center : new kakao.maps.LatLng(37.55577812380073, 127.05049817426826), //지도의 중심좌표.
		level : 8
	//지도의 레벨(확대, 축소 정도)
	};

	var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴

	if ("geolocation" in navigator) { /* geolocation 사용 가능 */
		navigator.geolocation.getCurrentPosition(function(data) {

			var latitude = data.coords.latitude;
			var longitude = data.coords.longitude;

			options = { //지도를 생성할 때 필요한 기본 옵션
				center : new kakao.maps.LatLng(latitude, longitude), //지도의 중심좌표.
				level : 6
			//지도의 레벨(확대, 축소 정도)
			};

			//map = new kakao.maps.Map(container, options);
			/* var geocoder = new kakao.maps.services.Geocoder();	// 주소-좌표 변환 객체를 생성
			// 좌표로 행정동 주소 정보를 요청합니다
			geocoder.coord2RegionCode(longitude, latitude, displayCenterInfo);   */

		}, function(error) {
			console.log("geolocation 실패");
		}, {
			enableHighAccuracy : true,
			timeout : Infinity,
			maximumAge : 0
		});
	}

	/* ajax 시작 종료 */
	$(document).ajaxStart(function() {
		$('#bg').show();
		$('.loading').show();
	}).ajaxStop(function() {
		$('#bg').hide();
		$('.loading').hide();
	})

	/* CCTV 시작 */
	//CCTV DATA GET
	function fn_getCCTVData() {
		var bounds = map.getBounds(); // 지도 영역정보를 얻어옵니다 

		var sw = bounds.getSouthWest();
		var ne = bounds.getNorthEast();

		var minY = sw.getLat();
		var maxY = ne.getLat();
		var minX = sw.getLng();
		var maxX = ne.getLng();

		$.ajax({
			url : '${pageContext.request.contextPath}/kakao/getCCTVData.do',
			type : 'GET',
			data : {
				minX : minY,
				maxX : maxX,
				minY : minY,
				maxY : maxY
			},
			success : function(rst) {
				setMarkers(null); //마커 삭제
				if (rst.RTNCD == 0) {
					fn_setCCTV(rst.RST);
				}
			},
			error : function(e) {
				alert('cctvData ERROR');
			}

		});
	}

	//CCTV DATA SET
	function fn_setCCTV(data) {
		var dataSize = data.length;
		var level = map.getLevel();

		var idx = 1;
		if (dataSize > 50 && level > 6) {
			if (dataSize < 500) {
				idx = 3;
			} else if (dataSize < 1000) {
				idx = 10;
			} else if (dataSize < 2000) {
				idx = 20;
			} else if (dataSize < 3000) {
				idx = 30;
			} else {
				idx = 50;
			}
		}

		for (var i = 0; i < data.length; i += idx) {
			var x = data[i].coordx;
			var y = data[i].coordy;

			var imageSrc = '${pageContext.request.contextPath}/resources/img/cctv_on.png', // 마커이미지의 주소입니다    
			imageSize = new kakao.maps.Size(30, 30), // 마커이미지의 크기입니다
			imageOption = {
				offset : new kakao.maps.Point(10, 20)
			}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

			// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
			var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize,
					imageOption)
			var markerPosition = new kakao.maps.LatLng(y, x);
			// 마커를 생성합니다
			var marker = new kakao.maps.Marker({
				position : markerPosition,
				image : markerImage
			// 마커이미지 설정 
			});

			marker.setMap(map);
			marker.K = data[i].cctvname + '||' + data[i].cctvurl;
			markers.push(marker);
			kakao.maps.event.addListener(marker, 'click', makeClickListener(
					map, marker));
			kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(
					map, marker));
			kakao.maps.event.addListener(marker, 'mouseout', makeOutListener());
		}

	}

	//cctv 아이콘 클릭 클릭 이벤트
	function makeClickListener(map, marker) {

		return function() {
			var data = marker.K.split('||');
			var infowindow = new kakao.maps.InfoWindow(
					{// 마커에 표시할 인포윈도우를 생성
						content : "<div>"
								+ data[0]
								+ "</div><video src='"+data[1]+"' autoplay=\"autoplay\" data-id=\"video\" width='300' heigth='300'>dd</video>"
					// 인포윈도우에 표시할 내용
					});
			infowindow.open(map, marker);
			setTimeout(function() {
				infowindow.close();
			}, 5000);
		};
	}

	//인포윈도우를 표시하는 클로저를 만드는 함수
	function makeOverListener(map, marker) {
		return function() {
			var data = marker.K.split('||');
			infowindow = new kakao.maps.InfoWindow({// 마커에 표시할 인포윈도우를 생성
				content : "<div>" + data[0] + "</div>"
			// 인포윈도우에 표시할 내용
			});
			infowindow.open(map, marker);
		};
	}

	// 인포윈도우를 닫는 클로저를 만드는 함수
	function makeOutListener() {
		return function() {
			infowindow.close();
		};
	}

	/* CCTV 끝 */

	/* 검색기능 시작 */
	// 장소 검색 객체를 생성합니다
	var ps = new kakao.maps.services.Places();
	//검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
	var infowindow = new kakao.maps.InfoWindow({
		zIndex : 1
	});

	//키워드 검색을 요청하는 함수입니다
	function searchPlaces() {

		var keyword = document.getElementById('keyword').value;

		if (!keyword.replace(/^\s+|\s+$/g, '')) {
			alert('키워드를 입력해주세요!');
			return false;
		}

		// 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
		ps.keywordSearch(keyword, placesSearchCB);
	}

	// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
	function placesSearchCB(data, status, pagination) {
		if (status === kakao.maps.services.Status.OK) {

			// 정상적으로 검색이 완료됐으면
			// 검색 목록과 마커를 표출합니다
			displayPlaces(data);

			// 페이지 번호를 표출합니다
			displayPagination(pagination);

		} else if (status === kakao.maps.services.Status.ZERO_RESULT) {

			alert('검색 결과가 존재하지 않습니다.');
			return;

		} else if (status === kakao.maps.services.Status.ERROR) {

			alert('검색 결과 중 오류가 발생했습니다.');
			return;

		}
	}

	// 검색 결과 목록과 마커를 표출하는 함수입니다
	function displayPlaces(places) {

		var listEl = document.getElementById('placesList'), menuEl = document
				.getElementById('menu_wrap'), fragment = document
				.createDocumentFragment(), bounds = new kakao.maps.LatLngBounds(), listStr = '';

		// 검색 결과 목록에 추가된 항목들을 제거합니다
		removeAllChildNods(listEl);

		// 지도에 표시되고 있는 마커를 제거합니다
		setMarkers(null);

		for (var i = 0; i < places.length; i++) {

			// 마커를 생성하고 지도에 표시합니다
			var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x), marker = addMarker(
					placePosition, i), itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

			// 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
			// LatLngBounds 객체에 좌표를 추가합니다
			bounds.extend(placePosition);

			// 마커와 검색결과 항목에 mouseover 했을때
			// 해당 장소에 인포윈도우에 장소명을 표시합니다
			// mouseout 했을 때는 인포윈도우를 닫습니다
			(function(marker, title) {
				kakao.maps.event.addListener(marker, 'mouseover', function() {
					displayInfowindow(marker, title);
				});

				kakao.maps.event.addListener(marker, 'mouseout', function() {
					infowindow.close();
				});

				itemEl.onmouseover = function() {
					displayInfowindow(marker, title);
				};

				itemEl.onmouseout = function() {
					infowindow.close();
				};
			})(marker, places[i].place_name);

			fragment.appendChild(itemEl);
		}

		// 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
		listEl.appendChild(fragment);
		menuEl.scrollTop = 0;

		// 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
		map.setBounds(bounds);
	}

	// 검색결과 항목을 Element로 반환하는 함수입니다
	function getListItem(index, places) {

		var el = document.createElement('li'), 
		itemStr = '<span class="markerbg marker_'+ (index + 1)+ '"></span>'
				+ '<div class="info">   <h5>'+ places.place_name + '</h5>';

		if (places.road_address_name) {
			itemStr += '    <span>' + places.road_address_name + '</span>'
					+ '   <span class="jibun gray">' + places.address_name+ '</span>';
		} else {
			itemStr += '    <span>' + places.address_name + '</span>';
		}

		itemStr += '  <span class="tel">' + places.phone + '</span>' + '</div>';

		el.innerHTML = itemStr;
		el.className = 'item';

		return el;
	}

	// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
	function addMarker(position, idx, title) {
		var imageSrc = 'http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
		imageSize = new kakao.maps.Size(36, 37), // 마커 이미지의 크기
		imgOptions = {
			spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
			spriteOrigin : new kakao.maps.Point(0, (idx * 46) + 10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
			offset : new kakao.maps.Point(13, 37)
		// 마커 좌표에 일치시킬 이미지 내에서의 좌표
		}, markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize,
				imgOptions), marker = new kakao.maps.Marker({
			position : position, // 마커의 위치
			image : markerImage
		});

		marker.setMap(map); // 지도 위에 마커를 표출합니다
		markers.push(marker); // 배열에 생성된 마커를 추가합니다

		return marker;
	}

	//검색결과 목록 하단에 페이지번호를 표시는 함수입니다
	function displayPagination(pagination) {
		var paginationEl = document.getElementById('pagination'), fragment = document
				.createDocumentFragment(), i;

		// 기존에 추가된 페이지번호를 삭제합니다
		while (paginationEl.hasChildNodes()) {
			paginationEl.removeChild(paginationEl.lastChild);
		}

		for (i = 1; i <= pagination.last; i++) {
			var el = document.createElement('a');
			el.href = "#";
			el.innerHTML = i;

			if (i === pagination.current) {
				el.className = 'on';
			} else {
				el.onclick = (function(i) {
					return function() {
						pagination.gotoPage(i);
					}
				})(i);
			}

			fragment.appendChild(el);
		}
		paginationEl.appendChild(fragment);
	}

	// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
	// 인포윈도우에 장소명을 표시합니다
	function displayInfowindow(marker, title) {
		var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

		infowindow.setContent(content);
		infowindow.open(map, marker);
	}

	// 검색결과 목록의 자식 Element를 제거하는 함수입니다
	function removeAllChildNods(el) {
		while (el.hasChildNodes()) {
			el.removeChild(el.lastChild);
		}
	}
	/* 검색기능 끝 */

	/* 일 하기 싫다 시작 ! */
	var custumMater;
	var customOverlay;

	var imageSrc = '${pageContext.request.contextPath}/resources/img/marker.png', // 마커이미지의 주소입니다    
	imageSize = new kakao.maps.Size(64, 69) // 마커이미지의 크기입니다

	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize
			), markerPosition = map.getCenter();

	/* var content = '<div class="customoverlay">'
			+ '  <a href="#" id="cmarker" onClick="return false;">'
			+ '    <span class="title">이 위치에 정보를 등록하려면 지도 위 위치등록 클릭</span>'
			+ '  </a>' + '</div>'; */
	var content = '<div class ="label"><span class="left"></span>';
	content += '<span class="center">이 위치에 정보를 등록하려면 지도 위 버튼 클릭</span>';
	content += '<span class="right"></span></div>';
	
	noWork();

	$(document).on('click', '#cmarker', function(e) {
		e.stopPropagation();
		e.stopImmediatePropagation();
	});

	//위치정보 저장 클릭 이벤트
	$('#saveLocInfoPop').click(function() {
		$('#locPop').show();
		$('#bg').show();
	});
	
	$('#exitPop').click(function(e){
		e.preventDefault();
		$('#locPop').hide();
		$('#bg').hide();
	});
	
	$('#saveInfo').click(function(e){
		e.preventDefault();
		
		//$('#frm').submit();
		$.get({
			url: "${pageContext.request.contextPath}/kakao/locInfoSave.do",
			data: $('#frm').serialize(),
			success: function(rst){
				console.log("success : "+rst);
			},error: function(){
				console.log("error");
			}
		});
		
		$('#locPop').hide();
		$('#bg').hide();
		
	});

	function noWork() {

		custumMater = new kakao.maps.Marker({
			position : map.getCenter(),
			image : markerImage
		});

		custumMater.setMap(map);

		// 커스텀 오버레이를 생성합니다
		customOverlay = new kakao.maps.CustomOverlay({
			map : map,
			position : map.getCenter(),
			content : content,
			yAnchor : 0.8
		});
	}
	/* 일 하기 싫다 끝 ! */
	//지도 드래그 이벤트
	kakao.maps.event.addListener(map, 'dragend', function() {
		infowindow.close();
		if (cctvOnOff == 'on')
			fn_getCCTVData();
	});

	//지도 확대, 축소 이벤트
	kakao.maps.event.addListener(map, 'zoom_changed', function() {
		infowindow.close();
		if (cctvOnOff == 'on')
			fn_getCCTVData();
	});

	//지도 클릭 이벤트
	kakao.maps.event.addListener(map, 'click', function(mouseEvent) {

		if (noWorkOnOff = 'on') {
			// 클릭한 위도, 경도 정보를 가져옵니다 
			var latlng = mouseEvent.latLng;

			// 마커 위치를 클릭한 위치로 옮깁니다
			custumMater.setPosition(latlng);
			customOverlay.setPosition(latlng);
		}

	});

	$('#selectDiv a').click(function() {
		infowindow.close();
		setMarkers(null); //마커 삭제
		custumMater.setMap(null);
		customOverlay.setMap(null);
		infowindow.close();
		$('#menu_wrap').css('display', 'none');

		$('#noWork').removeClass('active');
		$('#cctv').removeClass('active');
		$('#search').removeClass('active');

		var id = $(this).attr('id');
		console.log(eval(id + 'OnOff'));
		if (eval(id + 'OnOff') == 'off') {
			noWorkOnOff = 'off'
			searchOnOff = 'off';
			cctvOnOff = 'off';

			eval(id + 'OnOff = "on"');

			$(this).addClass('active');

			if (id == 'search')
				$('#menu_wrap').css('display', '');
			else if (id == 'cctv')
				fn_getCCTVData();
			else if (id == 'noWork')
				noWork();
		} else {
			eval(id + 'OnOff = "off"');
			$('#menu_wrap').css('display', 'none');
		}
	});

	//마커 삭제
	function setMarkers(map) {
		for (var i = 0; i < markers.length; i++) {
			kakao.maps.event.removeListener(markers[i], 'click');
			kakao.maps.event.removeListener(markers[i], 'mouseover');
			kakao.maps.event.removeListener(markers[i], 'mouseout');
			markers[i].setMap(map);
		}
		markers = [];
	}
</script>
</body>

</html>
