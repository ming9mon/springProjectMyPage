<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<head>
<link rel="stylesheet" href="/resources/css/sideBar.css">
</head>
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	
%>

<ul
	class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion toggled"
	id="accordionSidebar">

	<!-- Sidebar - Brand -->
	<a
		class="sidebar-brand d-flex align-items-center justify-content-center"
		href="/">
		<div class="sidebar-brand-icon rotate-n-15">
			<i class="fas fa-laugh-wink"></i>
		</div>
		<div class="sidebar-brand-text mx-3">
			밍구 페이지
			<!-- <sup>2</sup> -->
		</div>
	</a>

	<c:if test="${ sessionScope.loginDto.userId eq 'koo50215' }">
		<!-- Divider -->
		<hr class="sidebar-divider my-0">

		<!-- Nav Item - Dashboard -->
		<li class="nav-item active"><a class="nav-link"
			href="${pageContext.request.contextPath }/management.do"> <i
				class="fas fa-fw fa-tachometer-alt"></i> <span>관리</span></a></li>
	</c:if>

	<!-- Divider -->
	<hr class="sidebar-divider">

	<!-- Heading -->
	<div class="sidebar-heading">개발</div>

	<!-- Nav Item - Pages Collapse Menu -->
	<!-- <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo">
          <i class="fas fa-fw fa-cog"></i>
          <span>Components</span>
        </a>
        <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">Custom Components:</h6>
            <a class="collapse-item" href="buttons.html">Buttons</a>
            <a class="collapse-item" href="cards.html">Cards</a>
          </div>
        </div>
      </li> -->

	<!-- Nav Item - Utilities Collapse Menu -->
	<li class="nav-item"><a class="nav-link" href="/blog.do"> <i class="fas fa-fw fa-tachometer-alt"></i> <span>블로그</span></a></li>
	
	<li class="nav-item"><a class="nav-link collapsed" href="#"
		data-toggle="collapse" data-target="#collapseUtilities"
		aria-expanded="true" aria-controls="collapseUtilities"> <i
			class="fas fa-fw fa-wrench"></i> <span>카카오</span>
	</a>
		<div id="collapseUtilities" class="collapse"
			aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
			<div class="bg-white py-2 collapse-inner rounded">
				<h6 class="collapse-header">카카오 API</h6>
				<a class="collapse-item" href="/kakao/kakaoMap.do">카카오맵</a> <a
					class="collapse-item" href="utilities-border.html">Borders</a> <a
					class="collapse-item" href="utilities-animation.html">Animations</a>
				<a class="collapse-item" href="utilities-other.html">Other</a>
			</div>
		</div>
	</li>

	<li class="nav-item"><a class="nav-link" href="/weather.do"> <i class="fas fa-fw fa-table"></i> <span>날씨</span></a></li>
	<li class="nav-item"><a class="nav-link" href="/boardList.do"> <i class="fas fa-fw fa-folder"></i> <span>게시판</span></a></li>
	<li class="nav-item"><a class="nav-link" href="/calendar.do"> <i class="fas fa-fw fa-table"></i> <span>달력</span></a></li>
	
	<li class="nav-item">
		<a class="nav-link collapsed" href="#"
		data-toggle="collapse" data-target="#collapseUtilities3"
		aria-expanded="true" aria-controls="collapseUtilities3"> 
			<i class="fas fa-fw fa-tachometer-alt"></i> <span>게임</span>
		</a>
		<div id="collapseUtilities3" class="collapse"
			aria-labelledby="headingUtilities3" data-parent="#accordionSidebar">
			<div class="bg-white py-2 collapse-inner rounded">
				<h6 class="collapse-header">게임</h6>
				<a class="collapse-item" href="/game/wormGame.do">지렁이 게임</a>
				<a class="collapse-item" href="/game/tetris.do">테트리스</a>
				<a class="collapse-item" href="/game/game2048.do">2048게임</a>
				<!-- 
				<a class="collapse-item" href="utilities-border.html">Borders</a> 
				<a class="collapse-item" href="utilities-animation.html">Animations</a> -->
			</div>
		</div>
	</li>
	
	<li class="nav-item">
		<a class="nav-link collapsed" href="#"
		data-toggle="collapse" data-target="#collapseUtilities2"
		aria-expanded="true" aria-controls="collapseUtilities"> 
			<i class="fas fa-fw fa-wrench"></i> <span>기타</span>
		</a>
		<div id="collapseUtilities2" class="collapse"
			aria-labelledby="headingUtilities2" data-parent="#accordionSidebar">
			<div class="bg-white py-2 collapse-inner rounded">
				<h6 class="collapse-header">기타</h6>
				<a class="collapse-item" href="/etc/upAndLow.do">대소문자 변환</a> <!-- 
				<a class="collapse-item" href="utilities-border.html">Borders</a> 
				<a class="collapse-item" href="utilities-animation.html">Animations</a> -->
			</div>
		</div>
	</li>
	
	<hr class="sidebar-divider">
	<!-- 
      Heading
      <div class="sidebar-heading">
        	인화
      </div>

      Nav Item - Pages Collapse Menu
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages" aria-expanded="true" aria-controls="collapsePages">
          <i class="fas fa-fw fa-folder"></i>
          <span>Pages</span>
        </a>
        <div id="collapsePages" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">Login Screens:</h6>
            <a class="collapse-item" href="login.html">Login</a>
            <a class="collapse-item" href="register.html">Register</a>
            <a class="collapse-item" href="forgot-password.html">Forgot Password</a>
            <div class="collapse-divider"></div>
            <h6 class="collapse-header">Other Pages:</h6>
            <a class="collapse-item" href="404.html">404 Page</a>
            <a class="collapse-item" href="blank.html">Blank Page</a>
          </div>
        </div>
      </li>

      Nav Item - Charts
      <li class="nav-item">
        <a class="nav-link" href="charts.html">
          <i class="fas fa-fw fa-chart-area"></i>
          <span>Charts</span></a>
      </li>

      Nav Item - Tables
      <li class="nav-item">
        <a class="nav-link" href="tables.html">
          <i class="fas fa-fw fa-table"></i>
          <span>Tables</span></a>
      </li>

      Divider
      <hr class="sidebar-divider d-none d-md-block">
 -->
	<!-- Sidebar Toggler (Sidebar) -->
	<div class="text-center d-none d-md-inline">
		<button class="rounded-circle border-0" id="sidebarToggle"></button>
	</div>

</ul>