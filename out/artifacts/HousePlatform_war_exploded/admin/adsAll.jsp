<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%><!DOCTYPE html>
<html>
<head>
    <title>广告添加</title>
</head>
<link href="<%=path%>/public/css/bootstrap.min.css" rel="stylesheet">
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
                            <th colspan="6">
                                <button type="button" class="btn btn-primary" onclick="changeYes();">激活</button>
                                <button type="button" class="btn btn-primary" onclick="changeNo();">冻结</button>
                                <button type="button" class="btn btn-primary" data-toggle="modal"
                                        ng-click="onclickChange($index);">广告修改
                                </button>
                                <button type="button" class="btn btn-primary" data-toggle="modal"
                                        ng-click="onclickbtn($index);">查看详情
                                </button>
                            </th>
                            <th>
                                <button class="btn btn-primary" onclick="window.location.reload(true);">刷新</button>
                            </th>
                            </thead>
                            <tr>
                                <th><input type="checkbox"/></th>
                                <th>广告标题</th>
                                <th>广告描述</th>
                                <th>广告URL</th>
                                <th>显示位置</th>
                                <th>是否显示</th>
                                <th>是否可用</th>
                            </tr>
                            <tbody>
                            <tr ng-repeat="ads in ads">
                                <td>
                                    <input type="checkbox" title="{{$index}}" name="adsId" id="adsId"
                                           value="{{ads.id}}"/>
                                </td>
                                <td>{{ads.title }}</td>
                                <td>{{ads.content}}</td>
                                <td>{{ads.ad_url}}</td>
                                <td>
                                    <span ng-show="{{ads.show_order == '1' }}">首页第一行第一位置</span>
                                    <span ng-show="{{ads.show_order == '2' }}">首页第一行第二位置</span>
                                    <span ng-show="{{ads.show_order == '3' }}">首页第一行第三位置</span>
                                    <span ng-show="{{ads.show_order == '4' }}">首页第二行第一位置</span>
                                    <span ng-show="{{ads.show_order == '5' }}">首页第二行第二位置</span>
                                    <span ng-show="{{ads.show_order == '6' }}">首页第二行第三位置</span>
                                    <span ng-show="{{ads.show_order == '7' }}">首页第三行第一位置</span>
                                    <span ng-show="{{ads.show_order == '8' }}">首页第三行第二位置</span>
                                    <span ng-show="{{ads.show_order == '9' }}">首页第三行第三位置</span>
                                    <span ng-show="{{ads.show_order == '10' }}">户型大全</span>
                                    <span ng-show="{{ads.show_order == '11' }}">咨询中心第一个大图</span>
                                    <span ng-show="{{ads.show_order == '12' }}">咨询中心第一个小图</span>
                                    <span ng-show="{{ads.show_order == '13' }}">咨询中心第二个小图</span>
                                    <span ng-show="{{ads.show_order == '14' }}">活动第一个位置</span>
                                    <span ng-show="{{ads.show_order == '15' }}">活动第二个位置</span>
                                    <span ng-show="{{ads.show_order == '16' }}">活动第三个位置</span>
                                    <span ng-show="{{ads.show_order == '17' }}">活动第四个位置</span>
                                    <span ng-show="{{ads.show_order == '18' }}">楼盘详细信息</span>
                                    <span ng-show="{{ads.show_order == '19' }}">楼盘活动</span>
                                    <span ng-show="{{ads.show_order == '20' }}">楼盘历史价格</span>
                                    <span ng-show="{{ads.show_order == '21' }}">楼盘户型图</span>
                                    <span ng-show="{{ads.show_order == '22' }}">楼盘点评</span>
                                    <span ng-show="{{ads.show_order == '23' }}">楼盘销售员</span>
                                    <span ng-show="{{ads.show_order == '24' }}">楼盘在线看房</span>
                                    <span ng-show="{{ads.show_order == '25' }}">楼盘留言</span>
                                    <span ng-show="{{ads.show_order == '26' }}">户型详情页</span>
                                </td>
                                <td>
                                    <span ng-show="{{ads.show_status == '1' }}">显示</span>
                                    <span ng-show="{{ads.show_status == '0' }}" style="color:red;">不显示</span>
                                </td>
                                <td>
                                    <span ng-show="{{ads.status == '1' }}">可用</span>
                                    <span ng-show="{{ads.status == '0' }}" style="color:red;">不可用</span>
                                </td>
                            </tr>
                            </tbody>
                        </table>

                        <div class="row">
                            <div class="col-sm-2">
                                共 {{total}}个广告，共{{totalPageSize}}页
                            </div>
                            <div class="col-sm-10">
                                <nav aria-label="Page navigation" class="pull-right">
                                    <ul class="pagination">
                                        <li ng-click="top()"><a>«</a></li>
                                        <li><a class="page" ng-show="count1>=5 " ng-click="page(count1-4)">{{count1-4}}</a></li>
                                        <li><a class="page" ng-show="count1>=4 " ng-click="page(count1-3)">{{count1-3}}</a></li>
                                        <li><a class="page" ng-show="count1>=3 " ng-click="page(count1-2)">{{count1-2}}</a></li>
                                        <li><a class="page" ng-show="count1>=2 " ng-click="page(count1-1)">{{count1-1}}</a></li>
                                        <li class="active"><a class="page" ng-show="count1>0" ng-click="page(count1)" title="{{count1}}">{{count1}}</a>
                                        </li>
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


<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog  modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">广告详情</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label class="col-sm-2  control-label">广告标题:</label>
                    <div class="col-sm-10  input-parent">
                        <p id="title"></p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2  control-label">广告URL：</label>
                    <div class="col-sm-10  input-parent">
                        <p><a id="url" target="_blank">http://www.baidu.com</a></p><br/>
                    </div>
                </div>
                <div class="form-group">
                    <label for="content" class="col-sm-2  control-label">广告内容：</label>
                    <div class="col-sm-10  input-parent">
                        <p id="content"></p><br/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2  control-label">广告视图：</label>
                    <div class="col-md-10">
                        <div class="form-group">
                            <img id="logo" border="0" width="100" height="auto">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2  control-label">添加时间:</label>
                        <div class="col-sm-10  input-parent">
                            <p id="created_time"></p>
                        </div>
                    </div>
                </div>
                <div class="modal-footer" style="border-top: 0px solid #e5e5e5;">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modalChange" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog  modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">广告修改</h4>
            </div>
            <form id="adsForm" enctype="multipart/form-data">
                <input type="hidden" name="ads.id" id="id"/>
                <div class="form-group">
                    <label for="title1" class="col-sm-2  control-label">广告标题：</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control vinput" id="title1" name="ads.title"
                               placeholder="请输入广告标题"/><br/>
                    </div>
                </div>

                <div class="form-group ">
                    <label for="content1" class="col-sm-2  control-label">广告描述：</label>
                    <div class="col-sm-10">
                            <textarea class="form-control" id="content1" name="ads.content"
                                      placeholder="请输入广告描述，请限制在五十字以内" maxlength="50"></textarea><br/>
                        <span></span>
                    </div>
                </div>

                <div class="form-group ">
                    <label for="url1" class="col-sm-2  control-label">广告URL：</label>
                    <div class="col-sm-10">
                        <input class="form-control" id="url1" name="ads.ad_url" placeholder="请输入正确的广告链接地址"/><br/>
                        <span></span>
                    </div>
                </div>

                <div class="form-group ">
                    <label class="col-sm-2  control-label">广告位置：</label>
                    <div class="col-sm-10">
                        <select class="form-control" name="ads.show_order" id="show_order">
                            <option value="1">首页第一行第一位置</option>
                            <option value="2">首页第一行第二位置</option>
                            <option value="3">首页第一行第三位置</option>
                            <option value="4">首页第二行第一位置</option>
                            <option value="5">首页第二行第二位置</option>
                            <option value="6">首页第二行第三位置</option>
                            <option value="7">首页第三行第一位置</option>
                            <option value="8">首页第三行第二位置</option>
                            <option value="9">首页第三行第三位置</option>
                            <option value="10">户型大全</option>
                            <option value="11">咨询中心第一个大图</option>
                            <option value="12">咨询中心第一个小图</option>
                            <option value="13">咨询中心第二个小图</option>
                            <option value="14">活动第一个位置</option>
                            <option value="15">活动第二个位置</option>
                            <option value="16">活动第三个位置</option>
                            <option value="17">活动第四个位置</option>
                            <option value="18">楼盘详细信息</option>
                            <option value="19">楼盘活动</option>
                            <option value="20">楼盘历史价格</option>
                            <option value="21">楼盘户型图</option>
                            <option value="22">楼盘点评</option>
                            <option value="23">楼盘销售员</option>
                            <option value="24">楼盘在线看房</option>
                            <option value="25">楼盘留言</option>
                            <option value="26">户型详情页</option>
                        </select><br/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2  control-label">广告图片：</label>
                    <div class="col-md-10">
                        <div class="form-group">
                            <div id="preview">
                                <img id="imghead" border="0" width="90" height="auto"
                                     onclick="$('#previewImg').click();">
                            </div>
                            <input type="file" onchange="previewImage(this)" style="display: none;" id="previewImg"
                                   name="logo"/><br/>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2  control-label"></label>
                    <div class="col-sm-10">
                        <input type="button" class="btn btn-info" value="修改" onclick="adsChangeInfo();"
                               style="background-color: #1ab394;  border-color: #1ab394;  color: #FFF;"/>
                    </div>
                </div>
            </form>
            <div class="modal-footer" style="border-top: 0px solid #e5e5e5;">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>

<form method="post" id="formid">
    <input type="hidden" name="checkedIds" id="checkedIds"/>
    <input type="hidden" name="ads.status" id="status"/>
</form>

<script src="<%=path%>/public/js/jquery.min.js"></script>
<script src="<%=path%>/public/js/bootstrap.min.js"></script>
<script src="<%=path %>/public/js/jQuery.form.min.js"></script>
<script src="<%=path %>/public/admin/js/myFileUpload.js"></script>
<script src="<%=path %>/public/admin/js/tableCheckbox.js"></script>
<script src="<%=path %>/layer-v3.1.0/layer/layer.js"></script>
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
        app.controller('myCtrl', function ($scope, $http, $timeout) {
            $scope.total = 0;
            $scope.totalPageSize = 0;
            $scope.ads = "";
            $scope.count1 = 1;
            extracted($scope.count1);
            function extracted(x) {
                $http({
                    method: 'POST',
                    url: "<%=path%>/ads/adsAll",
                    data: {"pageNo": x}
                }).then(function successCallback(response) {
                    $scope.total = response.data.pager.total;
                    $scope.totalPageSize = response.data.pager.totalPageSize;
                    $scope.ads = response.data.pager.result;
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

            $scope.onclickbtn = function (x) {//广告详情
                if ($("input[name='adsId']:checkbox:checked").length == 1) {
                    $("#myModal").modal("show");
                    $scope.count = $("input[name='adsId']:checkbox:checked").attr("title");
                    $("#title").text($scope.ads[$scope.count].title);
                    $("#url").attr('href', $scope.ads[$scope.count].ad_url);
                    $("#content").html($scope.ads[$scope.count].content);
                    document.getElementById("logo").src = "<%=path %>/" + $scope.ads[$scope.count].logo;
                    $("#created_time").text($scope.ads[$scope.count].created_time);
                } else {
                    layer.msg("请选择一行！");
                }
            };
            $scope.onclickChange = function (x) {//广告修改
                if ($("input[name='adsId']:checkbox:checked").length == 1) {
                    $("#modalChange").modal("show");
                    $scope.count = $("input[name='adsId']:checkbox:checked").attr("title");
                    $("#id").val($scope.ads[$scope.count].id);
                    $("#title1").val($scope.ads[$scope.count].title);
                    $("#url1").val($scope.ads[$scope.count].ad_url);
                    $("#show_order").attr('href', $scope.ads[$scope.count].id);
                    $("#content1").html($scope.ads[$scope.count].content);
                    document.getElementById("imghead").src = "<%=path %>/" + $scope.ads[$scope.count].logo;
                    $("#created_time1").text($scope.ads[$scope.count].created_time);
                } else {
                    layer.msg("请选择一行！");
                }
            };
        });
    }(jQuery));

    function changeYes() { // 暂时只能冻结用户，判断等页面完成
        var chk_value = [];
        $('input[name="adsId"]:checked').each(function () {
            chk_value.push($(this).val());
        });
        if (chk_value.length == 0) {
            layer.msg("请选择一行！");
        } else {
            $('#checkedIds').val(chk_value);
            $('#status').val(0);
            layer.alert('激活成功！', {
                skin: 'layui-layer-lan' //样式类名
                , closeBtn: 0
            }, function () {
                $('#formid').prop("action", "<%=path %>/ads/statusChang").submit();
            });
        }
    }

    function changeNo() { // 暂时只能冻结用户，判断等页面完成
        var chk_value = [];
        $('input[name="adsId"]:checked').each(function () {
            chk_value.push($(this).val());
        });
        if (chk_value.length == 0) {
            layer.msg("请选择一行！");
        } else {
            $('#checkedIds').val(chk_value);
            $('#status').val(1);
            layer.alert('冻结成功！', {
                skin: 'layui-layer-lan' //样式类名
                , closeBtn: 0
            }, function () {
                $('#formid').prop("action", "<%=path %>/ads/statusChang").submit();
            });
        }
    }

    function adsChangeInfo() {
        $("#adsForm").ajaxSubmit({
            type: 'post', // 提交方式 get/post
            url: '<%=path %>/ads/adsChangeInfo', // 需要提交的 url
            dataType: 'json',
            data: $("#adsForm").serialize(),
            success: function (data) { // data 保存提交后返回的数据，一般为 json 数据
                // 此处可对 data 作相关处理
                if (data.controllerResult.result == 'success') {
                    layer.alert('修改成功！', {
                        skin: 'layui-layer-lan' //样式类名
                        , closeBtn: 0
                    }, function () {
                        window.location.reload(true);
                    });
                } else {
                    layer.msg("修改失败！");
                }
            }
        });
        return false; // 阻止表单自动提交事件
    }
</script>
</body>
</html>
