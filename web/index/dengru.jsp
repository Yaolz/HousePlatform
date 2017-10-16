<%--
  Created by IntelliJ IDEA.
  User: 娃娃鱼
  Date: 2017/9/11
  Time: 10:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%><!DOCTYPE html>
<html>
<head>
    <title>Title</title>
    <link href="<%=path %>/public/css/bootstrap.min.css"/>
</head>
<body>
<a href="<%=path %>/user/regPage">用户登录</a><br/>
<a href="<%=path %>/agency/register">经销商登录</a><br/>
<a href="<%=path %>/staff/regPage">员工登录</a><br/>
<a>管理员登录？不存在的！</a>
</body>
</html>
