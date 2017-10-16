$(function() {
    // var oValiLen = $("#register-form").find("input").size();
    // var oValArray = new Array();
    // for(var i=0;i<oValiLen-1;i++){
    //     oValArray[i] = $("#register-form").find("input").eq(i).prop("id");
    //     oValArray[i] = '#'+oValArray[i] ;
    // };

    //表单验证
    $("#register-form").validate();

    //验证责任人的名称
    $("#leader").rules('add', {
        maxlength: 20,
        messages: {
            maxlength: '名称长度不能超过{0}位！'
        }
    });

    $("#tel").rules('add', {
        digits: true,
        tel: true,
        messages: {
            digits: '请输入正确的电话号码！',
            tel: '请输入正确的电话号码！'
        }
    });

    //地址验证
    $("#address").rules('add', {
        maxlength: 100,
        messages: {
            maxlength: '输入的信息不能超过100个字符'
        }
    });

    //简介验证
    $("#intro").rules('add', {
        maxlength: 498,
        messages: {
            maxlength: '输入的信息不能超过500个字符'
        }
    });

    //用户名
    $("#username").rules('add', {
        required: true,
        maxlength: 20,
        remote: {
            type: "post",
            url: $("#path").val() + "/index/queryName",
            dataType: "json",   //返回格式为json
            async: true,//请求是否异步，默认为异步，这也是ajax重要特性
            data: {
                name: function () {
                    return $("#username").val();
                }
            },
            dataFilter: function (data) {
                var jsonstr = eval("(" + data + ")");
                if (jsonstr.trues == "true") {
                    return false;
                } else if (jsonstr.trues == "false") {
                    if ($("#agency-name") != null && $("#agency-name") != undefined && $("#agency-name") != '' && $("#agency-name").val() == $("#username").val()) {
                        return false;
                    }
                    return true;
                }
            }
        },
        messages: {
            required: '请输入名称！',
            maxlength: '名称不能大于{0}位！',
            remote: "该名称正在被使用！"
        }
    });
    //手机
    $("#phone").rules('add', {
        required: true,
        rangelength: [11, 11],
        digits: true,
        phone: true,
        remote: {
            type: "post",
            url: $("#path").val() + "/index/queryByPhone",
            dataType: "json",   //返回格式为json
            async: true,//请求是否异步，默认为异步，这也是ajax重要特性
            data: {
                phone: function () {
                    return $("#phone").val();
                }
            },
            dataFilter: function (data) {
                var jsonstr = eval("(" + data + ")");
                if (jsonstr.trues == "true") {
                    return false;
                } else if (jsonstr.trues == "false") {
                    if ($("#agency-phone") != null && $("#agency-phone") != undefined && $("#agency-phone") != '' && $("#agency-phone").val() == $("#phone").val()) {
                        return false;
                    }
                    return true;
                }
            }
        },
        messages: {
            required: '请输入您的手机号！',
            rangelength: '请输入正确的手机号！',
            digits: '请输入正确的手机号！',
            phone: '请输入正确的手机号！',
            remote: "该手机号已被注册过了！"
        }
    });

    //生日
    $("#birthday").rules('add', {
        required: true,
        date: true,
        messages: {
            required: '请选择时间，如1993-03-29！',
            date: '时间格式不正确'
        }

    });
    //密码
    $("#password").rules('add', {
        required: true,
        minlength: 6,
        maxlength: 20,
        pass: true,
        messages: {
            required: '请输入6-20位密码，数字和字母！',
            minlength: '密码不能小于{0}位！',
            maxlength: '密码不能超过{0}位！',
            pass: '密码不能含数字和字母以外的符号！'
        }
    });
    //确认密码
    $("#notpass").rules('add', {
        required: true,
        equalTo: '#password',
        pass: true,
        messages: {
            required: '请再次输入密码',
            equalTo: '密码输入不一致',
            pass: '密码不能含数字和字母以外的符号！'
        }
    });
    // $(".accept").parents(".form-group").find("i").css("margin-right","5px");
    $("#accept").rules('add', {
        required: true,
        messages: {
            required: '请接受版权声明和隐私保护！'
        },
        highlight: function (element, errorClass) {
            setTimeout(function () {
                if ($("#accept-error").get(0)) {
                    $("#accept-error").css("display", "block")
                    $(".accept").insertBefore("#accept-error");

                }
            }, 0);
        }
    });

    //楼盘或楼栋的名称验证
    $("#name").rules('add', {
        required: true,
        maxlength: 50,
        messages: {
            required: '请输入名称！',
            maxlength: '楼盘名称不能大于{0}位！'
        }
    });


    //参考单价
    $("#unit_price").rules('add', {
        required: true,
        maxlength: 10,
        messages: {
            required: '请输入参考单价！',
            maxlength: '超出了范围！'
        }
    });

    //户型面积
    $("#area").rules('add', {
        required: true,
        maxlength: 10,
        messages: {
            required: '请输入户型面积！',
            maxlength: '没有那么大地方哦！'
        }
    });

    //占地面积
    $("#floor_area").rules('add', {
        required: true,
        maxlength: 12,
        messages: {
            required: '请输入楼盘占地面积！',
            maxlength: '没有那么大地方哦！'
        }
    });

    //建筑面积
    $("#building_area").rules('add', {
        required: true,
        maxlength: 16,
        messages: {
            required: '请输入建筑面积！',
            maxlength: '没有那么大地方哦！'
        }
    });

    //经度验证
    $("#longitude").rules('add', {
        required: true,
        maxlength: 11,
        longitude: true,
        messages: {
            required: '请输入你的位置经度！',
            maxlength: '你输入的经度超出了范围！',
            longitude: '你输入的经度是不合法的'
        }
    });

    //纬度验证
    $("#latitude").rules('add', {
        required: true,
        maxlength: 10,
        latitude: true,
        messages: {
            required: '请输入你的位置纬度！',
            maxlength: '你输入的纬度超出了范围！',
            latitude: '你输入的纬度是不合法的'
        }
    });

    //楼盘均价
    $("#avg_price").rules('add', {
        required: true,
        maxlength: 12,
        messages: {
            required: '请输入你楼盘均价',
            maxlength: '你输入数字过大！'
        }
    });

    //接待地址验证
    $("#reception_address").rules('add', {
        required: true,
        maxlength: 100,
        messages: {
            required: '请输入楼盘接待地址',
            maxlength: '输入的信息不能超过100个字符'
        }
    });

    //开发公司验证
    $("#company").rules('add', {
        maxlength: 100,
        messages: {
            maxlength: '输入的信息不能超过100个字符'
        }
    });

    //验证开盘时间
    $("#open_date").rules('add', {
        required: true,
        date: true,
        messages: {
            required: '请选择开盘时间，如1993-03-29！',
            date: '时间格式不正确'
        }
    });
    //验证总层数，数字长度
    $("#total_floor").rules('add', {
        required: true,
        maxlength: 3,
        messages: {
            required: '这是必填的',
            maxlength: '最多只能三位数'
        }
    });
    //验证电梯数
    $("#total_lift").rules('add', {
        required: true,
        maxlength: 3,
        messages: {
            required: '这是必填的',
            maxlength: '最多只能三位数'
        }
    });
    //验证总套数
    $("#total_rooms").rules('add', {
        maxlength: 8,
        messages: {
            maxlength: '只能输入10位数'
        }
    });


    //验证绿化率，限制数字长度
    $("#green_ratio").rules('add', {
        maxlength: 5,
        messages: {
            maxlength: '输入的数字过长'
        }
    });

    //验证容积率，限制数字长度
    $("#plot_ratio").rules('add', {
        maxlength: 5,
        messages: {
            maxlength: '输入的数字过长'
        }
    });

    //验证物业公司名称的长度
    $("#property_company").rules('add', {
        maxlength: 100,
        messages: {
            maxlength: '输入的信息过长'
        }
    });

    //验证物业费的整数长度
    $("#property_fee").rules('add', {
        maxlength: 10,
        messages: {
            maxlength: '输入的数字超出上限'
        }
    });
    //验证车位数的整数长度
    $("#car_station").rules('add', {
        maxlength: 8,
        messages: {
            maxlength: '输入的数字超出上限'
        }
    });
    //验证交通状况输入的信息，不能超过多少
    $("#traffic").rules('add', {
        maxlength: 1000,
        messages: {
            maxlength: '只能输入1000个字符'
        }
    });
    //验证周边配套的信息长度
    $("#equipments").rules('add', {
        maxlength: 1000,
        messages: {
            maxlength: '只能输入1000个字符'
        }
    });

    //员工的工作经验长度限制
    $("#exp").rules('add', {
        maxlength: 50,
        messages: {
            maxlength: '只能输入50个字符'
        }
    });

    //员工的个人说明长度限制
    $("#des").rules('add', {
        maxlength: 100,
        messages: {
            maxlength: '只能输入100个字符'
        }
    });

    //qq验证qq多少位数
    $("#qq").rules('add', {
        maxlength: 11,
        minlength: 5,
        digits: true,
        messages: {
            maxlength: 'qq最长为11位',
            minlength: 'qq最短为5位',
            digits: '只能输入qq号码'
        }
    });


    //微信验证
    $("#wechat").rules('add', {
        maxlength: 20,
        minlength: 6,
        messages: {
            maxlength: '输入的字符不能超过20位',
            minlength: '最少输入6位'
        }
    });


    //基本工资验证
    $("#basic_salary").rules('add', {
        required: true,
        maxlength: 8,
        messages: {
            required: '请输入该员工的基本工资',
            maxlength: '你输入数字过大！'
        }
    });

    //邮箱
    $("#email").rules('add', {
        required: true,
        email: true,
        remote: {
            type: "post",
            url: $("#path").val() + "/index/queryEmail",
            dataType: "json",   //返回格式为json
            async: true,//请求是否异步，默认为异步，这也是ajax重要特性
            data: {
                email: function () {
                    return $("#email").val();
                }
            },
            dataFilter: function (data) {
                var jsonstr = eval("(" + data + ")");
                if (jsonstr.trues == "true") {
                    return false;
                } else if (jsonstr.trues == "false") {
                    return true;
                }
            }
        },
        messages: {
            required: '请输入您的邮箱！',
            email: '请输入正确的邮箱！',
            remote: "该邮箱已存在！"
        }
    });

    //经度验证规则
    $.validator.addMethod('longitude', function (value, element) {
        var longitude = /^(-?((180)|(((1[0-7]\d)|(\d{1,2}))(\.\d+)?)))$/g;
        return this.optional(element) || (longitude.test(value));
    });

    //纬度验证规则
    $.validator.addMethod('latitude', function (value, element) {
        var latitude = /^(-?((90)|((([0-8]\d)|(\d{1}))(\.\d+)?)))$/g;
        return this.optional(element) || (latitude.test(value));
    });

    //手机验证规则
    $.validator.addMethod('phone', function (value, element) {
        var phone = /^1[3|4|5|7|8][0-9]\d{8}$/;
        return this.optional(element) || (phone.test(value));
    });
    //密码验证规则
    $.validator.addMethod('pass', function (value, element) {
        var pass = /^[\w]+$/
        return this.optional(element) || (pass.test(value));
    });
    //生日验证规则
    $.validator.addMethod('date', function (value, element) {
        var date = /^(19|20)\d{2}-(1[0-2]|0?[1-9])-(0?[1-9]|[1-2][0-9]|3[0-1])$/;
        return this.optional(element) || (date.test(value));
    });

    //电话号码验证
    $.validator.addMethod('tel', function (value, element) {
        var tel = /^(0\d{2,3}-?)?\d{7,8}$/;
        return this.optional(element) || (tel.test(value));
    });

    //责任人名称验证
    $.validator.addMethod('zer', function (value, element) {
        var zer = /^[\w]+$/;
        return this.optional(element) || (zer.test(value));
    });

    //邮箱验证规则
    $.validator.addMethod('email', function (value, element) {
        var email = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/;
        return this.optional(element) || (email.test(value));
    });

    //微信号码验证规则
    $.validator.addMethod('wechat', function (value, element) {
        var wechat = / ^[a-zA-Z]{1}[-_a-zA-Z0-9]{5,19}$/;
        return this.optional(element) || (wechat.test(value));
    });


});








