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
<div class="container">
<form class="form-horizontal" style="margin-top: 160px;" id="updatePwd">
    <input type="hidden" id="id" name="user.id" value="${sessionScope.user.id}"/>
    <div class="form-group">
        <label for="oldpwd" class="col-sm-2 control-label">旧密码：</label>
        <div class="col-sm-7">
            <input type="password" class="form-control" id="oldpwd"  name="oldpwd" placeholder="请输入原始密码" onchange="checkPwd();"/>
            <span id="nameTip" style="color: #ff68d6"></span>
            <span id="nameTip3" style="color: #22ff37"></span>
        </div>
    </div>
    <div class="form-group">
        <label for="pwd" class="col-sm-2 control-label">新密码：</label>
        <div class="col-sm-7">
            <input type="password" id="pwd" name="user.pwd" class="form-control" id="pwd" placeholder="请输入新密码" />
            <span id="nameTip1" style="color: #ff36d8"></span>
        </div>
    </div>
    <div class="form-group">
        <label for="pwd2" class="col-sm-2 control-label">确认密码：</label>
        <div class="col-sm-7">
            <input type="password" class="form-control"  id="pwd2" placeholder="请再次输入密码"/>
            <span id="nameTip2" style="color: #ff36c0"></span>
        </div>
    </div>
    <div>
        <label class="col-md-3"></label>
        <input type="button" class="btn btn-primary col-sm-2" style="margin-top: 20px;margin-left: 40px;" onclick="confirm();" value="确认提交"/>
    </div>
</form>
</div>
</body>
<script src="<%=path %>/public/js/jquery.min.js"></script>
<script src="<%=path %>/public/js/bootstrap.min.js"></script>
<script src="<%=path %>/public/js/webuploader/jquery.validate-1.13.1.js"></script>
<script>
    $(document).ready(function () {
        $("#oldpwd").blur(function () {
            var oldpwd = $("#oldpwd").val()
            var nameTip = $("#nameTip")
            if (oldpwd.length <= 0) {
                nameTip.html("原始密码不能为空，请输入密码");
                nameTip.show();
            }
            $("#oldpwd").focus(function(){
                nameTip.hide();
            });
        });
    });

    $(document).ready(function () {
        $("#pwd").blur(function () {
            var oldpwd = $("#oldpwd").val()
            var pwd = $("#pwd").val();
            var nameTip1 = $("#nameTip1")
            if (pwd.length <= 0) {
                nameTip1.html("新密码不能为空，请输入密码");
                nameTip1.show()
            }else if(pwd==oldpwd){
                nameTip1.html("新密码不能与旧密码一致");
                nameTip1.show()
            }else if(pwd.length<6){
                nameTip1.html("密码长度不能小于6位");
                nameTip1.show()
                $("#pwd2").val("")
            }else if(pwd.length>12){
                nameTip1.html("密码长度不能小于超过12位");
                nameTip1.show()
            }
            $("#pwd").focus(function(){
                nameTip1.hide();
            });
        });
    });

    $(document).ready(function () {
        $("#pwd2").blur(function () {
            var pwd = $("#pwd").val()
            var pwd2 = $("#pwd2").val()
            var nameTip2 = $("#nameTip2")
            if (pwd2.length <= 0) {
                nameTip2.html("确认密码不能为空，请输入密码");
                nameTip2.show();

            }else if(pwd2!=pwd){
                nameTip2.html("两次密码不一致，请重新输入");
                nameTip2.show();
            }

            $("#pwd2").focus(function(){
                nameTip2.hide();

            });
        });
    });


    //验证原始密码
    function checkPwd() {
        var nameTip = $("#nameTip");
        var nameTip3 = $("#nameTip3");
        $.post("<%=path %>/user/checkPwd",
            $("#oldpwd").serialize(),
            function (data) {
                if (data.result.result == 'success') {

                    nameTip3.text("密码正确");
                    nameTip3.show();
                    $("#oldpwd").focus(function(){
                        nameTip3.hide();
                    });
                } else {
                    nameTip.text("密码错误");
                    nameTip.show();
                    $("#oldpwd").val("");
                }
            }, 'json'
        );
    }

    //修改密码

    function confirm(){
        if ($("#updatePwd").valid()==true) {
            $.post("<%=path %>/user/update",
                $("#updatePwd").serialize(),
                function (data) {
                    if (data.result.result == "success") {
                        swal({
                            title: '修改成功',
                            text: "请记住您的新密码",
                            type: 'success',
                            confirmButtonColor: '#3085d6',
                            confirmButtonText: '确定'
                        }, function () {
                            window.location.reload(true);
                        })
                    } else {
                        swal("失败！");
                    }
                }, "json"
            );
        }
    }
</script>
</html>
