<%--
  Created by IntelliJ IDEA.
  User: yao
  Date: 2017/8/26
  Time: 8:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%--
  Created by IntelliJ IDEA.
  User: yao
  Date: 2017/8/11
  Time: 11:51
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
    <script src="<%=path %>/public/tanchuang/sweetalert-master/dist/sweetalert-dev.js"></script>
    <link rel="stylesheet" href="<%=path %>/public/tanchuang/sweetalert-master/dist/sweetalert.css">
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-offset-3 col-md-6">
            <form id="adminLogin" class="form-horizontal">
                <span class="heading">管理员登录</span>
                <div class="form-group">
                    <input type="text" class="form-control" id="email" name="admin.email" placeholder="请输入邮箱"/>
                    <span id="errorEmail"style="color: red"></span>
                </div>
                <div class="form-group help">
                    <input type="password" class="form-control" id="pwd" name="admin.pwd" placeholder="请输入密码" />
                    <span id="errorPwd" style="color: red;"></span>
                </div>
                <div class="form-group">
                    <input type="button" class="btn btn-default" value="登录"  onclick="adminLogin();" />
                </div>
            </form>
        </div>
    </div>
</div>
</body>
<script src="<%=path %>/public/js/jquery.min.js"></script>
<script src="<%=path%>/public/admin/js/admin.js"></script>
<script>
    $(document).ready(function() {
        $("#email").blur(function() {
            var email=$("#email").val();
            var errorEmail=$("#errorEmail");
            if (email.length <= 0) {
                errorEmail.text("邮箱不能为空，请输入邮箱");
            } else {
            }
        });
    });
    $(document).ready(function() {
        $("#pwd").blur(function() {
            var pwd=$("#pwd").val();
            var errorPwd=$("#errorPwd");
            if (pwd.length <= 0) {
                errorPwd.text("密码不能为空，请输入密码");
            } else {
            }
        });
    });
</script>
</html>
