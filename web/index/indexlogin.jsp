<%--
  Created by IntelliJ IDEA.
  User: yao
  Date: 2017/8/26
  Time: 8:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%><!DOCTYPE html>
<html>
<head>
    <title>Title</title>
    <link rel='stylesheet' href='<%=path %>/public/css/bootstrap.min.css'>
    <link rel='stylesheet' href='<%=path %>/public/admin/css/login.css'>
</head>
<body >
<input type="hidden" id="path" value="<%=path%>">
<div class="container">
    <div class="row">
        <div class="col-md-offset-3 col-md-6">
            <form id="signupForm" class="form-horizontal">
                <span class="heading">用户登入</span>
                <div class="form-group">
                    <input type="text" class="form-control" id="email" name="email" placeholder="请输入你的邮箱或手机号"/>
                    <label id="email-error" class="error" for="email" style="color: red; display: none;">请输入用户名</label>
                </div>
                <div class="form-group help">
                    <input type="password" class="form-control" id="pwd" name="pwd" placeholder="请输入密码" />
                    <label id="pwd-error" class="error" for="pwd"  style="color: red; display: none;">请输入密码</label>
                </div>
                <div class="form-group">
                    <input type="button" class="btn btn-default" id="submit" value="登录"  />
                </div>
            </form>
        </div>
    </div>
</div>
</body>
<script src="<%=path %>/public/js/jquery.min.js"></script>
<script src="<%=path %>/public/js/bootstrap.min.js"></script>
<script src="<%=path %>/layer-v3.1.0/layer/layer.js"></script>
<script type="text/javascript" src="<%=path%>/public/agency/js/jquery-validate.js"></script>
<script src="<%=path %>/index/js/index-login.js"></script>
</html>
