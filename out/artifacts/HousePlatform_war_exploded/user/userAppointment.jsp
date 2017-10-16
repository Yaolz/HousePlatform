<%--
  Created by IntelliJ IDEA.
  User: CHEN JX
  Date: 2017/8/31
  Time: 15:15
  To change this template use File | Settings | File Templates.
  用户预约
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>所有评价</title>

    <link rel="shortcut icon" href="favicon.ico">
    <link href="<%=path%>/public/css/bootstrap.min14ed.css?v=3.3.6" rel="stylesheet">
    <link href="<%=path%>/public/css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="<%=path%>/public/css/animate.min.css" rel="stylesheet">
    <link href="<%=path%>/public/css/style.min862f.css?v=4.1.0" rel="stylesheet">

</head>

<body class="gray-bg">
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>所有预约</h5>
                    <div class="ibox-tools">
                        <a class="collapse-link">
                            <i class="fa fa-chevron-up"></i>
                        </a>
                    </div>
                </div>
                <div class="ibox-content">
                    <div class="table-responsive">
                        <table class="table table-striped">
                            <tbody>
                            <tr>
                                <th>预约时间</th>
                                <th>工作人员</th>
                                <th>经销商</th>
                                <th>户型</th>
                                <th>真实看房时间</th>
                                <th>预约状态</th>

                            </tr>
                            </tbody>
                            <c:forEach items="${sessionScope.appointments}" var="app"  varStatus="status">
                                <tr>

                                    <td>${app.app_arrive_time}</td>
                                    <td>

                                        <a >
                                            <i title="${app.employeePrice.id}"  class="appointmentId" data-toggle="modal" data-target="#myModal" >${app.employeePrice.name}</i>
                                        </a>

                                    </td>
                                    <td>
                                            ${app.agencyPrice.name}
                                    </td>
                                    <td>
                                                ${app.house.name}
                                    </td>
                                    <td>
                                        ${app.arrive_time}

                                    </td>

                                    <td>
                                        <c:choose>
                                            <c:when test="${app.status==0}">
                                                <a type="button" class="btn btn-danger" href="<%=path%>/appointment/status?appointment.id=${app.id}&appointment.status=${app.status}">激活</a>
                                            </c:when>
                                            <c:otherwise>
                                                <a type="button" class="btn btn-primary" href="<%=path%>/appointment/status?appointment.id=${app.id}&appointment.status=${app.status}" >冻结</a>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </table>
                    </div>
                </div>
                </div>
                <div class="row">
                <div class="col-sm-12">
                    <nav aria-label="Page navigation" class="form-group">
                        <a href="<%=path %>/appointment/appointment?page=1">首页</a>
                        <a href="<%=path %>/appointment/appointment?page=${requestScope.page - 1}">上一页</a>
                        <a href="<%=path %>/appointment/appointment?page=${requestScope.page + 1}">下一页</a>
                        <a href="<%=path %>/appointment/appointment?page=${requestScope.pageCount}">尾页（当前第${requestScope.page}页，共${requestScope.pageCount}页）</a>

                    </nav>
                </div>
                </div>
        </div>

        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">

                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel">资料</h4>
                    </div>

                    <div class="modal-body">
                        <form class="form-horizontal" id="for">
                            <div class="form-group">
                                <label for="name" class="col-sm-3 control-label">姓&nbsp;&nbsp;&nbsp;&nbsp;名：</label>
                                <div class="col-sm-7">
                                    <input type="text" class="form-control" id="name" style="background:rgba(0, 0, 0, 0);" value="${app.employeePrice.name}" readonly>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="email" class="col-sm-3 control-label">邮&nbsp;&nbsp;&nbsp;&nbsp;箱：</label>
                                <div class="col-sm-7">
                                    <input type="text" class="form-control" id="email" style="background:rgba(0, 0, 0, 0);" value="${app.employeePrice.email}" readonly>
                                </div>
                            </div>


                            <div class="form-group">
                                <label for="phone" class="col-sm-3 control-label">电&nbsp;&nbsp;&nbsp;&nbsp;话：</label>
                                <div class="col-sm-7">
                                    <input type="text" class="form-control" id="phone" style="background:rgba(0, 0, 0, 0);" value="${app.employeePrice.phone}" readonly>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="QQ" class="col-sm-3 control-label">Q&nbsp;&nbsp;&nbsp;&nbsp;Q：</label>
                                <div class="col-sm-7">
                                    <input type="text" class="form-control" id="QQ" style="background:rgba(0, 0, 0, 0);" value="${app.employeePrice.qq}" readonly>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="wechat" class="col-sm-3 control-label">微&nbsp;&nbsp;&nbsp;&nbsp;信：</label>
                                <div class="col-sm-7">
                                    <input type="text" class="form-control" id="wechat" style="background:rgba(0, 0, 0, 0);" value="${app.employeePrice.wechat}" readonly>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="gender" class="col-sm-3 control-label">性&nbsp;&nbsp;&nbsp;&nbsp;别：</label>
                                <div class="col-sm-7">
                                    <input type="text" class="form-control" id="gender" style="background:rgba(0, 0, 0, 0);" value="${app.employeePrice.gender}" readonly>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="exp" class="col-sm-3 control-label">工作经验：</label>
                                <div class="col-sm-7">
                                    <input type="text" class="form-control" id="exp" style="background:rgba(0, 0, 0, 0);" value="${app.employeePrice.exp}" readonly>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="des" class="col-sm-3 control-label">个人说明：</label>
                                <div class="col-sm-7">
                                    <input type="text" class="form-control" id="des" style="background:rgba(0, 0, 0, 0);" value="${app.employeePrice.des}" readonly>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="address" class="col-sm-3 control-label">地&nbsp;&nbsp;&nbsp;&nbsp;址：</label>
                                <div class="col-sm-7">
                                    <input type="text" class="form-control" id="address" style="background:rgba(0, 0, 0, 0);" value="${app.employeePrice.address}" readonly>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="basic_salary" class="col-sm-3 control-label">基本工资：</label>
                                <div class="col-sm-7">
                                    <input type="text" class="form-control" id="basic_salary" style="background:rgba(0, 0, 0, 0);" value="${app.employeePrice.basic_salary}" readonly>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="intro" class="col-sm-3 control-label">简&nbsp;&nbsp;&nbsp;&nbsp;介：</label>
                                <div class="col-sm-7">
                                    <input type="text" class="form-control" id="intro" style="background:rgba(0, 0, 0, 0);" value="${app.employeePrice.intro}" readonly>
                                </div>
                            </div>


                        </form>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" data-dismiss="modal">关闭</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal" id="model" tabindex="-1" role="dialog" aria-labelledby="ModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">

            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel1">资料</h4>
            </div>

            <div class="modal-body">
                <form class="form-horizontal" id="f">
                    <div class="form-group">
                        <label for="housename" class="col-sm-3 control-label">名&nbsp;&nbsp;&nbsp;&nbsp;称：</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control" id="housename" style="background:rgba(0, 0, 0, 0);" value="${app.house.name}" readonly>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="house.intro" class="col-sm-3 control-label">简&nbsp;&nbsp;&nbsp;&nbsp;介：</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control" id="house.intro" style="background:rgba(0, 0, 0, 0);" value="${app.house.intro}" readonly>
                        </div>
                    </div>


                    <div class="form-group">
                        <label for="house.area" class="col-sm-3 control-label">面&nbsp;&nbsp;&nbsp;&nbsp;积：</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control" id="house.area" style="background:rgba(0, 0, 0, 0);" value="${app.house.area}" readonly>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="house.unit_price" class="col-sm-3 control-label">参考单价</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control" id="house.unit_price" style="background:rgba(0, 0, 0, 0);" value="${app.house.unit_price}" readonly>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="house.created_time" class="col-sm-3 control-label">创建时间：</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control" id="house.created_time" style="background:rgba(0, 0, 0, 0);" value="${app.house.created_time}" readonly>
                        </div>
                    </div>

                </form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>

</body>
<script src="<%=path%>/public/js/jquery.min.js?v=2.1.4"></script>
<script src="<%=path%>/public/js/bootstrap.min.js?v=3.3.6"></script>
<script src="<%=path%>/public/js/plugins/peity/jquery.peity.min.js"></script>
<script src="<%=path%>/public/js/content.min.js?v=1.0.0"></script>
<script src="<%=path%>/public/js/plugins/iCheck/icheck.min.js"></script>
<script src="<%=path%>/public/js/demo/peity-demo.min.js"></script>

<script>
   /*
        员工返回的数据
    */
    $(document).ready(function(){
        $(".appointmentId").click(function(){
            /*alert($(this).attr("title"));*/
            $.ajax({
                url: "<%=path%>/staff/employeeDetail",  //请求的url地址
                dataType: "json",   //返回格式为json
                async: true,//请求是否异步，默认为异步，这也是ajax重要特性
                data: {"emp_id": $(this).attr("title")}, //参数值
                type: "post",   //请求方式
                success: function (data) {
                    $("#myModal").modal("show");
                    $("#name").val(data.employee.name);
                    $("#email").val(data.employee.email);
                    $("#phone").val(data.employee.phone );
                    $("#QQ").val(data.employee.qq );
                    $("#wechat").val(data.employee.gender );
                    $("#gender").val(data.employee.gender );
                    $("#exp").val(data.employee.exp );
                    $("#des").val(data.employee.des );
                    $("#address").val(data.employee.address );
                    $("#basic_salary").val(data.employee.basic_salary );
                    $("#intro").val(data.employee.intro );


                }
            });

        })
    })

    /**
     * 户型返回的数据
     */
    $(document).ready(function(){
        $(".houseId").click(function(){
            /*alert($(this).attr("title"));*/
            $.ajax({
                url: "<%=path%>/house/houseDetail",  //请求的url地址
                dataType: "json",   //返回格式为json
                async: true,//请求是否异步，默认为异步，这也是ajax重要特性
                data: {"house.id": $(this).attr("title")}, //参数值
                type: "post",   //请求方式
                success: function (data) {
                    $("#myModal").modal("show");
                    $("#housename").val(data.house.name);
                    $("#house.intro").val(data.house.intro);
                    $("#house.area").val(data.house.area );
                    $("#house.unit_price").val(data.house.unit_price );
                    $("#house.created_time").val(data.hosue.created_time );

                }
            });

        })
    })


    function updateStatus(){
        $.post("<%=path %>/appointment/updateStatus/appointment.id = ${sessionScope.appointment.id}&appointment.status=${sessionScope.appointment.status}",
            $("#updates").serialize(),
            function (data) {
                if (data.result.result == "success") {
                    $("span").attr("class","btn btn-primary");
                }
            }, "json"
        );
    }
</script>

</html>
