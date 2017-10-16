/**
 * Created by Master on 2017/7/25.
 */
var auto=false;//设置是否自动上传
var imgFormat ='gif,jpg,jpeg,bmp,png';//图片的格式
var imgTypes ='image/*';//添加文件时检测的类型
var videoFormat = '3gp,mp4,rmvb,mov,avi,m4v';
var videoTypes='video/*,audio/*,application/*';

var imgSize=5 * 1024 * 1024;
var videoSize=498 * 1024 * 1024;

var count =1;//上传上限

var videostate=false;//设置上传后的状态
var imgstate=false;


function refreshthepage() {
    if(imgstate==true){
        window.location.reload();
        alert("添加成功");
    }
}