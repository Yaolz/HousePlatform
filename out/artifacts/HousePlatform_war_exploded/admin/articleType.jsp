<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: yao
  Date: 2017/8/28
  Time: 10:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%><!DOCTYPE html>
<html>
<head>
    <title>文章类别</title>
</head>
<link href="<%=path%>/public/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=path %>/public/dist/summernote.css" rel="stylesheet"/>
<link href="<%=path%>/public/admin/css/admincheck.css" rel="stylesheet">
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
                            <th colspan="3">
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
                                <th style="width:30px;"><input type="checkbox"></th>
                                <th>类别名称</th>
                                <th>类别描述</th>
                                <th>状态</th>
                            </tr>
                            <tbody>
                            <tr ng-repeat="art in articleType">
                                <td>
                                    <input type="checkbox" title="{{$index}}" name="typeId" id="typeId"
                                           value="{{art.id}}"/>
                                </td>
                                <td>{{art.name}}</td>
                                <td>{{art.des}}</td>
                                <td>
                                    <span ng-show="{{art.status=='1'}}">可用</span>
                                    <span ng-show="{{art.status=='0'}}" style="color: red;">不可用</span>
                                </td>
                            </tr>
                            </tbody>
                        </table>

                        <div class="row">
                            <div class="col-sm-2">
                                共 {{total}} 个类别，共{{totalPageSize}}页
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
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">修改文章类别</h4>
                </div>
                <div class="modal-body">
                    <form id="changeType" method="post">
                        <input type="hidden" name="articleType.id" id="id"/>
                        <div class="form-group">
                            <label for="name" class="col-sm-2  control-label">类型名称:</label>
                            <div class="col-sm-10  input-parent">
                                <input id="name" type="text" class="form-control" name="articleType.name"/><br/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="des" class="col-sm-2  control-label">类型描述:</label>
                            <div class="col-sm-10  input-parent">
                                <textarea id="des" class="summernote" rows="3" name="articleType.des"
                                          style="height: 100px;" placeholder="活动内容"></textarea><br/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2  control-label"></label>
                            <div class="col-sm-10  input-parent">
                                <input type="button" class="btn btn-default" value="修改" onclick="changeArticleType();"style="   background-color: #1ab394;border-color: #1ab394;color: #FFF;"/>
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
<form method="post" id="formid">
    <input type="hidden" name="checkedIds" id="checkedIds"/>
    <input type="hidden" name="articleType.status" id="status"/>
</form>
</body>
<script src="<%=path%>/public/js/jquery.min.js"></script>
<script src="<%=path%>/public/js/bootstrap.min.js"></script>
<script src="<%=path %>/public/dist/summernote.js"></script>
<script src="<%=path %>/public/dist/lang/summernote-zh-CN.js"></script>
<script src="<%=path%>/public/admin/js/admin.js"></script>
<script src="<%=path %>/public/admin/js/tableCheckbox.js"></script>
<script src="<%=path %>/layer-v3.1.0/layer/layer.js"></script>
<script type="text/javascript">

    $("#myTable").tableCheck("warning");

    $(function () {
        $('.summernote').summernote({
            height: 200,
            tabsize: 2,
            lang: 'zh-CN'
        });
    });

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
        app.controller('myCtrl', function ($scope, $http, $timeout) {

            $scope.total = 0;
            $scope.totalPageSize = 0;
            $scope.articleType = "";
            $scope.count1 = 1;
            extracted($scope.count1);

            function extracted(x) {
                $http({
                    method: 'POST',
                    url: "<%=path%>/type/articleTypejson",
                    data: {"pageNo": x}
                }).then(function successCallback(response) {
                    $scope.total = response.data.articleTypePager.total;
                    $scope.totalPageSize = response.data.articleTypePager.totalPageSize;
                    $scope.articleType = response.data.articleTypePager.result;
                    $scope.count1 = response.data.articleTypePager.pageNo;
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
                if ($("input[name='typeId']:checkbox:checked").length == 1) {
                    $("#myModal").modal("show");
                    $scope.count = $("input[name='typeId']:checkbox:checked").attr("title");
                    $("#id").val($scope.articleType[$scope.count].id);
                    $("#name").val($scope.articleType[$scope.count].name);
                    $("#des").val($scope.articleType[$scope.count].des);
                } else {
                    layer.msg("请选择一行");
                }
            };
        });
    }(jQuery));

    function changeYes() { // 暂时只能冻结用户，判断等页面完成
        var chk_value =[];
        $('input[name="typeId"]:checked').each(function(){
            chk_value.push($(this).val());
        });
        if(chk_value.length == 0) {
            layer.msg("请选择一行！")
        } else {
            $('#checkedIds').val(chk_value);
            $('#status').val(0);
            layer.alert('激活成功！', {
                skin: 'layui-layer-lan' //样式类名
                , closeBtn: 0
            }, function () {
                $('#formid').prop("action", "<%=path %>/type/status").submit();
            });
        }
    }

    function changeNo() { // 暂时只能冻结用户，判断等页面完成
        var chk_value =[];
        $('input[name="typeId"]:checked').each(function(){
            chk_value.push($(this).val());
        });
        if(chk_value.length == 0) {
            layer.msg("请选择一行！")
        } else {
            $('#checkedIds').val(chk_value);
            $('#status').val(1);
            layer.alert('冻结成功！', {
                skin: 'layui-layer-lan' //样式类名
                , closeBtn: 0
            }, function () {
                $('#formid').prop("action", "<%=path %>/type/status").submit();
            });
        }
    }
</script>
</html>
