package com.ht.controller;

import com.ht.bean.User;
import com.ht.util.FileUtil;
import org.apache.commons.io.FileUtils;

import java.io.File;
import java.io.IOException;


public class TestAction {

    private File upload; // 与form表单中file的name一致，temp文件， ROOT/upload_cc3fa222_9f87_4066_af9b_8b7f07e77389_00000000.tmp
    private String uploadFileName; // 此变量的名称固定为file的name + "FileName"
    private String name;
    private int age;
    private User user;


    private String uploadContentType; // file的name + "contentType"


    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public File getUpload() {
        return upload;
    }

    public void setUpload(File upload) {
        this.upload = upload;
    }

    public String getUploadFileName() {
        return uploadFileName;
    }

    public void setUploadFileName(String uploadFileName) {
        this.uploadFileName = uploadFileName;
    }

    public String uploadimg(){
        try {
            FileUtils.copyFile(upload, new File(FileUtil.uploadPath() + File.separator + uploadFileName));
        } catch (IOException e) {
            e.printStackTrace();
        }
        return "uploadimg";
    }
}
