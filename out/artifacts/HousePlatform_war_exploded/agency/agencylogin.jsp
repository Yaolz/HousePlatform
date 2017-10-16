<%--
  Created by IntelliJ IDEA.
  User: CMY
  Date: 2017/9/4
  Time: 11:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%><!DOCTYPE html>
<html>
<head>
    <title>经销商登陆</title>
</head>
<link href="<%=path%>/public/css/bootstrap.min.css" rel="stylesheet">
<body>
<input type="hidden" id="path" value="<%=path%>">
<div class="container">
    <div class=" row">
        <div class="col-lg-8 col-lg-offset-2  col-xs-12 col-md-10 col-md-offset-1   col-sm-12">
            <form style="margin-top: 200px" class="form-horizontal " role="form" id="form">
                <div class="form-group">
                    <label for="phone" class="col-sm-2  control-label">用 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 户 :</label>
                    <div class="col-sm-10  input-parent">
                        <input type="text" class="form-control vinput" id="phone" name="agency.email" placeholder="请输入或邮箱">
                        <span></span>
                    </div>
                </div>
                <div class="form-group ">
                    <label for="password" class="col-sm-2  control-label">密 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 码 :</label>
                    <div class="col-sm-10  input-parent">
                        <input type="password" class="form-control vinput" id="password" name="agency.pwd" placeholder="请输入密码"/>
                        <i class="glyphicon glyphicon-eye-close form-control-feedback" id="toogle-password"></i>
                        <span></span>
                    </div>
                </div>
                <br>
                <div class="form-group">
                    <div class="col-sm-12" id="div">
                        <input type="button" class="btn btn-primary form-control"  value="登陆" onclick="login();"/>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<footer>
</footer>
</body>
<script src="<%=path%>/public/js/jquery.min.js"></script>
<script>
    function login() {
        $.post("<%=path %>/agency/agencylogin",
            $("#form").serialize(),
            function (data) {
                if (data.result.result ==='success') {
                    window.location.href = "<%=path %>/agency/Agency";
                } else {
                    alert(data.result.msg);
                }
            }, "json"
        );
    }
</script>


</body>
</html>
