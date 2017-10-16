<%--
  Created by IntelliJ IDEA.
  User: 娃娃鱼
  Date: 2017/8/31
  Time: 10:49
  To change this template use File | Settings | File Templates.
--%>
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
<link href="<%=path %>/public/admin/css/fileinput.min.css" rel="stylesheet"/>
<style>
    .btn-primary {
        background-color: #1ab394;
        border-color: #1ab394;
        color: #FFF;
    }
</style>
<body>
<div class="container">
    <div class=" row">
        <div class="col-lg-8 col-lg-offset-2  col-xs-12 col-md-10 col-md-offset-1   col-sm-12">
            <form id="addform" method="post" enctype="multipart/form-data">

                <div class="form-group">
                    <label for="title" class="col-sm-2  control-label">广告标题：</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control vinput" id="title" name="ads.title" placeholder="请输入广告标题" /><br/>
                        <span></span>
                    </div>
                </div>

                <div class="form-group ">
                    <label for="content" class="col-sm-2  control-label">广告描述：</label>
                    <div class="col-sm-10">
                        <textarea class="form-control vinput" id="content" name="ads.content" placeholder="请输入广告描述，请限制在五十字以内" maxlength="50"></textarea><br/>
                        <span></span>
                    </div>
                </div>

                <div class="form-group ">
                    <label for="url" class="col-sm-2  control-label">广告URL：</label>
                    <div class="col-sm-10">
                        <input class="form-control vinput" id="url" name="ads.ad_url" placeholder="请输入正确的广告链接地址" /><br/>
                        <span></span>
                    </div>
                </div>

                <div class="form-group ">
                    <label class="col-sm-2  control-label">广告位置：</label>
                    <div class="col-sm-10">
                        <select class="form-control" name="ads.show_order" >
                            <option>请选择广告要放置的位置</option>
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
                                <img id="imghead" border="0" src="<%=path %>/public/admin/photo_icon.png" width="90" height="90" onclick="$('#previewImg').click();">
                            </div>
                            <input type="file" onchange="previewImage(this)" style="display: none;" id="previewImg" name="logo"/><br/>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2  control-label"></label>
                    <div class="col-md-10">
                        <input type="button" class="btn btn-primary" value="添加" onclick="addAds();"/>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="<%=path%>/public/js/jquery.min.js"></script>
<script src="<%=path %>/public/js/jQuery.form.min.js"></script>
<script src="<%=path%>/public/js/bootstrap.min.js"></script>
<script src="<%=path %>/public/admin/js/myFileUpload.js"></script>
<script src="<%=path %>/layer-v3.1.0/layer/layer.js"></script>
<script>
    function addAds() {
        $("#addform").ajaxSubmit({
            type: 'post', // 提交方式 get/post
            url: '<%=path %>/ads/adsAdd', // 需要提交的 url
            dataType : 'json',
            data:$("#addform").serialize(),
            success: function(data) { // data 保存提交后返回的数据，一般为 json 数据
                // 此处可对 data 作相关处理
                if(data.controllerResult.result =='success'){
                    layer.alert('添加成功！', {
                        skin: 'layui-layer-lan' //样式类名
                        , closeBtn: 0
                    }, function () {
                        window.location.reload();
                    });
                } else{
                    layer.msg(data.controllerResult.msg);
                }
            }
        });
        return false; // 阻止表单自动提交事件
    }
</script>

</body>
</html>
