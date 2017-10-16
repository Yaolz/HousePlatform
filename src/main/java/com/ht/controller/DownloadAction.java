package com.ht.controller;

import com.ht.util.FileUtil;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.ServletActionContext;

import java.io.InputStream;

/**
 * Created by Master on 2017/6/29.
 */
public class DownloadAction extends ActionSupport {

    private String name;
    private String fileName; // 用于指明下载的文件的名称
    private InputStream downloadFile; // 从服务端传递到客户端输入流

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    /**
     * 把数据通过inputstream传输到客户端
     * @return
     * @throws Exception
     */
    public InputStream getDownloadFile() throws Exception {
        this.fileName = "test"+name ;
        if(name!=null&&!name.equals("")){
            // 通过ServletContext对象的getResourceAsStream的方法去获取文件输入流
            downloadFile = ServletActionContext.getServletContext().getResourceAsStream(FileUtil.FREQUENCY+"/" + name);
            if (downloadFile != null) {
                return downloadFile;
            }
        }
        return  null;
    }

    public String execute(){
        return SUCCESS;
    }

}
