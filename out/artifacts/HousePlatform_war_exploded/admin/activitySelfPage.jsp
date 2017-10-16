<%--
  Created by IntelliJ IDEA.
  User: yao
  Date: 2017/8/28
  Time: 10:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Title</title>
</head>
<link href="<%=path%>/public/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=path%>/public/admin/css/admincheck.css" rel="stylesheet">
<link href="<%=path%>/public/admin/css/bootstrap-datetimepicker.css" rel="stylesheet">
<script src="<%=path%>/public/angular/angular.min.js"></script>
<style>
    .btn-primary {
        background-color: #1ab394;
        border-color: #1ab394;
        color: #FFF;
    }
</style>
<body ng-app="myApp">
<div ng-controller="myCtrl">
    <div class="container">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class=" table table-responsive container">
                        <table class="table table-striped" id="myTable">
                            <thead>
                            <th colspan="5">
                                <button type="button" class="btn btn-primary" onclick="changeYes();">激活</button>
                                <button type="button" class="btn btn-primary" onclick="changeNo();">冻结</button>
                                <button type="button" class="btn btn-primary" data-toggle="modal"
                                        ng-click="onclickbtn($index);">修改
                                </button>
                            </th>
                            <th>
                                <button class="btn btn-primary" onclick="window.location.reload(true);">刷新</button>
                            </th>
                            </thead>
                            <tr>
                                <th style="width:20px;"><input type="checkbox"></th>
                                <th>标题</th>
                                <th>地址</th>
                                <th>开始时间</th>
                                <th>结束时间</th>
                                <th>是否可用</th>
                            </tr>
                            <tbody>
                            <tr ng-repeat="a in activitys">
                                <td>
                                    <input type="checkbox" title="{{$index}}" name="actId" id="actId" value="{{a.id}}"/>
                                </td>
                                <td>{{a.title}}</td>
                                <td>{{a.address}}</td>
                                <td>{{a.start_time | date:'yyyy-MM-dd hh:mm'}}</td>
                                <td>{{a.end_time | date:'yyyy-MM-dd hh:mm'}}</td>
                                <td>
                                    <sapn ng-show="{{a.status == '1' }}">可用</sapn>

                                    <sapn ng-show="{{a.status == '0' }}" style="color:red;">不可用</sapn>
                                </td>
                            </tr>
                            <tbody>
                        </table>

                        <div class="row">
                            <div class="col-sm-2">
                                共 {{total}} 个用户，共{{totalPageSize}}页
                            </div>
                            <div class="col-sm-10">
                                <nav aria-label="Page navigation" class="pull-right">
                                    <ul class="pagination">
                                        <li ng-click="top()"><a>«</a></li>
                                        <li><a class="page" ng-show="count1>=5 " ng-click="page(count1-4)">{{count1-4}}</a></li>
                                        <li><a class="page" ng-show="count1>=4 " ng-click="page(count1-3)">{{count1-3}}</a></li>
                                        <li><a class="page" ng-show="count1>=3 " ng-click="page(count1-2)">{{count1-2}}</a></li>
                                        <li><a class="page" ng-show="count1>=2 " ng-click="page(count1-1)">{{count1-1}}</a></li>
                                        <li class="active"><a class="page" ng-show="count1>0" ng-click="page(count1)" title="{{count1}}">{{count1}}</a></li>
                                        <li><a class="page" ng-show="count1>0 && totalPageSize-1>= count1"
                                               ng-click="page(count1+1)">{{count1+1}}</a></li>
                                        <li><a class="page" ng-show="count1>0 && (totalPageSize-2) >= count1"
                                               ng-click="page(count1+2)">{{count1+2}}</a></li>
                                        <li><a class="page" ng-show="count1<3 && (totalPageSize-3) >= count1"
                                               ng-click="page(count1+3)">{{count1+3}}</a></li>
                                        <li><a class="page" ng-show="count1<2 && (totalPageSize-4) >= count1"
                                               ng-click="page(count1+4)">{{count1+4}}</a></li>
                                        <li ng-click="down()"><a>»</a></li>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog  modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">修改活动</h4>
                </div>
                <div class="modal-body">
                    <form id="changeActivity" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="activity.id" id="id"/>
                        <div class="form-group">
                            <label for="title" class="col-sm-2  control-label">活动标题:</label>
                            <div class="col-sm-10  input-parent">
                                <input type="text" class="form-control" id="title" name="activity.title"
                                       placeholder="请输入标题"><br/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="address" class="col-sm-2  control-label">活动地址：</label>
                            <div class="col-sm-10  input-parent">
                                <input type="text" class="form-control" id="address" name="activity.address"
                                       placeholder="请输入活动地址"><br/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="content" class="col-sm-2  control-label">活动内容：</label>
                            <div class="col-sm-10  input-parent">
                        <textarea id="content" class="form-control" rows="3" name="activity.content"
                                  style="height: 150px;" placeholder="活动内容"></textarea><br/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2  control-label">活动图片：</label>
                            <div class="col-md-10">
                                <div class="form-group">
                                    <div id="preview">
                                        <img id="imghead" border="0" src=""
                                             width="90" height="90" onclick="$('#previewImg').click();">
                                    </div>
                                    <input type="file" onchange="previewImage(this)" style="display: none;"
                                           id="previewImg" name="upload"/>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="start_time" class="col-sm-2  control-label">开始时间:</label>
                            <div class="col-sm-10  input-parent">
                         
                                <input size="16" type="text" class="form-control form_datetime" value="{{a.start_time}}"
                                       id="start_time" name="activity.start_time" style="background-color: white"
                                       readonly><br/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="end_time" class="col-sm-2  control-label">结束时间:</label>
                            <div class="col-sm-10  input-parent">
                                <input size="16" type="text" class="form-control form_datetime" value="{{a.end_time}}"
                                       id="end_time" name="activity.end_time" style="background-color: white" readonly><br/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2  control-label"></label>
                            <div class="col-sm-10  input-parent">
                                <input type="button" class="btn btn-default" value="修改" onclick="changeActivity();"
                                       style=" background-color: #1ab394;border-color: #1ab394;color: #FFF;"/>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer" style="border-top: 0px solid #e5e5e5;">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>
</div>

<form action="" method="post" id="formid">
    <input type="hidden" name="checkedIds" id="checkedIds"/>
    <input type="hidden" name="activity.status" id="status"/>
</form>
</body>
<script src="<%=path%>/public/js/jquery.min.js"></script>
<script src="<%=path %>/public/js/jQuery.form.min.js"></script>
<script src="<%=path%>/public/js/bootstrap.min.js"></script>
<script src="<%=path %>/public/admin/js/myFileUpload.js"></script>
<script src="<%=path %>/public/admin/js/bootstrap-datetimepicker.js"></script>
<script src="<%=path %>/public/admin/js/bootstrap-datetimepicker.zh-CN.js"></script>
<script src="<%=path %>/public/admin/js/tableCheckbox.js"></script>
<script src="<%=path %>/layer-v3.1.0/layer/layer.js"></script>
<script type="text/javascript">
    $("#myTable").tableCheck("warning");

    (function ($) {
        var app = angular.module('myApp', []);
        app.config(function ($httpProvider) {

            $httpProvider.defaults.transformRequest = function (obj) {
                var str = [];
                for (var p in obj) {
                    str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                }
                return str.join("&");
            };

            $httpProvider.defaults.headers.post = {
                'Content-Type': 'application/x-www-form-urlencoded'
            }

        });
        app.controller('myCtrl', function ($scope, $http, $timeout,$filter) {
            $scope.total = 0;
            $scope.totalPageSize = 0;
            $scope.activitys = "";
            $scope.count1 = 1;
            extracted($scope.count1);

            function extracted(x) {
                $http({
                    method: 'POST',
                    url: "<%=path%>/activity/activitySelfPagejson",
                    data: {"pageNo": x}
                }).then(function successCallback(response) {
                    $scope.total = response.data.pager.total;
                    $scope.totalPageSize = response.data.pager.totalPageSize;
                    $scope.activitys = response.data.pager.result;
                    $scope.count1 = response.data.pager.pageNo;
                }, function errorCallback(response) {

                });
            }

            $scope.page = function (x) {//点击页号事件
                if ($scope.count1 == x) {
                    return;
                }
                extracted(x);
            };

            $scope.down = function () {//下一页

                if ($scope.count1 == $scope.totalPageSize) {
                    return;
                }
                extracted($scope.count1 + 1);
            };
            $scope.top = function () {//上一页

                if ($scope.count1 == 1) {
                    return;
                }
                extracted($scope.count1 - 1);
            };

            $scope.onclickbtn = function (x) {//根据传进来的数字来取集合的数据
                if ($("input[name='actId']:checkbox:checked").length == 1) {
                    $("#myModal").modal("show");
                    $scope.count = $("input[name='actId']:checkbox:checked").attr("title");
                    $("#id").val($scope.activitys[$scope.count].id);
                    $("#title").val($scope.activitys[$scope.count].title);
                    $("#address").val($scope.activitys[$scope.count].address);
                    $("#content").val($scope.activitys[$scope.count].content);
                    document.getElementById("imghead").src = "<%=path %>/" + $scope.activitys[$scope.count].logo;
                    $("#start_time").val($filter("date")($scope.activitys[$scope.count].start_time, "yyyy-MM-dd HH:mm"));
                    $("#end_time").val($filter("date")($scope.activitys[$scope.count].end_time, "yyyy-MM-dd HH:mm"));
                } else {
                    layer.msg('请选择一行！');
                }
            };
        });
    }(jQuery));

    //时间
    $(".form_datetime").datetimepicker({format: 'yyyy-mm-dd hh:ii'});

    function changeYes() { // 只能激活用户，判断等页面完成
        var chk_value = [];
        $('input[name="actId"]:checked').each(function () {
            chk_value.push($(this).val());
        });
        if (chk_value.length == 0) {
            layer.msg('请选择一行！');
        } else {
            $('#checkedIds').val(chk_value);
            $('#status').val(0);
            layer.alert('激活成功！', {
                skin: 'layui-layer-lan' //样式类名
                , closeBtn: 0
            }, function () {
                $('#formid').prop("action", "<%=path %>/activity/status").submit();
            });
        }
    }

    function changeNo() { // 只能冻结用户，判断等页面完成
        var chk_value = [];
        $('input[name="actId"]:checked').each(function () {
            chk_value.push($(this).val());
        });
        if (chk_value.length == 0) {
            layer.msg('请选择一行！');
        } else {
            $('#checkedIds').val(chk_value);
            $('#status').val(1);
            layer.alert('冻结成功！', {
                skin: 'layui-layer-lan' //样式类名
                , closeBtn: 0
            }, function () {
                $('#formid').prop("action", "<%=path %>/activity/status").submit();
            });
        }
    }

    function changeActivity() {
        $("#changeActivity").ajaxSubmit({
            type: 'post', // 提交方式 get/post
            url: '/activity/changeActivity', // 需要提交的 url
            dataType : 'json',
            data:$("#changeActivity").serialize(),
            success: function(data) { // data 保存提交后返回的数据，一般为 json 数据
                if(data.controllerResult.result =='success'){
                    layer.alert('修改成功！', {
                        skin: 'layui-layer-lan' //样式类名
                        , closeBtn: 0
                    }, function () {
                        window.location.reload();
                    });
                } else{
                    layer.msg('修改失败！');
                }
            }
        });
        return false; // 阻止表单自动提交事件
    }

</script>
</html>
