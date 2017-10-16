<%--
  Created by IntelliJ IDEA.
  User: CHEN JX
  Date: 2017/8/30
  Time: 20:16
  To change this template use File | Settings | File Templates.
  用户留言
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


    <title>所有留言</title>

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
                    <h5>所有留言</h5>
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
                                <th>楼盘名称</th>
                                <th>留言内容</th>
                                <th>留言时间</th>
                                <th>回复内容</th>
                                <th>回复时间</th>
                                <th>修改留言</th>
                                <th>激活/冻结</th>
                            </tr>
                            </tbody>
                            <c:forEach items="${sessionScope.messages}" var="mes" varStatus="status">
                            <tr>
                                <td>${mes.buildingsPrice.name}</td>
                                <td>${mes.content}</td>
                                <td>${mes.leave_time}</td>
                                <td>${mes.reply}</td>
                                <td>${mes.reply_time}</td>
                                <td>
                                    <div >
                                        <a class="btn btn-primary" data-toggle="modal" data-target="#myModal_${mes.id}">修改</a>
                                        <!--模态框-->
                                        <div class="modal fade" id="myModal_${mes.id}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                                            <div class="modal-dialog" role="document">
                                                <div class="modal-content">

                                                    <div class="modal-header">
                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                        <h4 class="modal-title" id="myModalLabel">资料</h4>
                                                    </div>

                                                    <div class="modal-body">
                                                        <form class="form-horizontal" id="mtk${status.count}">
                                                            <input type="hidden" id="id" name="message.id" value="${mes.id}"/>
                                                            <div class="form-group">
                                                                <label for="inputName2" class="col-sm-3 control-label">留言内容：</label>
                                                                <div class="col-sm-7">
                                                                    <input type="text" class="form-control" id="inputName2" name="message.content" style="background:rgba(0, 0, 0, 0);" value="${mes.content}" >
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <label for="inputGender2" class="col-sm-3 control-label">回复内容：</label>
                                                                <div class="col-sm-7">
                                                                    <input type="text" class="form-control" id="inputGender2" name="message.reply" style="background:rgba(0, 0, 0, 0);" value="${mes.reply}" readonly>
                                                                </div>
                                                            </div>


                                                        </form>
                                                    </div>

                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-primary" onclick="updateMessage(${status.count});">修改</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                                <td>

                                         <c:choose>
                                           <c:when test="${mes.status==0}">
                                               <a type="button" class="btn btn-danger" href="<%=path%>/message/status?id=${mes.id}&status=${mes.status}">激活</a>
                                           </c:when>
                                           <c:otherwise>
                                               <a type="button" class="btn btn-primary" href="<%=path%>/message/status?id=${mes.id}&status=${mes.status}" >冻结</a>
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
                        <a href="<%=path %>/message/message?page=1">首页</a>
                        <a href="<%=path %>/message/message?page=${requestScope.page-1}">上一页</a>
                        <a href="<%=path %>/message/message?page=${requestScope.page + 1}">下一页</a>
                        <a href="<%=path %>/message/message?page=${requestScope.pageCount}">尾页（当前第${requestScope.page}页，共${requestScope.pageCount}页）</a>

                    </nav>
                </div>
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
    function updateMessage(id) {
        $.post("<%=path %>/message/updateMessage",
            $("#mtk" + id).serialize(),
            function (data) {
                if (data.result.result == "success") {
                    window.location.href="/message/message";

                } else {
                    alert(data.result.msg);
                }
            }, "json"
        );
    }

    </script>
</html>
