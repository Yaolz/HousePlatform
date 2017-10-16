$('.form_datetime').datetimepicker({
    language: 'zh-CN',
    format: 'yyyy-mm-dd hh:ii',
    weekStart: 1,
    todayBtn: 1,
    autoclose: 1,
    todayHighlight: 1,
    startView: 2,
    minView: 2,
    forceParse: 0
});

var curDate1 = new Date();
$('#start_time1').datetimepicker('setStartDate', new Date);//让时间只能选择当天时间以后的时间
$('#end_time1').datetimepicker('setStartDate', new Date(new Date((curDate1/1000+86400)*1000)));//让时间只能选择当天时间加1天后的时间
var starttime;
$("#start_time1").change(function(){
    starttime = $(this).val();
    starttime = starttime.replace(new RegExp("-","gm"),"/");
    var starttimeHaoMiao = (new Date(starttime)).getTime(); //得到毫秒数
    var curDate = new Date(starttimeHaoMiao);
    $('#start_time1').datetimepicker('setStartDate', new Date());
    $('#end_time1').datetimepicker('setStartDate', new Date((curDate/1000+86400)*1000));
});
//            $('#start_time1').datetimepicker('setStartDate', new Date());
$("#end_time1").change(function(){
    starttime = $(this).val();
    starttime = starttime.replace(new RegExp("-","gm"),"/");
    var starttimeHaoMiao = ((new Date(starttime)).getTime());//得到毫秒数
    var curDate = new Date(starttimeHaoMiao-86400000);
    $('#start_time1').datetimepicker('setStartDate', new Date());
    $('#start_time1').datetimepicker('setEndDate',curDate);//设置时间最多只能选什么时候
});
$('#start_time').datetimepicker('setStartDate', new Date);
$('#end_time').datetimepicker('setStartDate', new Date(new Date((curDate1/1000+86400)*1000)));
var starttime;
$("#start_time").change(function(){
    starttime = $(this).val();
    starttime = starttime.replace(new RegExp("-","gm"),"/");
    var starttimeHaoMiao = (new Date(starttime)).getTime(); //得到毫秒数
    var curDate = new Date(starttimeHaoMiao);
    $('#start_time').datetimepicker('setStartDate', new Date());
    $('#end_time').datetimepicker('setStartDate', new Date((curDate/1000+86400)*1000));
});
//            $('#start_time1').datetimepicker('setStartDate', new Date());
$("#end_time").change(function(){
    starttime = $(this).val();
    starttime = starttime.replace(new RegExp("-","gm"),"/");
    var starttimeHaoMiao = ((new Date(starttime)).getTime());//得到毫秒数
    var curDate = new Date(starttimeHaoMiao-86400000);
    $('#start_time').datetimepicker('setStartDate', new Date());
    $('#start_time').datetimepicker('setEndDate',curDate);
});