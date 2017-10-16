<%--
  Created by IntelliJ IDEA.
  User: ID.LQF
  Date: 2017/8/30
  Time: 14:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
    <title>添加客户</title>
    <link rel="stylesheet" href="<%=path %>/public/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=path %>/public/tanchuang/sweetalert-master/dist/sweetalert.css">
    <script src="<%=path %>/public/tanchuang/sweetalert-master/dist/sweetalert-dev.js"></script>
    <script src="<%=path%>/public/angular/angular.min.js"></script>
    <style>
        .error {
            color: red;
        }
    </style>
</head>
<body>
<div class="container">
    <input type="hidden" id="path" value="<%=path%>">
    <form class="form-horizontal" id="register-form" style="margin-top: 20px;">
        <input type="hidden" value="${sessionScope.employee.id}" name="customer.emp_id">
        <div class="form-group">
            <label for="name" class="col-sm-3 control-label">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名：</label>
            <div class="col-sm-7">
                <input type="text" class="form-control" name="customer.name" id="name" placeholder="请输入客户的姓名">
                <span id="nameTip" style="color: #ff2121"></span>
            </div>
        </div>
        <div class="form-group">
            <label for="inputGender3"
                   class="col-sm-3 control-label">性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别：</label>
            <div class="col-sm-7">
                <select class="form-control" name="customer.gender" id="inputGender3">
                    <option>男</option>
                    <option>女</option>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label for="birthday"
                   class="col-sm-3 control-label">生&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日：</label>
            <div class="col-sm-7">
                <input type="text" class="form-control" name="customer.birthday" style="background:rgba(0, 0, 0, 0);"
                       id="birthday" placeholder="请输入客户的生日" readonly>
            </div>
        </div>
        <div class="form-group">
            <label for="identity_id" class="col-sm-3 control-label">身&nbsp;&nbsp;份&nbsp;&nbsp;证&nbsp;&nbsp;&nbsp;&nbsp;号：</label>
            <div class="col-sm-7">
                <input type="text" class="form-control" name="customer.identity_id" id="identity_id"
                       placeholder="请输入客户的身份证号">
            </div>
        </div>
        <div class="form-group">
            <label for="email" class="col-sm-3 control-label">邮&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;箱：</label>
            <div class="col-sm-7">
                <input type="email" class="form-control" name="customer.email" id="email" placeholder="请输入客户的邮箱">
                <span id="nameTip1" style="color: #ff2121"></span>
            </div>
        </div>
        <div class="form-group">
            <label for="phone" class="col-sm-3 control-label">手&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;机：</label>
            <div class="col-sm-7">
                <input type="text" class="form-control" name="customer.phone" id="phone" placeholder="请输入客户的手机号码">
                <span id="nameTip2" style="color: #ff2121"></span>
            </div>
        </div>
        <div class="form-group">
            <label for="address" class="col-sm-3 control-label">联&nbsp;&nbsp;系&nbsp;&nbsp;地&nbsp;&nbsp;址：</label>
            <div class="col-sm-7">
                <input type="text" class="form-control" name="customer.address" id="address" placeholder="请输入客户的联系地址">
            </div>
        </div>
        <div class="form-group">
            <label for="introduce3" class="col-sm-3 control-label">客&nbsp;&nbsp;户&nbsp;&nbsp;类&nbsp;&nbsp;型：</label>
            <div class="col-sm-7">
                <select class="form-control" name="customer.customer_type" id="introduce3">
                    <option>预约客户</option>
                    <option>预定客户</option>
                    <option>购房客户</option>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label for="inputTogether3" class="col-sm-3 control-label">共&nbsp;&nbsp;同&nbsp;&nbsp;购&nbsp;&nbsp;房&nbsp;&nbsp;人：</label>
            <div class="col-sm-7">
                <input type="text" class="form-control" name="customer.together" id="inputTogether3"
                       placeholder="请输入共同购房人的姓名">
            </div>
        </div>
        <label class="col-md-3"></label>
        <input type="button" class="btn btn-primary col-sm-3" style="margin-top: 10px;margin-bottom: 20px;"
               value="取消添加">
        <input type="button" class="btn btn-primary col-sm-3"
               style="margin-top: 10px;margin-left: 40px;margin-bottom: 20px;" value="确认添加" onclick="add();">
    </form>
</div>
</body>
<script src="<%=path %>/public/js/jquery.min.js"></script>
<script src="<%=path %>/public/js/bootstrap.min.js"></script>
<script src="<%=path%>/public/userRegister/jedate/jedate.js"></script>
<script src="<%=path%>/public/agency/js/jquery-validate.js"></script>
<script>
    $(function () {
        $("#register-form").validate();

        //姓名
        $("#name").rules('add', {
            required: true,
            messages: {
                required: '请输入姓名',
            }
        });
        //生日
        if ($("#birthday").get(0)) {
            jeDate({
                dateCell: "#birthday",
                format: "YYYY-MM-DD",
                minDate: "1900-1-1",
                maxDate: jeDate.now(0),
                ishmsVal: false
            });
        }
        ;


        $("#birthday").trigger("click");
        $("body").trigger("click");
        $("#birthday").rules('add', {
            required: true,
            date: true,
            messages: {
                required: '请选择时间，如1993-03-29！',
                date: '时间格式不正确'
            }

        });
        //身份证号验证规则
        $("#identity_id").rules('add', {
            required: true,
            maxlength: 18,
            minlength: 17,
//            identity_id:true,
            messages: {
                required: '请输入身份证号',
                maxlength: '身份证号输入错误',
                minlength: '身份证号输入错误',
//                identity_id: "输入的身份证格式不正确"
            }
        });
        //手机
        $("#phone").rules('add', {
            required: true,
            rangelength: [11, 11],
            digits: true,
            phone: true,
            messages: {
                required: '请输入您的手机号！',
                rangelength: '请输入正确的手机号！',
                digits: '请输入正确的手机号！',
                phone: '请输入正确的手机号！'
            }
        });
        //邮箱
        $("#email").rules('add', {
            required: true,
            email: true,
            messages: {
                required: '请输入您的邮箱！',
                email: '请输入正确的邮箱！'
            }
        });
        //生日验证规则
        $.validator.addMethod('date', function (value, element) {
            var date = /^(19|20)\d{2}-(1[0-2]|0?[1-9])-(0?[1-9]|[1-2][0-9]|3[0-1])$/;
            return this.optional(element) || (date.test(value));
        });
        //身份证号验证规则
        $.validator.addMethod('identity_id', function (value, element) {
            var identity_id = / ^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X)$/;
            return this.optional(element) || (identity_id.test(value));
        });
        //手机验证规则
        $.validator.addMethod('phone', function (value, element) {
            var phone = /^1[3|4|5|7|8][0-9]\d{8}$/;
            return this.optional(element) || (phone.test(value));
        });
        //邮箱验证规则
        $.validator.addMethod('email', function (value, element) {
            var email = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/;
            return this.optional(element) || (email.test(value));
        });
    });
</script>
<script>
    function add() {
        if ($("#register-form").valid() == true) {
            $.post("<%=path %>/cus/add",
                $("#register-form").serialize(),
                function (data) {
                    if (data.result.result == "success") {
                        swal({
                            title: '添加成功',
                            text: "添加成功",
                            type: 'success',
                            confirmButtonColor: '#3085d6',
                            confirmButtonText: '确定'
                        }, function () {
                            window.location.reload(true);
                        })
                    } else {
                        alert(data.result.msg);
                    }
                }, "json"
            );
        }
    }
</script>
</html>
