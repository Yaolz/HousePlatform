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
    <title>Title</title>
</head>
<link href="<%=path%>/public/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=path%>/public/admin/css/admincheck.css" rel="stylesheet">
<link href="<%=path %>/public/dist/summernote.css" rel="stylesheet"/>
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
                                <button type="button" class="btn btn-primary" onclick="artdetail();">查看详情</button>
                                <button type="button" class="btn btn-primary" data-toggle="modal"
                                        ng-click="onclickbtn($index);">修改</button>
                            </th>
                            <th>
                                <button class="btn btn-primary" onclick="window.location.reload(true);">刷新</button>
                            </th>
                            </thead>
                            <tr>
                                <th><input type="checkbox"></th>
                                <th>标题</th>
                                <th>文章摘要</th>
                                <th>类别</th>
                                <th>发表时间</th>
                                <th>是否可用</th>
                            </tr>
                            <tbody>
                            <tr ng-repeat="a in article">
                                <td><input type="checkbox"  title="{{$index}}" name="artId" id="artId" value="{{a.id}}"/></td>
                                <td >{{a.title}}</td>
                                <td>{{a.abstracts}}</td>
                                <td>{{a.articleType.name}}</td>
                                <td>{{a.created_time | date:'yyyy-MM-dd hh:mm'}}</td>
                                <td>
                                    <span ng-show="{{a.status == '1' }}">可用</span>

                                    <span ng-show="{{a.status == '0' }}" style="color:red;">不可用</span>
                                </td>
                            </tr>
                            </tbody>
                        </table>

                        <div class="row">
                            <div class="col-sm-2">
                                共 {{total}} 篇文章，共{{totalPageSize}}页
                            </div>
                            <div class="col-sm-10">
                                <nav aria-label="Page navigation" class="pull-right">
                                    <ul class="pagination">
                                        <li ng-click="top()"><a>«</a></li>
                                        <li><a class="page" ng-show="count1>=5 " ng-click="page(count1-4)">{{count1-4}}</a></li>
                                        <li><a class="page" ng-show="count1>=4 " ng-click="page(count1-3)">{{count1-3}}</a></li>
                                        <li><a class="page" ng-show="count1>=3 " ng-click="page(count1-2)">{{count1-2}}</a></li>
                                        <li><a class="page" ng-show="count1>=2 " ng-click="page(count1-1)">{{count1-1}}</a></li>
                                        <li><a class="page" ng-show="count1>0" ng-click="page(count1)" title="{{count1}}">{{count1}}</a>
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

    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog  modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">修改文章</h4>
                </div>
                <div class="modal-body">
                    <form id="changeArt" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="article.id" id="id"/>
                        <input type="hidden" name="admin.id" value="${admin.id}"/>
                        <div class="form-group">
                            <label class="col-sm-2  control-label">文章标题:</label>
                            <div class="col-sm-10  input-parent">
                                <input id="title" type="text" class="form-control" name="article.title"/><br/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2  control-label">文章类别:</label>
                            <div class="col-sm-10  input-parent">
                                <select id="type" name="articleType.id" class="form-control">
                                    <c:forEach items="${requestScope.articleTypes }" var="types">
                                        <option value="${types.id }">${types.name }</option>
                                    </c:forEach>
                                </select><br/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2  control-label">文章摘要:</label>
                            <div class="col-sm-10  input-parent">
                                <input id="abstracts" type="text" class="form-control" name="article.abstracts"/><br/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="content" class="col-sm-2  control-label">文章内容：</label>
                            <div class="col-sm-10  input-parent">
                                <textarea id="content" class="summernote" rows="3" name="article.content"
                                          style="height: 200px;" placeholder="活动内容"></textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2  control-label">文章图片：</label>
                            <div class="col-md-10">
                                <div class="form-group">
                                    <div id="preview">
                                        <img id="imghead" border="0"
                                             width="90" height="90"
                                             onclick="$('#previewImg').click();">
                                    </div>
                                    <input type="file" onchange="previewImage(this)" style="display: none;"
                                           id="previewImg" name="upload"/>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2  control-label"></label>
                            <div class="col-sm-10  input-parent">
                                <input type="button" class="btn btn-default" value="修改" onclick="changeArticle();"
                                       style="background-color: #1ab394; border-color: #1ab394;color: #FFF"/>
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

<form target="_blank" method="post" id="detform">
    <input type="hidden" name="article.id" id="articleId"/>
</form>

<form method="post" id="formid">
    <input type="hidden" name="checkedIds" id="checkedIds"/>
    <input type="hidden" name="article.status" id="status"/>
</form>

</body>
<script src="<%=path%>/public/js/jquery.min.js"></script>
<script src="<%=path %>/public/js/jQuery.form.min.js"></script>
<script src="<%=path%>/public/js/bootstrap.min.js"></script>
<script src="<%=path %>/public/admin/js/myFileUpload.js"></script>
<script src="<%=path %>/public/dist/summernote.js"></script>
<script src="<%=path %>/public/dist/lang/summernote-zh-CN.js"></script>
<script src="<%=path %>/public/admin/js/tableCheckbox.js"></script>
<script src="<%=path %>/layer-v3.1.0/layer/layer.js"></script>

<script type="text/javascript">
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
            $scope.article = "";
            $scope.count1 = 1;
            extracted($scope.count1);

            function extracted(x) {
                $http({
                    method: 'POST',
                    url: "<%=path%>/article/articleInfo",
                    data: {"pageNo": x}
                }).then(function successCallback(response) {
                    $scope.total = response.data.pager.total;
                    $scope.totalPageSize = response.data.pager.totalPageSize;
                    $scope.article = response.data.pager.result;
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
                if($("input[name='artId']:checkbox:checked").length == 1) {
                    $("#myModal").modal("show");
                    $scope.count = $("input[name='artId']:checkbox:checked").attr("title");
                    $("#id").val($scope.article[$scope.count].id);
                    $("#title").val($scope.article[$scope.count].title);
                    $("#type").val($scope.article[$scope.count].articleType.id);
                    $("#abstracts").val($scope.article[$scope.count].abstracts);
                    $('#content').val($scope.article[$scope.count].content);
                    document.getElementById("imghead").src ="<%=path %>/" + $scope.article[$scope.count].logo;
                } else {
                    layer.msg("请选择一行！");
                }
            };
        });
    }(jQuery));

    function changeArticle() {
        $("#changeArt").ajaxSubmit({
            type: 'post', // 提交方式 get/post
            url: '<%=path %>/article/changeArticle', // 需要提交的 url
            dataType: 'json',
            data: $("#changeArt").serialize(),
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
                    swal(data.controllerResult.msg);
                }
            }
        });
        return false; // 阻止表单自动提交事件
    }

    function artdetail() {
        var chk_value = [];
        $('input[name="artId"]:checked').each(function () {
            chk_value.push($(this).val());
        });
        if(chk_value.length == 1) {
            $('#articleId').val(chk_value);
            $('#detform').prop("action", "<%=path %>/article/articleDetail").submit();
        } else {
            layer.msg("请选择一行！");
        }
    }

    function changeYes() {
        var chk_value =[];
        $('input[name="artId"]:checked').each(function(){
            chk_value.push($(this).val());
        });
        if(chk_value.length == 0) {
            layer.msg("请选择一行！");
        } else {
            $('#checkedIds').val(chk_value); // 给隐藏form表单的id input赋值
            $('#status').val(0); // 给status赋值，后台判断状态
            layer.alert('激活成功！', {
                skin: 'layui-layer-lan' //样式类名
                , closeBtn: 0
            }, function () {
                $('#formid').prop("action", "<%=path %>/article/status").submit();
            });
        }
    }

    function changeNo() {
        var chk_value =[];
        $('input[name="artId"]:checked').each(function(){
            chk_value.push($(this).val());
        });
        if(chk_value.length == 0) {
            layer.msg("请选择一行！");
        } else {
            $('#checkedIds').val(chk_value); // 给隐藏form表单的id input赋值
            $('#status').val(1); // 给status赋值，后台判断状态
            layer.alert('冻结成功！', {
                skin: 'layui-layer-lan' //样式类名
                , closeBtn: 0
            }, function () {
                $('#formid').prop("action", "<%=path %>/article/status").submit();
            });

        }
    }

</script>
</html>
