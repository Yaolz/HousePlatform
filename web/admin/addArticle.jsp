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
    <title>添加文章</title>
</head>
<%
    String path = request.getContextPath();
%>
<link href="<%=path%>/public/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=path%>/public/admin/css/admincheck.css" rel="stylesheet">
<link href="<%=path%>/public/admin/css/bootstrap-datetimepicker.css" rel="stylesheet">
<link href="<%=path %>/public/dist/summernote.css" rel="stylesheet"/>
<style>
    .btn-primary {
        background-color: #1ab394;
        border-color: #1ab394;
        color: #FFF;
    }
</style>
<body class="container">
<form id="addArticle" method="post">
    <input type="hidden" name="admin.id" value="${admin.id }"/>
    <div class="form-group">
        <label class="col-sm-2  control-label">标题：</label>
        <div class="col-sm-10  input-parent">
            <input id="title" type="text" class="form-control" name="article.title"/>
            <span id="titleError" style="color:red"></span><br/>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-2  control-label">类别：</label>
        <div class="col-sm-10  input-parent">
            <select name="articleType.id" class="form-control">
                <c:forEach items="${requestScope.articleTypes }" var="types">
                    <option value="${types.id }">${types.name }</option>
                </c:forEach>
            </select><br/>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-2  control-label">文章概要：</label>
        <div class="col-sm-10  input-parent">
            <input id="abstracts" type="text" class="form-control" name="article.abstracts"/>
            <span id="abstractsError" style="color:red"></span><br/>
        </div>
    </div>
    <div class="form-group">
        <label for="content" class="col-sm-2  control-label">文章内容：</label>
        <div class="col-sm-10  input-parent">
            <textarea class="form-control summernote" rows="3" id="content"  name="article.content" style="height: 200px;"  placeholder="请输入活动内容"></textarea>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-2  control-label">文章图片：</label>
        <div class="col-md-10">
            <div class="form-group">
                <div id="preview">
                    <img id="imghead" border="0" src="<%=path %>/public/admin/photo_icon.png" width="90" height="90"
                         onclick="$('#previewImg').click();">
                </div>
                <input type="file" onchange="previewImage(this)" style="display: none;" id="previewImg" name="upload"/>
            </div>
        </div>
    </div>
    <div class="form-group">
        <label  class="col-sm-2  control-label"></label>
        <div class="col-sm-10  input-parent">
            <input type="button" class="btn btn-primary" value="添加" onclick="addArticle();"/>
        </div>
    </div>
</form>
</body>
<script src="<%=path%>/public/js/jquery.min.js"></script>
<script src="<%=path %>/public/js/jQuery.form.min.js"></script>
<script src="<%=path%>/public/js/bootstrap.min.js"></script>
<script src="<%=path %>/public/dist/summernote.js"></script>
<script src="<%=path %>/public/dist/lang/summernote-zh-CN.js"></script>
<script src="<%=path %>/public/admin/js/myFileUpload.js"></script>
<script src="<%=path %>/layer-v3.1.0/layer/layer.js"></script>
<script>
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
    $(document).ready(function () {
        $("#abstracts").blur(function () {
            var abstracts = $("#abstracts").val();
            var abstractsError = $("#abstractsError");
            if (abstracts.length <= 0) {
                abstractsError.text("概要不能为空");
            }
        });
    });
    //添加文章
    function addArticle() {
        var  title=$("#title").val();
        var titleError=$("#titleError");
        var  abstracts=$("#abstracts").val();
        var abstractsError=$("#abstractsError");
        if(title.length<=0 || abstracts.length<=0 ){
            titleError.text("标题不能为空");
            abstractsError.text("摘要不能为空");
            return;
        }
        $("#addArticle").ajaxSubmit({
            type: 'post', // 提交方式 get/post
            url: '/article/addArticle', // 需要提交的 url
            dataType : 'json',
            data:$("#addArticle").serialize(),
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
                   layer.msg("添加失败！");
                }
            }
        });
        return false; // 阻止表单自动提交事件
    }
</script>
</html>
