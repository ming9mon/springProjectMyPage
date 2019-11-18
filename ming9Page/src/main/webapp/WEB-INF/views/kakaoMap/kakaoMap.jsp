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
	
	<!-- Common JS -->
	<script src="${pageContext.request.contextPath}/resources/js/common.js"></script>
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

				<!-- Begin Page Content 지도 -->
				<div class="container-fluid">
					<!-- Area Chart -->
					<div class="card shadow mb-4" style="min-width: 800px;">
						<!-- Card Header - Dropdown -->
						<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
							<h6 class="m-0 font-weight-bold text-primary">카카오 MAP</h6>
							
							<!-- drop down -->
							<div class="dropdown no-arrow">
								<a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
									<i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
								</a>
								<div class="dropdown-menu dropdown-menu-right shadow animated--fade-in" aria-labelledby="dropdownMenuLink">
									<div class="dropdown-header">기능</div>
									<a class="dropdown-item" href="#" id="cctv">CCTV<span id="cctvOnOff"></span></a>
									<a class="dropdown-item" href="#" >Another action</a>
									<div class="dropdown-divider"></div>
									<a class="dropdown-item" href="#">Something else here</a>
								</div>
							</div>
						</div>
						<!-- Card Body -->
						<div class="card-body">
							<div id="map" style="width:100%;height:500px;"></div>
						</div>
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

	
<!-- Bootstrap core JavaScript-->
<script src="/resources/vendor/jquery/jquery.min.js"></script>
<script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script src="/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="/resources/js/sb-admin-2.min.js"></script>

<!-- Kakao API -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ed639b8f650bd5b8dc3dceb7c3c64e67"></script>
<script>
var cctvOnOff='off';
var cctvMakers=[];
var infowindow = new kakao.maps.InfoWindow();

var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
var options = { //지도를 생성할 때 필요한 기본 옵션
	center: new kakao.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
	level: 6 //지도의 레벨(확대, 축소 정도)
};

var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴

//CCTV DATA GET
function fn_getCCTVData(){
	var bounds = map.getBounds();			// 지도 영역정보를 얻어옵니다 
	if(cctvOnOff == 'on'){
		$.ajax({
			url: '${pageContext.request.contextPath}/kakao/getCCTVData.do',
			type: 'GET',
			data: {
				minX: bounds.ea,
				maxX: bounds.ja,
				minY: bounds.la,
				maxY: bounds.ka
			},success : function(rst){
				infowindow.close();
				setMarkers(null);	//마커 삭제
				if(rst.RTNCD == 0){
					fn_setCCTV(rst.RST);
				}
			},error: function(e){
				alert('cctvData ERROR');
			}
			
		});
	}
}

//CCTV DATA SET
function fn_setCCTV(data){
	var dataSize = data.length;
	var level = map.getLevel();
	
	var idx=1;
	if (dataSize >50 && level > 6){
		if(dataSize < 500){
			idx=3;
		}else if(dataSize < 1000){
			idx=10;
		}else if(dataSize < 2000){
			idx=20;
		}else if(dataSize < 3000){
			idx=30;
		}else{
			idx=50;
		}
	}
	
	for(var i=0;i<data.length;i+=idx){
		var x = data[i].coordx;
		var y = data[i].coordy;
		
		var imageSrc = '${pageContext.request.contextPath}/resources/img/cctv_on.png', // 마커이미지의 주소입니다    
	    imageSize = new kakao.maps.Size(30, 30), // 마커이미지의 크기입니다
	    imageOption = {offset: new kakao.maps.Point(10, 20)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
	      
		// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
		var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption)
		var markerPosition  = new kakao.maps.LatLng(y,x); 
		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
		    position: markerPosition,
		    image: markerImage // 마커이미지 설정 
		});
		
		
		marker.setMap(map);
		marker.K = data[i].cctvname+'||'+data[i].cctvurl;
		cctvMakers.push(marker);
		kakao.maps.event.addListener(marker, 'click', makeClickListener(map, marker));
		kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker));
	    kakao.maps.event.addListener(marker, 'mouseout', makeOutListener());
	}
	
}

//cctv 아이콘 클릭 클릭 이벤트
function makeClickListener(map, marker) {
	
    return function() {
    	var data = marker.K.split('||');
    	var infowindow = new kakao.maps.InfoWindow({// 마커에 표시할 인포윈도우를 생성
	        content: "<div>"+data[0]+"</div><video src='"+data[1]+"' autoplay=\"autoplay\" data-id=\"video\" width='300' heigth='300'>dd</video>"
	        // 인포윈도우에 표시할 내용
	    });
        infowindow.open(map, marker);
        setTimeout(function(){
        	infowindow.close();
        },5000);
    };
}

//인포윈도우를 표시하는 클로저를 만드는 함수
function makeOverListener(map, marker) {
    return function() {
    	var data = marker.K.split('||');
    	infowindow = new kakao.maps.InfoWindow({// 마커에 표시할 인포윈도우를 생성
	        content: "<div>"+data[0]+"</div>"
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

//지도 드래그 이벤트
kakao.maps.event.addListener(map, 'dragend', function() {
	fn_getCCTVData();
});

//지도 확대, 축소 이벤트
kakao.maps.event.addListener(map, 'zoom_changed', function() {
	fn_getCCTVData();
});

//cctv 클릭 이벤트
$('#cctv').click(function(){
	if(cctvOnOff == 'off'){
		cctvOnOff = 'on';
		$(this).addClass('on');
		fn_getCCTVData();
	}else{
		cctvOnOff='off'
		$(this).removeClass('on');
		infowindow.close();
		setMarkers(null);	//마커 삭제
	}
	console.log();
});

function setMarkers(map) {
    for (var i = 0; i < cctvMakers.length; i++) {
	    	kakao.maps.event.removeListener(cctvMakers[i], 'click');
	    	cctvMakers[i].setMap(map);
    }
    cctvMakers=[];
}
 
</script>
</body>

</html>
