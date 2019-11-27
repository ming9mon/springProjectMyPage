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

<title>밍구 페이지</title>

<!-- Custom fonts for this template-->
<link href="/resources/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="/resources/css/sb-admin-2.min.css" rel="stylesheet">

<!-- jQuery -->
<script src="/resources/jQuery/jquery-3.4.1.min.js"></script>

<!-- Common JS -->
<script src="/resources/js/common.js"></script>

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

					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">게시판</h6>
						</div>
						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered" id="dataTable" width="100%"
									cellspacing="0">
									<colgroup>
										<col style="width: 25%;">
										<col style="width: 50%;">
										<col style="width: 25%;">
									</colgroup>
									<thead>
										<tr>
											<th style="min-width: 240px;">닉네임</th>
											<th style="min-width: 300px;">제목</th>
											<th style="min-width: 240px;">작성일</th>
										</tr>
									</thead>

									<tbody>
									</tbody>
								</table>
							</div>
						</div>
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

	<!-- Bootstrap core JavaScript-->
	<script src="/resources/vendor/jquery/jquery.min.js"></script>
	<script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script src="/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="/resources/js/sb-admin-2.min.js"></script>

	<script>
		var pageNo = 1;

		getBoardList();

		function getBoardList() {
			$.get({
				url : '${pageContext.request.contextPath}/getBoardList.do',
				success : function(rst) {
					$('#dataTable tbody').html('<tr><td colspan="3">등록된 글이 없습니다.</td></tr>');

					if(rst.RTNCD == 0){
						var data = rst.RST;
						setTbl(data);
					}
				},
				error : function(e) {
					alert("getBoardList ERROR");
				}
			});
		}
		
		//테이블 세팅
		function setTbl(data){
			if(data.length > 0){
				$('#dataTable tbody').empty();
				
				for(var i=0;i<data.length;i++){
					var nickName = data[i].nickName;
					var title = data[i].title;
					var date = new Date(data[i].writeDte);
					
					var html = "<tr>";
					html += "<td>"+nickName+"</td>";
					html += "<td>"+title+"</td>";
					html += "<td>"+date.format("yyyy년 MM월 dd일 HH시 mm분")+"</td>";
					html += "</tr>";
					
					$('#dataTable tbody').append(html);
				}
			}
		}

		$(document).ready(function() {

		});
	</script>
</body>

</html>
