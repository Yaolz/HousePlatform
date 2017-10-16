<%--
  Created by IntelliJ IDEA.
  User: ID.LQF
  Date: 2017/8/29
  Time: 20:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%><!DOCTYPE html>
<html>
<head>
    <title>修改密码</title>
    <link rel="stylesheet" href="<%=path %>/public/css/bootstrap.min.css">
    <script src="<%=path %>/public/tanchuang/sweetalert-master/dist/sweetalert-dev.js"></script>
    <link rel="stylesheet" href="<%=path %>/public/tanchuang/sweetalert-master/dist/sweetalert.css">
</head>
<body>
<form class="form-horizontal" style="margin-top: 160px;" id="form">
    <input type="hidden" id="id" name="employee.email" value="${sessionScope.employee.email }">
    <div class="form-group">
        <label for="oldpwd" class="col-sm-2 control-label">旧密码：</label>
        <div class="col-sm-7">
            <input type="password" class="form-control" id="oldpwd" name="oldpwd" placeholder="请输入当前密码" onchange="checkPwd();">
            <span id="nameTip" style="color: #ff2121"></span>
            <span id="nameTip3" style="color: #22ff37"></span>
        </div>
    </div>
    <div class="form-group">
        <label for="pwd" class="col-sm-2 control-label">新密码：</label>
        <div class="col-sm-7">
            <input type="password" class="form-control" name="employee.pwd" id="pwd" placeholder="请输入新密码">
            <span id="nameTip1" style="color: #ff2121"></span>
        </div>
    </div>
    <div class="form-group">
        <label for="pwd1" class="col-sm-2 control-label">确认密码：</label>
        <div class="col-sm-7">
            <input type="password" class="form-control"id="pwd1" placeholder="请确认密码">
            <span id="nameTip2" style="color: #ff2121"></span>
        </div>
    </div>
    <div>
        <label class="col-md-3"></label>
        <button class="btn btn-primary col-sm-2" id="in" style="margin-top: 20px;">取消修改</button>
        <input class="btn btn-primary col-sm-2" style="margin-top: 20px;margin-left: 40px;" onclick="confirm();" value="确认修改"/>
    </div>
</form>
</body>
<script src="<%=path %>/public/js/jquery.min.js"></script>
<script src="<%=path %>/public/js/bootstrap.min.js"></script>
<script src="<%=path %>/public/js/webuploader/jquery.validate-1.13.1.js"></script>
<script>
    $(document).ready(function () {
        $("#oldpwd").blur(function () {
            var oldpwd = $("#oldpwd").val();
            var nameTip = $("#nameTip");
            if (oldpwd.length <= 0) {
                nameTip.html("原始密码不能为空，请输入密码");
                nameTip.show();
                return "fales";
            }
            $("#oldpwd").focus(function(){
                nameTip.hide();
            });
        });
    });

    $(document).ready(function () {
        $("#pwd").blur(function () {
            var pwd = $("#pwd").val();
            var nameTip1 = $("#nameTip1");
            if (pwd.length <= 0 || pwd.length < 6) {
                nameTip1.html("新密码不能为空，且不能低于6位，请输入密码");
                nameTip1.show();
            }
            $("#pwd").focus(function(){
                nameTip1.hide();
            });
        });
    });

    $(document).ready(function () {
        $("#pwd1").blur(function () {
            var pwd = $("#pwd").val();
            var pwd1 = $("#pwd1").val();
            var nameTip2 = $("#nameTip2");
            if (pwd1.length <= 0) {
                nameTip2.html("确认密码不能为空，请输入密码");
                nameTip2.show();
            }else if(pwd1!=pwd){
                nameTip2.html("两次密码不一致，请重新输入");
                nameTip2.show();
            }

            $("#pwd1").focus(function(){
                nameTip2.hide();
            });
        });
    });

    function checkPwd() {
        var nameTip = $("#nameTip");
        var nameTip3 = $("#nameTip3");
        $.post("<%=path %>/staff/checkPwd",
            $("#oldpwd").serialize(),
            function (data) {
                if (data.result.result == 'success') {
                    nameTip3.html("密码正确")
                    nameTip3.show();
                    $("#oldpwd").focus(function(){
                        nameTip3.hide();
                    });
                } else {
                    nameTip.html("密码错误")
                    nameTip.show();
                    $("#oldpwd").focus(function(){
                        nameTip.hide();
                    });
                }
            }, 'json'
        );
    }

</script>
<script>
    function confirm() {
        $.post("<%=path %>/staff/confirm",
            $("#form").serialize(),
            function (data) {
                if (data.result.result == "success") {
                    window.location.href = "<%=path %>/staff/staffCenter";
                } else {
                    swal(data.result.msg);
                }
            }, "json"
        );
    }
</script>
</html>
