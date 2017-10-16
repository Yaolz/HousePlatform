<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<input type="hidden" id="path" value="<%=path%>">
<nav  class="navbar navbar-default navbar-static-top">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar"
                    aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="<%=request.getContextPath()%>/index/index"><img
                    src="<%=request.getContextPath()%>/images/logo_left.png"/></a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li><a href="<%=request.getContextPath()%>/index/index">首页</a></li>
                <li>
                    <a href="<%=path %>/index/buildingspage">楼盘查看 <span></span></a>
                </li>
                <li>
                    <a href="<%=path %>/index/housepage">户型大全 <span></span></a>
                </li>
                <li>
                    <a href="<%=path %>/index/Informationpage">资讯中心 <span></span></a>
                </li>
                <li>
                    <a href="<%=path %>/index/activitypage">活动中心 <span></span></a>
                </li>
            </ul>

            <ul ng-show="user.id == null" class="nav navbar-nav navbar-right">
                <li>
                    <a href="<%=request.getContextPath()%>/index/indexRegister">注册</a>
                </li>
                <li>
                    <a href="javascript:;" id="login" >登录</a>
                </li>
            </ul>
            <ul ng-show="user.id != null " class="nav navbar-nav navbar-right">
                <li id="fat-menu">
                    <a id="drop3" class="dropdown-toggle" data-toggle="dropdown" role="button"
                       aria-haspopup="true" aria-expanded="false">
                        <img class="img-circle" src="<%=path%>/{{user.headicon}}" data-holder-rendered="true"
                             style="width: 30px; height: 30px;">
                        <span></span>
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="drop3">
                        <li><a href="">昵称:{{user.nickname}}</a></li>

                        <li><a href="<%=request.getContextPath()%>/user/home"  target="_Blank">个人中心</a></li>
                        <li><a href="<%=request.getContextPath()%>/index/remove">安全退出</a></li>
                    </ul>
                </li>
            </ul>
        </div><!--/.nav-collapse -->
    </div>
</nav>
</div>