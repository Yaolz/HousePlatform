package com.ht.util;

import org.apache.struts2.ServletActionContext;

import java.io.File;

/**
 * Created by Master on 2017/6/29.
 */
public class FileUtil {

    public static final String UPLOADS = "uploads";
    public static final String FREQUENCY = "frequency";
    /**
     * 获取图片上传的路径
     * @return
     */
    public static String uploadPath() {
        String rootPath = ServletActionContext.getServletContext().getRealPath("/");
        File uploads = new File(rootPath, UPLOADS);
        if (!uploads.exists()) {
            uploads.mkdir();
        }
        return uploads.getAbsolutePath();
    }

    /**
     * 获取视频上传的路径
     * @return
     */
    public static String frequencyPath() {
        String rootPath = ServletActionContext.getServletContext().getRealPath("/");
        File uploads = new File(rootPath, FREQUENCY);
        if (!uploads.exists()) {
            uploads.mkdir();
        }
        return uploads.getAbsolutePath();
    }

    public static void removeFile(String relativePath){
        String absolutePath = ServletActionContext.getServletContext().getRealPath(relativePath);
        //取出文件的绝对路径，然后用File方法删除相应文件。
        File file = new File(absolutePath);
        if (file.exists()) {
            file.delete();
        }
    }
}
