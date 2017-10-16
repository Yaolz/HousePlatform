
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%><!DOCTYPE html>
<html>
<head>
    <title>Title</title>
</head>
<link href="<%=path%>/public/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=path%>/public/admin/css/admincheck.css" rel="stylesheet">
<script src="<%=path%>/public/angular/angular.min.js"></script>
<body>
<div id="center">
    <%@include file="../main/toubu.jsp" %>
    <div class="container">
        <div class="row">
            <div class="col-xs-3">
            </div>
            <div class="col-xs-6 text-center">
                <p class="text-center" style="font-size: 25px;font-family:楷体;">${requestScope.activity.title }</p>
                <img style="height:auto;width:526px;" class="img-responsive" src="<%=path %>/${requestScope.activity.logo}"/>
                <p class="text-left" style="font-size: 18px;font-family:楷体;">${requestScope.activity.content }</p>
                <p class="text-right">地址：${requestScope.activity.address}</p>
                <p class="text-right">
                    <span class="text-right">开始时间：${requestScope.activity.start_time}</span>
                    <span  class="text-right">结束时间：${requestScope.activity.end_time}</span>
                </p>

            </div>
            <div class="col-xs-3">
            </div>
        </div>
    </div>
</div>
<%@include file="../main/banquan.jsp" %>
</body>
<script src="<%=path%>/public/js/jquery.min.js"></script>
<script src="<%=path%>/public/js/bootstrap.min.js"></script>
<script src="<%=path %>/layer-v3.1.0/layer/layer.js"></script>
<script src="<%=path%>/index/js/index.js"></script>
<script src="<%=path%>/index/js/index-login1.js"></script>
</html>
