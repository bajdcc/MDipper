<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	<%@include file="/commons/tag_libs.jsp"%>
<nav class="navbar-default navbar-static-side" role="navigation">
<div class="nav-close">
	<i class="fa fa-times-circle"></i>
</div>
<div class="sidebar-collapse">
	<ul class="nav" id="side-menu">
		<li class="nav-header">
			<div class="dropdown profile-element">
				<span><img alt="image" style="width:66px;height:66px;" class="img-circle"
					src="${image}/profile_small.png" /></span> <a data-toggle="dropdown"
					class="dropdown-toggle" href="#"> <span class="clear"> <span
						class="block m-t-xs"><strong class="font-bold">${userid}</strong></span>
						<span class="text-muted text-xs block">设置<b
							class="caret"></b></span>
				</span>
				</a>
				<ul class="dropdown-menu animated fadeInRight m-t-xs">
					<li><a class="J_menuItem" href="">修改头像</a></li>
					<li><a class="J_menuItem" href="">个人资料</a></li>
					<li><a class="J_menuItem" href="">联系我们</a></li>
					<li><a class="J_menuItem" href="">信箱</a></li>
					<li class="divider"></li>
					<li><a href="${ctx}/account/login">安全退出</a></li>
				</ul>
			</div>
			<div class="logo-element">MD</div>
		</li>
		<li><a href="#"> <i class="fa fa-home"></i> <span
				class="nav-label">主页</span> <span class="fa arrow"></span>
		</a>
			<ul class="nav nav-second-level">
				<li><a class="J_menuItem" href="${ctx}/backend/notice" data-index="0">系统公告</a></li>
				<li><a class="J_menuItem" href="${ctx}/backend/usermanage">用户管理</a></li>
				<li><a class="J_menuItem" href="${ctx}/backend/newsmanage">新闻管理</a></li>
				<li><a class="J_menuItem" href="">企业管理</a></li>
			</ul></li>

	</ul>
</div>
</nav>