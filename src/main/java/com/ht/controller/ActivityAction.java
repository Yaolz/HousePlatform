package com.ht.controller;

import com.ht.bean.Activity;
import com.ht.bean.Admin;
import com.ht.bean.Agency;
import com.ht.common.Content;
import com.ht.common.ControllerResult;
import com.ht.common.Pager;
import com.ht.price.AgencyPrice;
import com.ht.price.BuildingsPrice;
import com.ht.service.ActivityService;
import com.ht.util.FileUtil;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.commons.io.FileUtils;
import org.apache.struts2.interceptor.ServletRequestAware;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;

/**
 * Created by yao on 2017/9/4.
 */
public class ActivityAction extends ActionSupport implements ServletRequestAware {
    private ControllerResult controllerResult;

    private ActivityService activityService;
    private HttpServletRequest request;
    private String  buildings_id;
    private String checkedIds[];
    private int updatestatus;

    private File upload; // 与form表单中file的name一致，temp文件， ROOT/upload_cc3fa222_9f87_4066_af9b_8b7f07e77389_00000000.tmp
    private String uploadFileName; // 此变量的名称固定为file的name + "FileName"
    private Pager<Activity> pager;

    private int pageNo = 1;
    private int pageSize = 5;

    private Activity activity;
    private BuildingsPrice buildingsPrice;
    private AgencyPrice agencyPrice;
    private Agency agency;
    private int status;
    private Admin admin;

    public void setUpdatestatus(int updatestatus) {
        this.updatestatus = updatestatus;
    }

    public void setCheckedIds(String[] checkedIds) {
        this.checkedIds = checkedIds;
    }

    public String getBuildings_id() {
        return buildings_id;
    }

    public void setBuildings_id(String buildings_id) {
        this.buildings_id = buildings_id;
    }

    public ControllerResult getControllerResult() {
        return controllerResult;
    }

    public void setActivityService(ActivityService activityService) {
        this.activityService = activityService;
    }

    public void setUpload(File upload) {
        this.upload = upload;
    }

    public void setUploadFileName(String uploadFileName) {
        this.uploadFileName = uploadFileName;
    }

    public Activity getActivity() {
        return activity;
    }

    public void setActivity(Activity activity) {
        this.activity = activity;
    }

    public int getPageNo() {
        return pageNo;
    }

    public void setPageNo(int pageNo) {
        this.pageNo = pageNo;
    }

    public Pager<Activity> getPager() {
        return pager;
    }

    public void setPager(Pager<Activity> pager) {
        this.pager = pager;
    }

    public int getPageSize() {
        return pageSize;
    }

    public BuildingsPrice getBuildingsPrice() {
        return buildingsPrice;
    }

    public void setBuildingsPrice(BuildingsPrice buildingsPrice) {
        this.buildingsPrice = buildingsPrice;
    }

    public AgencyPrice getAgencyPrice() {
        return agencyPrice;
    }

    public void setAgencyPrice(AgencyPrice agencyPrice) {
        this.agencyPrice = agencyPrice;
    }

    public Agency getAgency() {
        return agency;
    }

    public void setAgency(Agency agency) {
        this.agency = agency;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public Admin getAdmin() {
        return admin;
    }

    public void setAdmin(Admin admin) {
        this.admin = admin;
    }

    //添加活动
    public String addActivity() {
        HttpSession session = request.getSession();
        if(upload!=null){
            try {
                FileUtils.copyFile(upload, new File(FileUtil.uploadPath() + File.separator + uploadFileName));
                activity.setLogo(FileUtil.UPLOADS + "/" + uploadFileName);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }else {
            activity.setLogo("public/img/noimage.png");
        }
        if(buildingsPrice!=null&&session.getAttribute("agency")!=null){
            Agency agency = (Agency)session.getAttribute("agency");
            activity.setStatus(1);
            activity.setBuildingsPrice(buildingsPrice);
            AgencyPrice agencyPrice = new AgencyPrice();
            agencyPrice.setId(agency.getId());
            activity.setAgencyPrice(agencyPrice);
            activityService.add(activity);
            controllerResult = ControllerResult.getSuccessResult("添加成功！");
        }else if(session.getAttribute("admin")!=null) {
            activity.setStatus(1);
            activity.setBuildingsPrice(null);
            activity.setAgencyPrice(null);
            activityService.add(activity);
            controllerResult = ControllerResult.getSuccessResult("添加成功！");
        }else{
            controllerResult = ControllerResult.getFailResult("服务器繁忙，添加失败");
        }

        return "addActivity";
    }

    //添加管理员活动页面
    public String addActivityPage() {
        return "addActivityPage";
    }

    //添加经销商活动页面
    public String addAgencyActivity() {
        return "addAgencyActivity";
    }

    //显示所有活动
    public String activityInfo() {
        pager = new Pager<>();
        pager.setPageSize(pageSize);
        if (pageNo < 1) {
            pager.setPageNo(1);
        } else {
            pager.setPageNo(pageNo);
        }
        pager = activityService.queryPager(pager);
        return "activityInfo";
    }

    public String activityInfoPage() {
        return "activityInfoPage";
    }

    //活动详情
    public String activityDetail() {
        activity = activityService.queryById(activity.getId());
        return "activityDetail";
    }

    //管理员自己发的活动
    public String activitySelfPagejson() {
        pager = new Pager<Activity>();
        pager.setPageSize(pageSize);
        if (pageNo < 1) {
            pager.setPageNo(1);
        } else {
            pager.setPageNo(pageNo);
        }
        pager = activityService.queryPagers(pager, null);
        return "activitySelfPagejson";
    }

    //活动页面
    public String activitySelfPage() {
        return "activitySelfPage";
    }

    //修改活动
    public String changeActivity() {
        try {
            FileUtils.copyFile(upload, new File(FileUtil.uploadPath() + File.separator + uploadFileName));
            activity.setLogo(FileUtil.UPLOADS + "/" + uploadFileName);
        } catch (IOException e) {
            e.printStackTrace();
        }
        activity.setAgencyPrice(null);
        activity.setBuildingsPrice(null);
        activityService.update(activity);
        controllerResult = ControllerResult.getSuccessResult("修改成功！");
        return "changeActivity";
    }

    //修改活动状态
    public String status() {
        String id = request.getParameter("checkedIds");    //获取前台隐藏域存着的选中的复选框的value
        String checkedIds[] = id.split(",");
        if (activity.getStatus() == Content.StatusNo) {
            activityService.updateStatusById(checkedIds, Content.CheckYes);//激活
        } else {
            activityService.updateStatusById(checkedIds, Content.CheckNo);//冻结
        }
        return "status";
    }

    //经销商用选择状态显示活动信息
    public String pagerByStatus() {
        HttpSession session = request.getSession();
        pager = new Pager<>();
        pager.setPageSize(pageSize);
        if(session.getAttribute("agency")!=null){
            Agency agency = (Agency) session.getAttribute("agency");
            if (pageNo < 1) {
                pager.setPageNo(1);
            } else {
                pager.setPageNo(pageNo);
            }
            if(!buildings_id.equals("所有楼盘")){
                pager =activityService .queryPagerByBuildings(pager,buildings_id,status);
            }else if(buildings_id.equals("所有楼盘")){
                pager = activityService.queryPagerByStatus(pager, agency.getId(), status);
            }
        }
        return "pagerByStatus";
    }

    public String allActivityPage() {
        return "allActivityPage";
    }

    //修改经销商活动状态
    public String agencyStatus() {
        HttpSession session = request.getSession();
        pager = new Pager<>();
        pager.setPageSize(pageSize);
        if(session.getAttribute("agency")!=null){
            Agency agency = (Agency) session.getAttribute("agency");
            if(updatestatus<2&&checkedIds!=null&&checkedIds.length>0){
                activityService.updateStatusById(checkedIds,updatestatus);
            }else {
                controllerResult = ControllerResult.getFailResult("服务器繁忙");
                return "agencyStatus";
            }
            if (pageNo < 1) {
                pager.setPageNo(1);
            } else {
                pager.setPageNo(pageNo);
            }
            if(!buildings_id.equals("所有楼盘")){
                pager =activityService .queryPagerByBuildings(pager,buildings_id,status);
                if(pager.getResult()==null||pager.getResult().size()<1){
                    pager.setPageNo(pager.getPageNo()-1);
                    pager =activityService .queryPagerByBuildings(pager,buildings_id,status);
                }
            }else if(buildings_id.equals("所有楼盘")){
                pager = activityService.queryPagerByStatus(pager, agency.getId(), status);
                if(pager.getResult()==null||pager.getResult().size()<1){
                    pager.setPageNo(pager.getPageNo()-1);
                    pager =activityService .queryPagerByBuildings(pager,buildings_id,status);
                }
            }
            if(updatestatus==0){
                controllerResult=ControllerResult.getSuccessResult("冻结成功");
            }else if(updatestatus==1) {
                controllerResult=ControllerResult.getSuccessResult("激活成功");
            }
        }else {
            controllerResult = ControllerResult.getFailResult("服务器繁忙");
        }
        return "agencyStatus";
    }

    // 经销商修改活动信息
    public String activityChange() {
        if(upload!=null){
            try {
                FileUtils.copyFile(upload, new File(FileUtil.uploadPath() + File.separator + uploadFileName));
                activity.setLogo(FileUtil.UPLOADS + "/" + uploadFileName);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        activityService.updateActivity(activity);
        controllerResult = ControllerResult.getSuccessResult("修改成功！");
        return "activityChange";
    }

    public String navActivity(){
        String id = request.getParameter("buildingsId");
        pager = new Pager<>();
        pager.setPageSize(pageSize);
        if (pageNo < 1) {
            pager.setPageNo(1);
        } else {
            pager.setPageNo(pageNo);
        }
        pager=activityService.queryPagerByBuildings(pager,id,1);
        return "navActivity";
    }
    //首页显示楼盘活动页面
    public String navActivityPage(){
        return "navActivityPage";
    }

    public String buildingsActivity() {
        System.out.println("23"+buildings_id);
        activity = activityService.queryByBuildingsId(buildings_id);
        return "buildingsActivity";
    }

    @Override
    public void setServletRequest(HttpServletRequest httpServletRequest) {
        this.request = httpServletRequest;
    }
}
