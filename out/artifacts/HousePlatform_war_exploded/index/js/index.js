$("#login").click(function(){
    layer.ready(function(){
        layer.open({
            type: 2,
            title: '登入',
            maxmin: true,
            area: ['800px', '500px'],
            content: $("#path").val()+'/index/indexlogin?url='+window.location.href,
            cancel: function(){
                //关闭当前窗口时就进入此方法
            }
        });
    });
});