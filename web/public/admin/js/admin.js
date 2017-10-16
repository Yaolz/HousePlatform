//管理员登录
function adminLogin(){
    var email = $("#email").val();
    var pwd = $("#pwd").val();
    var errorEmail = $("#errorEmail");
    var errorPwd = $("#errorPwd");
    if(email == null || email.trim()==""||pwd == null || pwd.trim()=="") {
        errorEmail.text("邮箱不能为空，请输入邮箱");
        errorPwd.text("密码不能为空，请输入密码");
        return;
    }
    $.post("/admin/login",
        $("#adminLogin").serialize(),
        function(data){
            if(data.controllerResult.result =='success'){
                window.location.href="/admin/home"
            } else{
                swal(data.controllerResult.msg);
            }
        },'json'
    );
}

//修改文章类型
function changeArticleType(){
    $.post("/type/changeArticleType",
        $("#changeType").serialize(),
        function(data){
            if(data.controllerResult.result =='success'){
                swal({
                    title: '修改成功',
                    text: "修改成功",
                    type: 'success',
                    confirmButtonColor: '#3085d6',
                    confirmButtonText: '确定'
                }, function () {
                    window.location.reload();
                })
            } else{
                swal(data.controllerResult.msg);
            }
        },'json'
    );
}





