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

							<div class="container">
								<div class="row">
									<form style="width: 80%;"
										class="d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
										<div class="input-group">
											<input type="text"
												class="form-control bg-light border-0 small"
												placeholder="Search for..." aria-label="Search"
												aria-describedby="basic-addon2">
											<div class="input-group-append">
												<button class="btn btn-primary" type="button">
													<i class="fas fa-search fa-sm"></i>
												</button>
											</div>
										</div>
									</form>
									<a style="height: 40px;"
										class="btn btn-secondary btn-icon-split" id="write" href="#"> <span
										class="text">글 쓰기</span>
									</a>
								</div>
							</div>

							<div class="table-responsive" style="margin-top: 20px;">
								<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
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
								<div class="row">
									<div class="col-sm-12 col-md-7">
										<div class="dataTables_paginate paging_simple_numbers"
											id="dataTable_paginate">
											<ul class="pagination" id="pagination">
											</ul>
										</div>
									</div>
								</div>
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
		var data;

		getBoardList();

		function getBoardList() {
			$.get({
				url : '${pageContext.request.contextPath}/getBoardList.do',
				success : function(rst) {
					if (rst.RTNCD == 0) {
						data = rst.RST;
						setTbl();
					}
				},
				error : function(e) {
					alert("getBoardList ERROR");
				}
			});
		}

		//테이블 세팅
		function setTbl() {
			
			
			//이전 다음 버튼 생성
			$("#pagination").empty();

			var btnId = ['dataTable_previous','dataTable_next'];
			var btnText = ['이전','다음'];
			
			for(var i=0;i<2;i++){
				var html = '<li class="paginate_button page-item previous disabled" id="'+btnId[i]+'">';
				html += '<a tabindex="0"class="page-link" aria-controls="dataTable" href="#">'+btnText[i]+'</a></li>';
				
				$(html).appendTo("#pagination");
			}
			
			if (data.length > 0) {
				
				if(pageNo < 1) pageNo=1;
				else if(pageNo > Math.ceil(data.length/10)) {
					pageNo = Math.ceil(data.length/10);
				}
				
				$('#dataTable tbody').empty();

				var start = (pageNo - 1) * 10;
				var end = start + 10;

				if (end > data.length)
					end = data.length;

				for (var i = start; i < end; i++) {
					var nickName = data[i].nickName;
					var title = data[i].title;
					var date = new Date(data[i].writeDte);

					var html = "<tr>";
					html += "<td>" + nickName + "</td>";
					html += "<td>" + title + "</td>";
					html += "<td>" + date.format("yyyy년 MM월 dd일 HH시 mm분") + "</td>";
					html += "</tr>";

					$('#dataTable tbody').append(html);
				}
				
				
				//하단 버튼 생성 및 설정
				var btnStart = Math.floor(pageNo/5)+5;
				if (btnStart == 5) btnStart = 1;
				var btnEnd = btnStart+5;
				
				if(btnEnd > Math.ceil(data.length/10)) {
					btnEnd = Math.ceil(data.length/10)+1; 
				}

				for(var i=btnStart;i<btnEnd;i++){
					var html='<li class="paginate_button page-item" id="btn'+i+'">';
					html += '<a tabindex="0" class="page-link" aria-controls="dataTable" href="#" data-dt-idx="'+i+'">';
					html += i;
					html += "</a></li>";
					
					$(html).insertBefore('#dataTable_next');
				}
				//바튼 active 설정
				$('#btn'+pageNo).addClass('active');
				
				//이전 글이 없으면 disabled
				if(pageNo == 1)	$('#dataTable_previous').addClass("disabled");
				else $('#dataTable_previous').removeClass("disabled");
				
				//다음 글이 없으면 disabled
				if(Math.ceil(data.length/10) <= pageNo) $('#dataTable_next').addClass("disabled");
				else $('#dataTable_next').removeClass("disabled");
				
			} else {
				$('#dataTable tbody').html(
						'<tr><td colspan="3">등록된 글이 없습니다.</td></tr>');
			}
		}
		
		//page버튼 클릭 이벤트
		$(document).on('click','.page-link',function(){
			var text = $(this).text();

			if(text == '다음') Math.floor(pageNo/5)+5;
			else if(text == '이전') pageNo-=5;
			else pageNo=text;
			
			setTbl();
		});
		
		$('#write').click(function(){
			if('${sessionScope.loginDto.usrIdx}' == '')	{
				alert('로그인 후 이용 가능합니다.');
				return;
			}
			location.href="/board/writeFrm.do";
		});
	</script>
</body>

</html>
