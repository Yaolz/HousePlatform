<%--
  Created by IntelliJ IDEA.
  User: yao
  Date: 2017/8/29
  Time: 20:39
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
<style>
    .btn-primary {
        background-color: #1ab394;
        border-color: #1ab394;
        color: #FFF;
    }
</style>
<body>
<div class="container">
    <form id="typeAdd" method="post" >
        <div class="form-group">
            <label for="name" class="col-sm-2  control-label">类型名称:</label>
            <div class="col-sm-10  input-parent">
                <input id="name" type="text" class="form-control" name="articleType.name"   placeholder="类别"/><br/>
            </div>
        </div>
        <div class="form-group">
            <label for="des" class="col-sm-2  control-label">类型描述:</label>
            <div class="col-sm-10  input-parent">
                <textarea id="des" class="form-control" rows="3" name="articleType.des" style="height: 200px;" placeholder="类型描述"></textarea><br/>
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2  control-label"></label>
            <div class="col-sm-10  input-parent">
                <input type="button" class="btn btn-primary" value="添加"  onclick="addArticlesType();" />
            </div>
        </div>
    </form>
</div>
</body>
<script src="<%=path%>/public/js/jquery.min.js"></script>
<script src="<%=path%>/public/js/bootstrap.min.js"></script>
<script src="<%=path %>/layer-v3.1.0/layer/layer.js"></script>
<script>
    //添加文章类型
    function addArticlesType(){
        $.post("/type/addArticleType",
            $("#typeAdd").serialize(),
            function(data){
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
            },'json'
        );
    }
</script>
</html>
