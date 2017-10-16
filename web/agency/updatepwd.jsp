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
    <style type="text/css">
        .error {
            color: red;
        }
    </style>
</head>
<body>
<div class="container">
    <form class="form-horizontal" style="margin-top: 160px;" id="form">
        <input type="hidden" id="id" name="employee.email" value="${sessionScope.employee.email }">
        <div class="form-group">
            <label for="oldpwd" class="col-sm-2 control-label">旧密码：</label>
            <div class="col-sm-7">
                <input type="password" class="form-control" id="oldpwd" name="agency.pwd" placeholder="请输入当前密码"
                       onchange="checkPwd();">
                <span id="nameTip" style="color: #ff2121"></span>
                <span id="nameTip3" style="color: #22ff37"></span>
            </div>
        </div>
        <div class="form-group">
            <label for="pwd" class="col-sm-2 control-label">新密码：</label>
            <div class="col-sm-7">
                <input type="password" class="form-control" name="pwd" id="pwd" placeholder="请输入新密码">
                <span id="nameTip1" style="color: #ff2121"></span>
            </div>
        </div>
        <div class="form-group">
            <label for="pwd1" class="col-sm-2 control-label">确认密码：</label>
            <div class="col-sm-7">
                <input type="password" class="form-control" id="pwd1" name="pwd1" placeholder="请确认密码">
                <span id="nameTip2" style="color: #ff2121"></span>
            </div>
        </div>
        <div>
            <label class="col-md-3"></label>
            <input class="btn btn-primary col-sm-2" style="margin-top: 20px;margin-left: 40px;" onclick="confirm();"
                   value="确认修改"/>
        </div>
    </form>
</div>
</body>
<script src="<%=path %>/public/js/jquery.min.js"></script>
<script src="<%=path %>/public/js/bootstrap.min.js"></script>
<script src="<%=path %>/layer-v3.1.0/layer/layer.js"></script>
<script type="text/javascript" src="<%=path%>/public/agency/js/jquery-validate.js"></script>
<script>
    //表单验证
    $("#form").validate();

    $("#oldpwd").rules('add', {
        required: true,
        messages: {
            required: '请输入你的密码'
        }
    });
    //密码
    $("#pwd").rules('add', {
        required: true,
        minlength: 6,
        maxlength: 20,
        pass: true,
        messages: {
            required: '请输入6-20位密码，数字和字母！',
            minlength: '密码不能小于{0}位！',
            maxlength: '密码不能超过{0}位！',
            pass: '密码不能含数字和字母以外的符号！'
        }
    });
    //确认密码
    $("#pwd1").rules('add', {
        required: true,
        equalTo: '#pwd',
        pass: true,
        messages: {
            required: '请再次输入密码',
            equalTo: '密码输入不一致',
            pass: '密码不能含数字和字母以外的符号！'
        }
    });
    //密码验证规则
    $.validator.addMethod('pass', function (value, element) {
        var pass = /^[\w]+$/
        return this.optional(element) || (pass.test(value));
    });
</script>
<script>
    function confirm() {
        if ($("#form").valid() == true) {
            var index = layer.load(0, {shade: false});//发送请求时让页面出现加载样式
            $.post("<%=path %>/agency/updateAgencyPwd",
                $("#form").serialize(),
                function (data) {
                    if (data.result.result == "success") {
                        layer.close(index);//关闭加载窗口
                        layer.alert(data.result.msg, {
                            skin: 'layui-layer-lan' //样式类名
                            , closeBtn: 0
                        }, function () {
                            window.location.reload();
                        });
                    } else {
                        layer.msg(data.result.msg);
                    }
                }, "json"
            );
        }
    }
</script>
</html>
