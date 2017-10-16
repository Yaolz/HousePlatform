$().ready(function() {
// 在键盘按下并释放及提交后验证提交表单
    $("#signupForm").validate({
        rules: {
            email: {
                required: true
            },
            pwd: {
                required: true
            }
        },
        messages: {
            email: {
                required: "请输入用户名"
            },
            pwd: {
                required: "请输入密码"
            }
        }
    });
    function GetQueryString(name) {//获取url上的值
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if(r!=null){
            return  unescape(r[2]);
        }
        return null;
    }
    var  frameindex= parent.layer.getFrameIndex(window.name);//当此页面被其他页面弹窗时，获取此页面元素
    var url = GetQueryString("url");
    $("#submit").click(function(){
        if ($("#signupForm").valid()==true) {//校验通过则返回true,不通过则false：
            $.post($("#path").val()+"/index/login",
                $("#signupForm").serialize(),
                function (data) {
                    if (data.result.result =='success') {
                        parent.layer.close(frameindex);//此页面被其他页面iframe弹窗时，调用此方法进行关闭
                        if(data.result.url == 'staff/home'||data.result.url == 'agency/Agency'){
                            parent.self.location =$("#path").val()+"/"+data.result.url;
                        }else {
                            parent.location.href =url +"";//刷新父页面
                        }
                    }else if(data.result.result =='fail'){
                        layer.msg(data.result.msg);
                    }
                }, "json"
            );
        }
    });
});
