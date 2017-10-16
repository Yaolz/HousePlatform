<%--
  Created by IntelliJ IDEA.
  User: yao
  Date: 2017/9/1
  Time: 11:06
  To change this template use File | Settings | File Templates.
--%>
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
<div id="center" class="container">
    <%@include file="../main/toubu.jsp" %>
    <div>
        <div class="row">
            <div class="col-xs-2">
            </div>
            <div class="col-xs-8">
                <p class="text-center" style="font-size: 25px;font-family:楷体;">标题：${requestScope.article.title }</p>
                <p class="text-center"><em>${requestScope.article.getArticleType().getName()}类型</em></p>
                <p class="text-center">------${requestScope.article.abstracts }</p>
                    <img style="height:auto;width:750px;" src="<%=path %>/${requestScope.article.logo}"/>
                <p class="text-left" style="font-size: 18px;font-family:楷体;">文章内容：&nbsp;&nbsp;${requestScope.article.content }</p>
                <p class="text-right">发表时间：${requestScope.article.created_time}</p>
            </div>
            <div class="col-xs-2">
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
