<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%><!DOCTYPE html>
<html>
<head>
    <title>所有合法经销商</title>
</head>
<link href="<%=path%>/public/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=path%>/public/css/style.min.css" rel="stylesheet">
<link href="<%=path%>/public/admin/css/admincheck.css" rel="stylesheet">
<script src="<%=path%>/public/angular/angular.min.js"></script>
<body ng-app="myApp">
<div ng-controller="myCtrl">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="table table-responsive container">
                        <table class="table table-striped" id="myTable">
                            <thead>
                            <th colspan="7">
                                <button type="button" class="btn btn-primary" onclick="changeStatus('change');">冻结
                                </button>
                                <button type="button" class="btn btn-primary" onclick="agencyDetail();">查看详情</button>
                            </th>
                            <th>
                                <button class="btn btn-primary" onclick="window.location.reload(true);">刷新</button>
                            </th>
                            </thead>
                            <tr>
                                <th><input type="checkbox"></th>
                                <th>经销商名</th>
                                <th>负责人</th>
                                <th>邮箱</th>
                                <th>电话</th>
                                <th>注册时间</th>
                                <th>是否审核</th>
                                <th>是否可用</th>
                            </tr>
                            <tbody>
                            <tr ng-repeat="a in agency">
                                <td><input type="checkbox" name="agencyId" id="agencyId" value={{a.id}}></td>
                                <td>{{a.name}}</td>
                                <td>{{a.leader}}</td>
                                <td>{{a.email}}</td>
                                <td>{{a.phone}}</td>
                                <td>{{a.created_time | date:'yyyy-MM-dd hh:mm'}}</td>
                                <td>
                                    <p ng-show="{{a.checked_status == '1' }}">已审核</p>
                                    <p style="color:red;" ng-show="{{a.checked_status == '0' }}">
                                        未审核</p>
                                </td>
                                <td>
                                    <p ng-show="{{a.status == '1' }}">可用</p>
                                    <p style="color:red;" ng-show="{{a.status == '0' }}">
                                        不可用</p>
                                </td>
                            </tr>
                            </tbody>
                        </table>

                        <div class="row">
                            <div class="col-sm-2">
                                共 {{total}} 个经销商，共{{totalPageSize}}页
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
</div>
<%-- 隐藏域表单 ，用于提交复选框选的多个id--%>
<form action="" method="post" id="formid">
    <input type="hidden" name="checkedIds" id="checkedIds"/>
    <input type="hidden" name="agency.status" id="status" value="1"/>
</form>

<form target="_blank" method="post" id="detform">
    <input type="hidden" name="agency.id" id="agency_id"/>
</form>

</body>
<script src="<%=path%>/public/js/jquery.min.js"></script>
<script src="<%=path%>/public/js/bootstrap.min.js"></script>
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
        app.controller('myCtrl', function ($scope, $http, $timeout) {

            $scope.total = 0;
            $scope.totalPageSize = 0;
            $scope.agency = "";
            $scope.count1 = 1;
            extracted($scope.count1);

            function extracted(x) {
                $http({
                    method: 'POST',
                    url: "<%=path%>/agency/agencyAll",
                    data: {"pageNo": x}
                }).then(function successCallback(response) {
                    $scope.total = response.data.agencyPager.total;
                    $scope.totalPageSize = response.data.agencyPager.totalPageSize;
                    $scope.agency = response.data.agencyPager.result;
                    $scope.count1 = response.data.agencyPager.pageNo;
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
        });
    }(jQuery));
</script>

<script>
    $("#myTable").tableCheck("warning");

    function changeStatus(consoleTag) {
        //table表中选中的复选框赋值给checkedSubject
        var checkedSubject = $('#myTable input[name=agencyId]:checkbox:checked');
        var checkedIds = "";
        checkedSubject.each(function () {
            checkedIds = checkedIds + "," + $(this).val();
        });
        //上面的字符串赋值给隐藏域表单
        if (checkedIds.length > 0) {
            $('#checkedIds').val(checkedIds);
            if ("change" == consoleTag) {
                $.post("<%=path %>/agency/statusChange",
                    $("#formid").serialize(),
                    function (data) {
                        if (data.result.result == 'success') {
                            layer.alert('冻结成功！', {
                                skin: 'layui-layer-lan' //样式类名
                                , closeBtn: 0
                            }, function () {
                                window.location.reload(true);
                            });
                        } else {
                            layer.msg(data.result.msg);
                        }
                    }, 'json'
                )
            }
        } else {
            layer.msg("请选择一行！");
        }
    }
    function agencyDetail() {
        var chk_value = [];
        $('input[name="agencyId"]:checked').each(function () {
            chk_value.push($(this).val());
        });
        if (chk_value.length == 1) {
            $('#agency_id').val(chk_value);
            $('#detform').prop("action", "<%=path %>/agency/agencyDetailPage").submit();
        } else {
            layer.msg("请选择一行！");
        }
    }

</script>
</html>
