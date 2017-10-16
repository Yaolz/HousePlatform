<%--
  Created by IntelliJ IDEA.
  User: CHEN JX
  Date: 2017/8/24
  Time: 20:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
        String path = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>用户注册</title>
    <link href="<%=path%>/public/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%=path%>/public/userRegister/css/normalize.css" rel="stylesheet">
    <link href="<%=path%>/public/userRegister/css/public.css" rel="stylesheet">
    <link href="<%=path%>/public/userRegister/css/validator.css" rel="stylesheet">
    <link href="<%=path%>/public/userRegister/css/completer.css" rel="stylesheet">
    <link href="<%=path%>/public/userRegister/jedate/skin/jedate.css" rel="stylesheet">
    <link href="<%=path%>/public/userRegister/css/date.css" type="text/css" rel="stylesheet">
    <link href="<%=path%>/public/userRegister/css/magic-check.css" rel="stylesheet" >
    <link href="<%=path%>/public/userRegister/css/jquery-ui.css" rel="stylesheet">
    <link href="<%=path%>/public/userRegister/css/index.css" rel="stylesheet">
    <script src="<%=path%>/public/js/jquery.min.js"></script>
    <script src="<%=path%>/public/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="<%=path%>/public/userRegister/jedate/jedate.js"></script>
    <script type="text/javascript" src="<%=path%>/public/userRegister/js/date.js"></script>
    <script type="text/javascript" src="<%=path%>/public/userRegister/js/jquery-validate.js"></script>
    <script type="text/javascript" src="<%=path%>/public/userRegister/js/validator.js"></script>
    <script type="text/javascript" src="<%=path%>/public/userRegister/js/jquery-ui.min.js"></script>
    <script type="text/javascript" src="<%=path%>/public/userRegister/js/index.js"></script>

    <!--[if lt IE 9]>
    <script src="http://cdn.static.runoob.com/libs/html5shiv/3.7/html5shiv.min.js"></script>
    <script src="http://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
<header>
</header>
<div class="container">
    <div class=" row">
        <div class="col-lg-8 col-lg-offset-2  col-xs-12 col-md-10 col-md-offset-1   col-sm-12">
            <form action="<%=path%>/user/reg" method="post" class="  form-horizontal " role="form" id="register-form">

                <div class="form-group">
                    <label for="phone" class="col-sm-2  control-label">手 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 机 :</label>
                    <div class="col-sm-10  input-parent">
                        <input type="text" class="form-control vinput" id="phone" name="user.phone" maxlength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" placeholder="请输入手机号">
                        <span></span>
                    </div>
                </div>
                <div class="form-group ">
                    <label for="email" class="col-sm-2  control-label">邮 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 箱 :</label>
                    <div class="col-sm-10 input-parent">
                        <input type="text" class="form-control vinput" id="email" name="user.email" placeholder="请输入邮箱"/>
                        <span></span>
                    </div>
                </div>
                <div class="form-group">
                    <label for="birthday" class="col-sm-2  control-label">生 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 日 :</label>
                    <div class="col-sm-10  input-parent">
                        <input type="text" class="form-control vinput" id="birthday" name="user.birthday" placeholder="请选择生日" readonly>
                        <span></span>
                    </div>
                </div>
                <div class="form-group ">
                    <label for="password" class="col-sm-2  control-label">密 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 码 :</label>
                    <div class="col-sm-10  input-parent">
                        <input type="password" class="form-control vinput" id="password" name="user.password" placeholder="请输入密码"/>
                        <i class="glyphicon glyphicon-eye-close form-control-feedback" id="toogle-password"></i>
                        <span></span>
                    </div>
                </div>
                <div class="form-group">
                    <label for="notpass" class="col-sm-2  control-label">确认密码 :</label>
                    <div class="col-sm-10  input-parent">
                        <input type="password" class="form-control vinput" id="notpass" name="user.pwd" placeholder="请再次输入密码"/>
                        <i class="glyphicon glyphicon-eye-close form-control-feedback" id="toggle-notpass"></i>
                        <span></span>
                    </div>
                </div>
                <br>
                <div class="form-group">
                    <div class="col-sm-12">
                        <input type="checkbox" class="magic-checkbox" id="accept" name="accept" />
                        <label for="accept" class="accept"><span>我已阅读并接受</span> <a href="javascript:;">《版权声明》</a> <span>和</span> <a href="javascript:;">《隐私保护》</a></label>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-12">
                        <input type="submit" class="btn btn-primary form-control" id="submit" value="注册"/>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<footer>
</footer>
</body>
</html>