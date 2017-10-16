<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: yao
  Date: 2017/8/31
  Time: 15:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html><html>
<head>
    <title>添加活动</title>
</head>
<%
    String path = request.getContextPath();
%>
<link href="<%=path%>/public/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=path%>/public/admin/css/admincheck.css" rel="stylesheet">
<link href="<%=path%>/public/admin/css/bootstrap-datetimepicker.css" rel="stylesheet">
<link href="<%=path %>/public/dist/summernote.css" rel="stylesheet"/>
<body>
<div class="container">
    <div class=" row">
        <div class="col-lg-8 col-lg-offset-2  col-xs-12 col-md-10 col-md-offset-1   col-sm-12">
            <form id="addActivities" method="post" enctype="multipart/form-data">
                <br/>
                <div class="form-group">
                    <label for="title" class="col-sm-2  control-label">活动标题:</label>
                    <div class="col-sm-10  input-parent">
                        <input type="text" class="form-control" id="title" name="activity.title"
                               placeholder="请输入标题"><br/>
                        <span id="titleError" style="color:red;"></span>
                    </div>
                </div>
                <div class="form-group">
                    <label for="start_time" class="col-sm-2  control-label">开始时间:</label>
                    <div class="col-sm-10  input-parent">
                        <input size="16" type="text" class="form-control form_datetime" value="2017-09-26 10:00"
                               id="start_time" name="activity.start_time" style="background-color: white" readonly><br/>
                    </div>
                </div>
                <div class="form-group">
                    <label for="end_time" class="col-sm-2  control-label">结束时间:</label>
                    <div class="col-sm-10  input-parent">
                        <input size="16" type="text" class="form-control form_datetime" value="2017-09-26 10:00"
                               id="end_time" name="activity.end_time" style="background-color: white" readonly><br/>
                    </div>
                </div>
                <div class="form-group">
                    <label for="content" class="col-sm-2  control-label">活动内容：</label>
                    <div class="col-sm-10  input-parent">
                        <textarea id="content" class="summernote" rows="3" name="activity.content"
                                  style="height: 200px;" placeholder="活动内容"></textarea><br/>
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
                    <label class="col-sm-2  control-label">活动图片：</label>
                    <div class="col-md-10">
                        <div class="form-group">
                            <div id="preview">
                                <img id="imghead" border="0" src="<%=path %>/public/admin/photo_icon.png" width="90"
                                     height="auto"
                                     onclick="$('#previewImg').click();">
                            </div>
                            <input type="file" onchange="previewImage(this)" style="display: none;" id="previewImg"
                                   name="upload"/>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-2 ">
                    </div>
                    <div class="col-sm-10  input-parent">
                        <input type="button" class="btn btn-primary" value="添加" onclick="addActivity();"/>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
<script src="<%=path%>/public/js/jquery.min.js"></script>
<script src="<%=path %>/public/js/jQuery.form.min.js"></script>
<script src="<%=path%>/public/js/bootstrap.min.js"></script>
<script src="<%=path %>/public/admin/js/myFileUpload.js"></script>
<script src="<%=path %>/public/admin/js/bootstrap-datetimepicker.js"></script>
<script src="<%=path %>/public/admin/js/bootstrap-datetimepicker.zh-CN.js"></script>
<script src="<%=path %>/public/dist/summernote.js"></script>
<script src="<%=path %>/public/dist/lang/summernote-zh-CN.js"></script>
<script src="<%=path%>/public/js/bootstrus-date-from.js"></script>
<script src="<%=path %>/layer-v3.1.0/layer/layer.js"></script>
<script type="text/javascript">
    $(function () {
        $('.summernote').summernote({
            height: 200,
            tabsize: 2,
            lang: 'zh-CN'
        });
    });

    $(document).ready(function () {
        $("#title").blur(function () {
            var title = $("#title").val();
            var titleError = $("#titleError");
            if (title.length <= 0) {
                titleError.text("标题不能为空");
            }
        });
    });

    //添加活动
    function addActivity() {
        $("#addActivities").ajaxSubmit({
            type: 'post',
            url: '<%=path %>/activity/addActivity',
            dataType: 'json',
            data: $("#addActivities").serialize(),
            success: function (data) {
                if (data.controllerResult.result == 'success') {
                    layer.alert('激活成功！', {
                        skin: 'layui-layer-lan' //样式类名
                        , closeBtn: 0
                    }, function () {
                        $('#formid').prop("action", "<%=path %>/activity/status").submit();
                    });
                    layer.alert('添加成功！', {
                        skin: 'layui-layer-lan' //样式类名
                        , closeBtn: 0
                    }, function () {
                        window.location.reload();
                    });
                } else {
                    layer.msg('添加失败！');
                }
            }
        });
        return false;
    }

</script>
</html>
