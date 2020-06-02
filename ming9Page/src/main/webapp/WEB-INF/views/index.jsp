<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- jstl -->
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

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

<!-- 구글 웹 마스터 인증-->
<meta name="google-site-verification"
	content="16ivVcSesmoxpczP-yZp4F9goKHqERabnOb-5xfHTDs" />
</head>
<body id="page-top">

	<!-- Page Wrapper -->

	<div id="wrapper">

		<!-- Sidebar -->
		<%@include file="/WEB-INF/views/include/sideBar.jsp"%>
		<!-- End of Sidebar -->

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">

				<!-- Topbar -->
				<%@include file="/WEB-INF/views/include/header.jsp"%>
				<!-- End of Topbar -->

				<!-- Begin Page Content -->
				<div class="container-fluid">
					<!-- 날씨 -->
					<div class="row">
						<div class="col-lg-4 mb-4">
							<div class="card shadow mb-4">
								<!-- Card Header - Dropdown -->
								<div
									class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
									<h6 class="m-0 font-weight-bold text-primary">
										<a href="#" id="weather">날씨</a>
									</h6>
								</div>
								<!-- Card Body -->
								<div class="card-body">
									<div class="chart-pie pt-4 pb-2">
										<img
											src="${pageContext.request.contextPath}/resources/img/mainImg/weatherM.png"
											width="100%" height="100%">
									</div>
								</div>
							</div>
						</div>
						<div class="col-lg-4 mb-4">
							<div class="card shadow mb-4">
								<!-- Card Header - Dropdown -->
								<div
									class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
									<h6 class="m-0 font-weight-bold text-primary">
										<a href="#" id="kakaoMap">카카오맵</a>
									</h6>
								</div>
								<!-- Card Body -->
								<div class="card-body">
									<div class="chart-pie pt-4 pb-2">
										<img
											src="${pageContext.request.contextPath}/resources/img/mainImg/kakaoMapM.png"
											width="100%" height="100%">
									</div>
								</div>
							</div>
						</div>
						<%-- <div class="col-lg-4 mb-4">
							<div class="card shadow mb-4">
								<!-- Card Header - Dropdown -->
								<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
									<h6 class="m-0 font-weight-bold text-primary">Revenue Sources</h6>
								</div>
								<!-- Card Body -->
								<div class="card-body">
									<div class="chart-pie pt-4 pb-2">
										<img src="${pageContext.request.contextPath}/resources/img/mainImg/weatherM.png" width="100%" height="100%">
									</div>
								</div>
							</div>
						</div> --%>
					</div>
				</div>
				<!-- /.container-fluid -->

			</div>
			<!-- End of Main Content -->

			<!-- Footer -->
			<%@include file="/WEB-INF/views/include/footer.jsp"%>
			<!-- End of Footer -->

		</div>
		<!-- End of Content Wrapper -->

	</div>
	<!-- End of Page Wrapper -->

	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top"> <i
		class="fas fa-angle-up"></i>
	</a>

	<%@ include file="/WEB-INF/views/include/script.jsp" %>

	<script>
		$(document).ready(function() {

		});

		//페이지 이동 이벤트
		$('#weather').click(function() {
			location.href = "${pageContext.request.contextPath}/weather.do"
		});
		$('#kakaoMap').click(function() {
			location.href = "${pageContext.request.contextPath}/kakao/kakaoMap.do"
		});
	</script>
</body>

</html>
