<%--
  Created by IntelliJ IDEA.
  User: yao
  Date: 2017/9/13
  Time: 8:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html><html>
<%
    String path = request.getContextPath();
%>
<head>
    <title>所有评价</title>
</head>
<link href="<%=path%>/public/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=path%>/public/admin/css/admincheck.css" rel="stylesheet">
<link href="<%=path%>/public/css/bootstrap-fileinput.css" rel="stylesheet">
<link href="<%=path%>/public/admin/css/bootstrap-datetimepicker.css" rel="stylesheet">
<script src="<%=path%>/public/angular/angular.min.js"></script>
<style type="text/css">
    <%--cut样式主要用于把多出的字给截断--%>
    .cut {
        overflow:hidden;
        text-overflow:ellipsis;
        white-space: nowrap;
    }
    .error{
        color:red;
    }
    dd, dt {
        line-height: 2.42857143;
    }
    .btn-primary {
        background-color: #1ab394;
        border-color: #1ab394;
        color: #FFF;
    }
</style>
<body ng-app="myApp">
<input type="hidden" id="path" value="<%=path%>">
<input type="hidden"  id="agency-phone" value="${sessionScope.agency.phone}" />
<input type="hidden" id="agency-name"  value="${sessionScope.agency.name}" />
<div ng-controller="myCtrl">
    <div class="container">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class=" table table-responsive container">
                        <table class="table table-striped">
                            <tr>
                                <th colspan="3">
                                    <button type="button" id="update" class="btn btn-primary" data-toggle="modal">
                                        刷新
                                    </button>
                                    <button type="button" id="delete" class="btn btn-primary" data-toggle="modal">
                                        删除
                                    </button>
                                </th>
                                <th>
                                    <select class="form-control"   id="district" name="buildingsPrice.id">
                                        <option  value="所有楼盘">所有楼盘</option>
                                        <option ng-repeat="bui in buildingsPriceList"   value="{{bui.id}}">{{bui.name}}</option>
                                    </select>
                                </th>
                            </tr>
                            <tr>
                                <th><input type="checkbox" id="checkall"  ng-click="checkall()"/></th>
                                <th>用户</th>
                                <th>评价内容</th>
                                <th>评价时间</th>
                            </tr>
                            <tbody>
                            <tr ng-repeat="c in comment">
                                <td>
                                    <input type="checkbox" title="{{$index}}" name="commentId" id="commentId"
                                           value="{{c.id}}"/>
                                </td>
                                <td>{{c.userPrice.name}}</td>
                                <td>{{c.content}}</td>
                                <td>{{c.comment_time | date:'yyyy-MM-dd hh:mm'}}</td>
                            </tr>
                            <tbody>
                        </table>
                        <div class="row">
                            <div class="col-sm-2">
                                共 {{total}}条评论，共{{totalPageSize}}页
                            </div>
                            <div class="col-sm-5">
                                <nav aria-label="Page navigation" class="pull-right">
                                    <ul class="pagination">
                                        <li ng-click="top()"><a>«</a></li>
                                        <li><a class="page" ng-show="count1>=5 " ng-click="page(count1-4)">{{count1-4}}</a></li>
                                        <li><a class="page" ng-show="count1>=4 " ng-click="page(count1-3)">{{count1-3}}</a></li>
                                        <li><a class="page" ng-show="count1>=3 " ng-click="page(count1-2)">{{count1-2}}</a></li>
                                        <li><a class="page" ng-show="count1>=2 " ng-click="page(count1-1)">{{count1-1}}</a></li>
                                        <li class="active"><a class="page" ng-show="count1>0" ng-click="page(count1)" title="{{count1}}">{{count1}}</a></li>
                                        <li><a class="page" ng-show="count1>0 && totalPageSize-1>= count1" ng-click="page(count1+1)">{{count1+1}}</a></li>
                                        <li><a class="page" ng-show="count1>0 && (totalPageSize-2) >= count1" ng-click="page(count1+2)">{{count1+2}}</a></li>
                                        <li><a class="page" ng-show="count1<3 && (totalPageSize-3) >= count1" ng-click="page(count1+3)">{{count1+3}}</a></li>
                                        <li><a class="page" ng-show="count1<2 && (totalPageSize-4) >= count1" ng-click="page(count1+4)">{{count1+4}}</a></li>
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
</div>
</body>
<script src="<%=path%>/public/js/jquery.min.js"></script>
<script src="<%=path%>/public/js/bootstrap.min.js"></script>
<script src="<%=path %>/public/js/jQuery.form.min.js"></script>
<script src="<%=path %>/public/admin/js/bootstrap-datetimepicker.js"></script>
<script src="<%=path %>/public/admin/js/bootstrap-datetimepicker.zh-CN.js"></script>
<script src="<%=path%>/public/js/bootstrus-date-from.js"></script>
<script src="<%=path%>/public/js/bootstrap-fileinput.js"></script>
<script src="<%=path %>/layer-v3.1.0/layer/layer.js"></script>
<script src="<%=path%>/public/agency/js/jquery-validate.js"></script>
<script type="text/javascript">
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
            $scope.employee = "";
            $scope.total = 0;
            $scope.totalPageSize = 0;
            $scope.count1 = 1;

            $http({
                method: 'POST',
                url: "<%=path%>/buildings/queryBuildingsPrice"
            }).then(function successCallback(response) {
                $scope.buildingsPriceList = response.data.buildingsPriceList;
                $timeout(function(){
                    extracted($scope.count1);
                },100);
            }, function errorCallback(response) {

            });

            function extracted(x) {
                var index = layer.load(0, {shade: false});//发送请求时让页面出现加载样式
                $http({
                    method: 'POST',
                    url: "<%=path%>/comment/pagerByBuildings",
                    data: {"page": x, "buildingsId": $("#district").val()}
                }).then(function successCallback(response) {
                    $scope.total = response.data.commentPager.total;
                    $scope.totalPageSize = response.data.commentPager.totalPageSize;
                    $scope.comment = response.data.commentPager.result;
                    $scope.count1 = response.data.commentPager.pageNo;
                    layer.close(index);//关闭加载窗口
                    if($("#checkall").is(':checked')==true){
                        $("#checkall").prop("checked",false);
                    }
                }, function errorCallback(response) {

                });
            }


            $("#district").change(function () {//选择状态时的改变事件
                extracted(1);
            });
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
            $scope.checkall=function () {//全选和取消全选
                if($("#checkall").is(':checked')==true){
                    $("input[name='commentId']").prop("checked",true);
                }else {
                    $("input[name='commentId']").prop("checked", false);
                }
            };
            $("#update").click(function() {//刷新数据调用此方法
                var buildingsID = $("#district").val();
                $http({
                    method: 'POST',
                    url: "<%=path%>/buildings/queryBuildingsPrice"
                }).then(function successCallback(response) {
                    $scope.buildingsPriceList = response.data.buildingsPriceList;
                    $timeout(function () {
                        $("#district").val(buildingsID);
                    }, 100);
                    $timeout(function () {
                        extracted($scope.count1);
                    }, 300);
                }, function errorCallback(response) {

                });
                extracted($scope.count1);
            });
            $("#delete").click(function() {//删除评论
                var chk_value = [];
                $('input[name="commentId"]:checked').each(function () {
                    chk_value.push($(this).val());
                });
                if (chk_value.length == 0) {
                    layer.msg("请选择！");
                } else {
                    deleteD(chk_value);
                }
            });
            function deleteD(checkedIds) {
                $.ajax({
                    type:'post',
                    traditional :true,
                    url:'<%=path%>/comment/deleteComment',
                    data:{"checkedIds":checkedIds} ,
                    success:function(data){
                        $timeout(function(){
                                    layer.msg("删除成功！");
                                    extracted($scope.count1);
                        },0);
                    }
                });
            }
        });
    }(jQuery));
</script>
</html>
