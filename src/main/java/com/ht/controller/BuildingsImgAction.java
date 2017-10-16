package com.ht.controller;

import com.ht.bean.Buildings;
import com.ht.bean.BuildingsImg;
import com.ht.common.ControllerResult;
import com.ht.common.Pager;
import com.ht.service.BuildingsImgService;
import com.ht.util.FileUtil;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.commons.io.FileUtils;
import org.apache.struts2.interceptor.ServletRequestAware;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.Date;

public class BuildingsImgAction extends ActionSupport implements ServletRequestAware {

    private HttpServletRequest request;
    private BuildingsImgService buildingsImgService;
    private String  buildingsid ;
    private int pageNo;

    private File upload; // 与form表单中file的name一致，temp文件， ROOT/upload_cc3fa222_9f87_4066_af9b_8b7f07e77389_00000000.tmp
    private String uploadFileName; // 此变量的名称固定为file的name + "FileName"
    private Buildings buildings;

    private Pager<BuildingsImg> buildingsImgPager;
    private ControllerResult controllerResult;

    public void setBuildingsid(String buildingsid) {
        this.buildingsid = buildingsid;
    }

    public ControllerResult getControllerResult() {
        return controllerResult;
    }

    public void setControllerResult(ControllerResult controllerResult) {
        this.controllerResult = controllerResult;
    }

    public int getPageNo() {
        return pageNo;
    }

    public void setPageNo(int pageNo) {
        this.pageNo = pageNo;
    }

    public Pager<BuildingsImg> getBuildingsImgPager() {
        return buildingsImgPager;
    }

    public void setBuildingsImgPager(Pager<BuildingsImg> buildingsImgPager) {
        this.buildingsImgPager = buildingsImgPager;
    }

    public Buildings getBuildings() {
        return buildings;
    }

    public void setBuildings(Buildings buildings) {
        this.buildings = buildings;
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



    public void setBuildingsImgService(BuildingsImgService buildingsImgService) {
        this.buildingsImgService = buildingsImgService;
    }

    //楼盘上传图片的url
    public String updateBuildingImg(){
        if(upload!=null&&buildings!=null){
            BuildingsImg buildingsImg = new BuildingsImg();
            buildingsImg.setBuildings(buildings);
            try {
                FileUtils.copyFile(upload, new File(FileUtil.uploadPath() + File.separator + uploadFileName));
                buildingsImg.setImg_path(FileUtil.UPLOADS+"/"+uploadFileName);
                buildingsImg.setCreated_time(new Date());
                buildingsImgService.add(buildingsImg);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }else {

        }
        return "updateBuildingImg";
    }

    //分页查询楼盘的图片
    public String allBuildingImg(){
        if(buildingsid!=null&&!buildingsid.equals("")){
            buildingsImgPager = new Pager<>();
            buildingsImgPager.setPageSize(20);
            if (pageNo < 1) {
                buildingsImgPager.setPageNo(1);
            } else {
                buildingsImgPager.setPageNo(pageNo);
            }
            buildingsImgPager = buildingsImgService.queryAllBuildingsImg(buildingsImgPager,buildingsid);
            if(buildingsImgPager.getResult()==null||buildingsImgPager.getResult().size()<1){
                controllerResult = ControllerResult.getFailResult("暂时无相册图片");
            }else {
                controllerResult = ControllerResult.getSuccessResult("");
            }
        }else {
            controllerResult = ControllerResult.getFailResult("服务器繁忙请稍后在尝试");
        }
        return "allBuildingImg";
    }

    @Override
    public void setServletRequest(HttpServletRequest httpServletRequest) {
        this.request = httpServletRequest;
    }
}
