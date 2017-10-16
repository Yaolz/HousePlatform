<%--
  Created by IntelliJ IDEA.
  User: ID.LQF
  Date: 2017/8/28
  Time: 8:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%><!DOCTYPE html>
<html>
<head>
    <title>经销商员工登入页面</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="<%=path%>/public/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container">
    <div class=" row">
        <div class="col-lg-8 col-lg-offset-2  col-xs-12 col-md-10 col-md-offset-1   col-sm-12">
            <form style="margin-top: 200px" class="  form-horizontal " role="form" id="form">
                <div class="form-group">
                    <label for="phone" class="col-sm-2  control-label">用 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 户 :</label>
                    <div class="col-sm-10  input-parent">
                        <input type="text" class="form-control vinput" id="phone" name="employee.email" placeholder="请输入邮箱">
                        <span></span>
                    </div>
                </div>
                <div class="form-group ">
                    <label for="password" class="col-sm-2  control-label">密 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 码 :</label>
                    <div class="col-sm-10  input-parent">
                        <input type="password" class="form-control vinput" id="password" name="employee.pwd" placeholder="请输入密码"/>
                        <i class="glyphicon glyphicon-eye-close form-control-feedback" id="toogle-password"></i>
                        <span></span>
                    </div>
                </div>
                <br>
                <div class="form-group">
                    <div class="col-sm-12">
                        <input type="button" class="btn btn-primary form-control"  value="登入" onclick="login();"/>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
<script src="<%=path%>/public/js/jquery.min.js"></script>
<script>
    function login() {
        $.post("<%=path %>/staff/login",
            $("#form").serialize(),
            function (data) {
                if (data.result.result == "success") {
                    window.location.href= "/staff/home";
                } else {
                    alert(data.result.msg);
                }
            }, "json"
        );
    }
</script>
</html>
