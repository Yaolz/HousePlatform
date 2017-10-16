<%--
  Created by IntelliJ IDEA.
  User: yao
  Date: 2017/8/26
  Time: 8:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html><html>
<head>
    <title>Title</title>
</head>
<body>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%>
<html>
<head>
    <title>Title</title>
    <link rel='stylesheet' href='<%=path %>/public/css/bootstrap.min.css'>
    <link rel='stylesheet' href='<%=path %>/public/admin/css/login.css'>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-offset-3 col-md-6">
            <form id="signupForm" class="form-horizontal">
                <span class="heading">用户登入</span>
                <div class="form-group">
                    <input type="text" class="form-control" id="email" name="email" placeholder="请输入你的邮箱或手机号"/>
                    <span id="errorEmail"style="color: red"></span>
                </div>
                <div class="form-group help">
                    <input type="password" class="form-control" id="pwd" name="pwd" placeholder="请输入密码" />
                    <span id="errorPwd" style="color: red;"></span>
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
<script type="text/javascript" src="<%=path%>/public/agency/js/jquery-validate.js"></script>
<script>
    $().ready(function() {
// 在键盘按下并释放及提交后验证提交表单
        $("#signupForm").validate({
            rules: {
                email: {
                    required: true
                },
                pwd: {
                    required: true
                }
            },
            messages: {
                email: {
                    required: "请输入用户名"
                },
                pwd: {
                    required: "请输入密码"
                }
            }
        });
    });
    $("#submit").click(function(){
        if ($("#signupForm").valid()==true) {//校验通过则返回true,不通过则false：
            $.post("<%=path%>/index/login",
                $("#signupForm").serialize(),
                function (data) {
                    if (data.result.result =='success') {
                        self.location ="<%=path%>/"+data.result.url;
                    }if(data.result.result =='fail'){
                        alert(data.result.msg);
                    }
                }, "json"
            );
        }
    });
</script>
</html>
