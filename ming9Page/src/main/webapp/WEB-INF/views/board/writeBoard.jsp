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
					<article>
					<div class="container" role="main">
						<h2>글 쓰기</h2>
						<form name="frm" id="frm" role="form" method="post"
							action="${pageContext.request.contextPath}/board/saveBoard">
							<input type="hidden" name="usrIdx" value="${sessionScope.loginDto.usrIdx }">
							<div class="mb-3">
								<label for="title">제목</label> <input type="text"
									class="form-control" name="title" id="title"
									placeholder="제목을 입력해 주세요">
							</div>
							<div class="mb-3">
								<label for="reg_id">작성자</label> <input type="text"
									class="form-control" name="nickName" id="nickName"
									value="${sessionScope.loginDto.nickName}" readonly >
							</div>
							<div class="mb-3">
								<label for="reg_id">비밀글 <input type="checkBox"
									class="form-control" name="secret" id="secret" value="Y" >
								</label>
							</div>
							<div class="mb-3">
								<label for="content">내용</label>
								<textarea class="form-control" rows="5" name="content" id="contents" placeholder="내용을 입력해 주세요"></textarea>
							</div>
						</form>
						<div>
							<button type="button" class="btn btn-sm btn-primary" id="btnSave">저장</button>
							<button type="button" class="btn btn-sm btn-primary" id="btnList">목록</button>
						</div>
					</div>
				</article>

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
		$('#btnList').click(function(e){location.href="${pageContext.request.contextPath}/boardList.do"});
		$('#btnSave').click(function(){
			
			//널 체크
			if(nullCk($('#title').val())){
				$('#title').focus();
				alert('제목을 입력해 주세요');
				return;
			}
			if(nullCk($('#contents').val())){
				$('#contents').focus();
				alert('내용을 입력해 주세요');
				return;
			}
			
			console.log($('#frm').serialize());
			
			$.post({
				url:"${pageContext.request.contextPath}/board/write.do",
				data:$('#frm').serialize(),
				success:function(rst){
					if(rst){
						alert("글이 성공적으로 작성되었습니다.");
						location.href="/boardList.do";
					}
					else alert("글 작성 실패");
				},
				error:function(e){
					alert("글 작성 실패");
				}
			});
			
		});
		
	</script>
</body>

</html>
