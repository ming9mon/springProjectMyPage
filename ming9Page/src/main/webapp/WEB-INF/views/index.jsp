<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<!-- jstl -->
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>




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
	
	<!-- 구글 차트 -->
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	
	<!-- jQuery -->
	<script src="/resources/jQuery/jquery-3.4.1.min.js"></script>


</head>
<body id="page-top">

	<!-- Page Wrapper -->
	
	<div id="wrapper">

		<!-- Sidebar -->
			<%@include file="include/sideBar.jsp" %>
		<!-- End of Sidebar -->

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">
				
				<!-- Topbar -->
				<%@include file="include/header.jsp" %>
				<!-- End of Topbar -->

				<!-- Begin Page Content -->
				<div class="container-fluid">

					<!-- 날씨 -->
					<div>
						<h1 class="h4 mb-0 text-gray-800">날씨</h1>
						<div style="margin-top: 40px">
					      <select class="selectpicker" id="city">
                          </select>
					      <select class="selectpicker" id="gu">
                          </select>
                          <select class="selectpicker" id="dong">
                          </select>
                          <button class="btn" id="weatherBtn">날씨 조회</button>
                        </div>
					</div>
					<!-- 날씨 -->
					<!-- Area Chart -->
						<div style="width: 1000px;">
							<div class="card shadow mb-4">
								<!-- Card Header - Dropdown -->
								<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
									<h6 class="m-0 font-weight-bold text-primary">Earnings Overview</h6>
									<div class="dropdown no-arrow">
										<a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
											<i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
										</a>
										<div class="dropdown-menu dropdown-menu-right shadow animated--fade-in" aria-labelledby="dropdownMenuLink">
											<div class="dropdown-header">Dropdown Header:</div>
											<a class="dropdown-item" href="#">Action</a>
											<a class="dropdown-item" href="#">Another action</a>
											<div class="dropdown-divider"></div>
											<a class="dropdown-item" href="#">Something else here</a>
										</div>
									</div>
								</div>
								<!-- Card Body -->
								<div class="card-body" style="height: 500px;">
									<div class="chart-area">
										<!-- 구글 차트 표시 -->
										<div id="today_weather_chart" ></div>
										<div id="tomorrow_weather_chart" ></div>
									</div>
								</div>
							</div>
						</div>
					<br><br><br><br><br>
					
					
					
					
					
					
					
					
					
					<!-- Content Row -->
					<div class="row">

						<!-- Earnings (Monthly) Card Example -->
						<div class="col-xl-3 col-md-6 mb-4">
							<div class="card border-left-primary shadow h-100 py-2">
								<div class="card-body">
									<div class="row no-gutters align-items-center">
										<div class="col mr-2">
											<div class="text-xs font-weight-bold text-primary text-uppercase mb-1">Earnings (Monthly)</div>
											<div class="h5 mb-0 font-weight-bold text-gray-800">$40,000</div>
										</div>
										<div class="col-auto">
											<i class="fas fa-calendar fa-2x text-gray-300"></i>
										</div>
									</div>
								</div>
							</div>
						</div>

						<!-- Earnings (Monthly) Card Example -->
						<div class="col-xl-3 col-md-6 mb-4">
							<div class="card border-left-success shadow h-100 py-2">
								<div class="card-body">
									<div class="row no-gutters align-items-center">
										<div class="col mr-2">
											<div class="text-xs font-weight-bold text-success text-uppercase mb-1">Earnings (Annual)</div>
											<div class="h5 mb-0 font-weight-bold text-gray-800">$215,000</div>
										</div>
										<div class="col-auto">
											<i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
										</div>
									</div>
								</div>
							</div>
						</div>

						<!-- Earnings (Monthly) Card Example -->
						<div class="col-xl-3 col-md-6 mb-4">
							<div class="card border-left-info shadow h-100 py-2">
								<div class="card-body">
									<div class="row no-gutters align-items-center">
										<div class="col mr-2">
											<div class="text-xs font-weight-bold text-info text-uppercase mb-1">Tasks</div>
											<div class="row no-gutters align-items-center">
												<div class="col-auto">
													<div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">50%</div>
												</div>
												<div class="col">
													<div class="progress progress-sm mr-2">
														<div class="progress-bar bg-info" role="progressbar" style="width: 50%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
													</div>
												</div>
											</div>
										</div>
										<div class="col-auto">
											<i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
										</div>
									</div>
								</div>
							</div>
						</div>

						<!-- Pending Requests Card Example -->
						<div class="col-xl-3 col-md-6 mb-4">
							<div class="card border-left-warning shadow h-100 py-2">
								<div class="card-body">
									<div class="row no-gutters align-items-center">
										<div class="col mr-2">
											<div class="text-xs font-weight-bold text-warning text-uppercase mb-1">Pending Requests</div>
											<div class="h5 mb-0 font-weight-bold text-gray-800">18</div>
										</div>
										<div class="col-auto">
											<i class="fas fa-comments fa-2x text-gray-300"></i>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

					<!-- Content Row -->

					<div class="row">

						

						<!-- Pie Chart -->
						<div class="col-xl-4 col-lg-5">
							<div class="card shadow mb-4">
								<!-- Card Header - Dropdown -->
								<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
									<h6 class="m-0 font-weight-bold text-primary">Revenue Sources</h6>
									<div class="dropdown no-arrow">
										<a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
											<i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
										</a>
										<div class="dropdown-menu dropdown-menu-right shadow animated--fade-in" aria-labelledby="dropdownMenuLink">
											<div class="dropdown-header">Dropdown Header:</div>
											<a class="dropdown-item" href="#">Action</a>
											<a class="dropdown-item" href="#">Another action</a>
											<div class="dropdown-divider"></div>
											<a class="dropdown-item" href="#">Something else here</a>
										</div>
									</div>
								</div>
								<!-- Card Body -->
								<div class="card-body">
									<div class="chart-pie pt-4 pb-2">
										<canvas id="myPieChart"></canvas>
									</div>
									<div class="mt-4 text-center small">
										<span class="mr-2">
											<i class="fas fa-circle text-primary"></i> Direct
										</span>
										<span class="mr-2">
											<i class="fas fa-circle text-success"></i> Social
										</span>
										<span class="mr-2">
											<i class="fas fa-circle text-info"></i> Referral
										</span>
									</div>
								</div>
							</div>
						</div>
					</div>

					<!-- Content Row -->
					<div class="row">

						<!-- Content Column -->
						<div class="col-lg-6 mb-4">

							<!-- Project Card Example -->
							<div class="card shadow mb-4">
								<div class="card-header py-3">
									<h6 class="m-0 font-weight-bold text-primary">Projects</h6>
								</div>
								<div class="card-body">
									<h4 class="small font-weight-bold">Server Migration <span class="float-right">20%</span></h4>
									<div class="progress mb-4">
										<div class="progress-bar bg-danger" role="progressbar" style="width: 20%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100"></div>
									</div>
									<h4 class="small font-weight-bold">Sales Tracking <span class="float-right">40%</span></h4>
									<div class="progress mb-4">
										<div class="progress-bar bg-warning" role="progressbar" style="width: 40%" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100"></div>
									</div>
									<h4 class="small font-weight-bold">Customer Database <span class="float-right">60%</span></h4>
									<div class="progress mb-4">
										<div class="progress-bar" role="progressbar" style="width: 60%" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100"></div>
									</div>
									<h4 class="small font-weight-bold">Payout Details <span class="float-right">80%</span></h4>
									<div class="progress mb-4">
										<div class="progress-bar bg-info" role="progressbar" style="width: 80%" aria-valuenow="80" aria-valuemin="0" aria-valuemax="100"></div>
									</div>
									<h4 class="small font-weight-bold">Account Setup <span class="float-right">Complete!</span></h4>
									<div class="progress">
										<div class="progress-bar bg-success" role="progressbar" style="width: 100%" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
									</div>
								</div>
							</div>

							<!-- Color System -->
							<div class="row">
								<div class="col-lg-6 mb-4">
									<div class="card bg-primary text-white shadow">
										<div class="card-body">
											Primary
											<div class="text-white-50 small">#4e73df</div>
										</div>
									</div>
								</div>
								<div class="col-lg-6 mb-4">
									<div class="card bg-success text-white shadow">
										<div class="card-body">
											Success
											<div class="text-white-50 small">#1cc88a</div>
										</div>
									</div>
								</div>
								<div class="col-lg-6 mb-4">
									<div class="card bg-info text-white shadow">
										<div class="card-body">
											Info
											<div class="text-white-50 small">#36b9cc</div>
										</div>
									</div>
								</div>
								<div class="col-lg-6 mb-4">
									<div class="card bg-warning text-white shadow">
										<div class="card-body">
											Warning
											<div class="text-white-50 small">#f6c23e</div>
										</div>
									</div>
								</div>
								<div class="col-lg-6 mb-4">
									<div class="card bg-danger text-white shadow">
										<div class="card-body">
											Danger
											<div class="text-white-50 small">#e74a3b</div>
										</div>
									</div>
								</div>
								<div class="col-lg-6 mb-4">
									<div class="card bg-secondary text-white shadow">
										<div class="card-body">
											Secondary
											<div class="text-white-50 small">#858796</div>
										</div>
									</div>
								</div>
							</div>

						</div>

						<div class="col-lg-6 mb-4">

							<!-- Illustrations -->
							<div class="card shadow mb-4">
								<div class="card-header py-3">
									<h6 class="m-0 font-weight-bold text-primary">Illustrations</h6>
								</div>
								<div class="card-body">
									<div class="text-center">
										<img class="img-fluid px-3 px-sm-4 mt-3 mb-4" style="width: 25rem;" src="resources/img/undraw_posting_photo.svg" alt="">
									</div>
									<p>Add some quality, svg illustrations to your project courtesy of <a target="_blank" rel="nofollow" href="https://undraw.co/">unDraw</a>, a constantly updated collection of beautiful svg images that you can use completely free and without attribution!</p>
									<a target="_blank" rel="nofollow" href="https://undraw.co/">Browse Illustrations on unDraw &rarr;</a>
								</div>
							</div>

							<!-- Approach -->
							<div class="card shadow mb-4">
								<div class="card-header py-3">
									<h6 class="m-0 font-weight-bold text-primary">Development Approach</h6>
								</div>
								<div class="card-body">
									<p>SB Admin 2 makes extensive use of Bootstrap 4 utility classes in order to reduce CSS bloat and poor page performance. Custom CSS classes are used to create custom components and custom utility classes.</p>
									<p class="mb-0">Before working with this theme, you should become familiar with the Bootstrap framework, especially the utility classes.</p>
								</div>
							</div>

						</div>
					</div>

				</div>
				<!-- /.container-fluid -->

			</div>
			<!-- End of Main Content -->

		<!-- Footer -->
		<%@include file="include/footer.jsp" %>
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

	<!-- Page level plugins -->
	<script src="/resources/vendor/chart.js/Chart.min.js"></script>

	<!-- Page level custom scripts -->
	<script src="/resources/js/demo/chart-area-demo.js"></script>
	<script src="/resources/js/demo/chart-pie-demo.js"></script>

	<script>
		$(document).ready(function(){
			
			//구글 차트 
			google.charts.load('current', {'packages':['corechart']});
			
			
			//초기 시, 구, 동 세팅
			setCity();
			setGu(11,11530);
			setDong(11530,1153055000);
			
			//구글 차트 그리기
			getWeather();
			
			//시 선택시 구,동 selectBox 내용 병경
			$('#city').change(function(){
				setGu($('#city option:selected').val());
				setDong($('#gu option:selected').val());
			});
			
			//구 선택시 동 selectBox 내용 변경
			$('#gu').change(function(){
				setDong($('#gu option:selected').val());
			});
			
			

			//날씨 조회버튼 클릭 시
			$('#weatherBtn').click(function(e){
				e.preventDefault();
				getWeather();
			});
			
			function getWeather(){
				$.ajax({
					url: "${pageContext.request.contextPath}/getWeather",
					type: "GET",
					data:{
						"guCode": $('#gu option:selected').val(),
						"dongCode": $('#dong option:selected').val()
					},
					success: function(result){
						console.log(result);
						google.charts.setOnLoadCallback(drawChart1);
						google.charts.setOnLoadCallback(drawChart2);
						function drawChart1() {
							var data = google.visualization.arrayToDataTable([
							 	['time', '온도'],
							    ['03',  Number(result[0].temperature)],
							    ['06',  Number(result[1].temperature)],
							    ['09',  Number(result[2].temperature)],
							    ['12',  Number(result[3].temperature)],
							    ['15',  Number(result[4].temperature)],
							    ['18',  Number(result[5].temperature)],
							    ['21',  Number(result[6].temperature)],
							    ['24',  Number(result[7].temperature)]
							  ]);
							
							var options = {
								title: '오늘 날씨',
						  		curveType: 'function',
						  		legend: { position: 'bottom' }
							};
							
						
							var chart = new google.visualization.LineChart(document.getElementById('today_weather_chart'));
						
							chart.draw(data, options);
						}
						
						function drawChart2() {
							var data = google.visualization.arrayToDataTable([
							 	['time', '온도'],
							    ['00',  Number(result[7].temperature)],
							    ['03',  Number(result[8].temperature)],
							    ['06',  Number(result[9].temperature)],
							    ['09',  Number(result[10].temperature)],
							    ['12',  Number(result[11].temperature)],
							    ['15',  Number(result[12].temperature)],
							    ['18',  Number(result[13].temperature)],
							    ['21',  Number(result[14].temperature)]
							  ]);
							
							
							var options = {
								title: '내일 날씨',
						  		curveType: 'function',
						  		legend: { position: 'bottom' }
							};
						
							var chart = new google.visualization.LineChart(document.getElementById('tomorrow_weather_chart'));
						
							chart.draw(data, options);
						}
						
					}
				});
			}
			
			//시의 selectBox옵션 세팅 함수
			function setCity(){
				$.ajax({
					url : "${pageContext.request.contextPath}/getCity",
					type: "GET",
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
			
			//구의 selectBox옵션 세팅 함수		동기식
			function setGu(cityCode,setSelected){
				$.ajax({
					url: "${pageContext.request.contextPath}/getGu",
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
							$('#gu').val(setSelected).attr("selected","selected");
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
					url: "${pageContext.request.contextPath}/getDong",
					type: "GET",
					async: false,
					data: {
						"guCode": guCode
					},
					success: function(data){
						var dong = jQuery.parseJSON(data);
						var html="";
						for(var i=0;i<dong.length;i++){
							html+="<option value='"+dong[i].code+"'>"+dong[i].value+"</option>";
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
			
			

		});
	</script>
</body>

</html>
