package com.ht.controller;

import com.ht.bean.Ads;
import com.ht.common.Content;
import com.ht.common.ControllerResult;
import com.ht.common.Pager;
import com.ht.service.AdsService;
import com.ht.util.FileUtil;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.commons.io.FileUtils;
import org.apache.struts2.interceptor.ServletRequestAware;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by 娃娃鱼 on 2017/8/31.
 */
public class AdsAction extends ActionSupport implements ServletRequestAware {
    private Ads ads;
    private AdsService adsService;
    private ControllerResult controllerResult;
    private HttpServletRequest request;
    private File logo; // 与form表单中file的name一致，temp文件， ROOT/upload_cc3fa222_9f87_4066_af9b_8b7f07e77389_00000000.tmp
    private String logoFileName; // 此变量的名称固定为file的name + "FileName"

    private int pageNo = 1;
    private int pageSize = 10;
    private int beginNum;
    private int endNum;
    private Pager<Ads> pager;
    private List<Ads> adsList;

    public Pager<Ads> getPager() {
        return pager;
    }

    public void setPager(Pager<Ads> pager) {
        this.pager = pager;
    }

    public Ads getAds() {
        return ads;
    }

    public void setAds(Ads ads) {
        this.ads = ads;
    }

    public void setAdsService(AdsService adsService) {
        this.adsService = adsService;
    }

    public void setLogo(File logo) {
        this.logo = logo;
    }

    public void setLogoFileName(String logoFileName) {
        this.logoFileName = logoFileName;
    }

    public ControllerResult getControllerResult() {
        return controllerResult;
    }

    public int getPageNo() {
        return pageNo;
    }

    public void setPageNo(int pageNo) {
        this.pageNo = pageNo;
    }

    public int getPageSize() {
        return pageSize;
    }

    public int getBeginNum() {
        return beginNum;
    }

    public void setBeginNum(int beginNum) {
        this.beginNum = beginNum;
    }

    public int getEndNum() {
        return endNum;
    }

    public void setEndNum(int endNum) {
        this.endNum = endNum;
    }

    public List<Ads> getAdsList() {
        return adsList;
    }

    public void setAdsList(List<Ads> adsList) {
        this.adsList = adsList;
    }

    //转发到添加页面
    public String adsAddpage() {
        return "adsAddpage";
    }

    // 添加广告的方法 /ads/adsAdd
    public String adsAdd() {
        try {
            FileUtils.copyFile(logo, new File(FileUtil.uploadPath() + File.separator + logoFileName));
            ads.setLogo(FileUtil.UPLOADS + "/" + logoFileName);
        } catch (IOException e) {
            e.printStackTrace();
        }
        ads.setShow_status(1);
        ads.setStatus(1);
        ads.setCreated_time(new Date());
        adsService.add(ads);
        controllerResult = ControllerResult.getSuccessResult("添加成功！");
        return "adsAdd";
    }

    // 进入所有广告页面
    public String adsAllPage() {
        return "adsAllPage";
    }

    //分页显示所有广告
    public String adsAll() {
        pager = new Pager<>();
        pager.setPageSize(pageSize);
        if (pageNo < 1) {
            pager.setPageNo(1);
        } else {
            pager.setPageNo(pageNo);
        }
        pager = adsService.queryPager(pager);
        return "adsAll";
    }

    // 修改广告的状态
    public String statusChang() {
        String id = request.getParameter("checkedIds");
        String checkedIds[] = id.split(",");
        if (ads.getStatus() == 0) {
            adsService.updateStatus(checkedIds, Content.StatusYes);
        } else if (ads.getStatus() == 1) {
            adsService.updateStatus(checkedIds, Content.StatusNo);
        }
        return "statusChang";
    }

    // 处理修改广告的信息
    public String adsChangeInfo() {
        System.out.println("logo:" + logo);
        if(logo == null || logo.equals("")) {
            ads = adsService.queryById(ads.getId());
            System.out.println(ads.getLogo());
            ads.setLogo(ads.getLogo());
        } else {
            try {
                FileUtils.copyFile(logo, new File(FileUtil.uploadPath() + File.separator + logoFileName));
                ads.setLogo(FileUtil.UPLOADS + "/" + logoFileName);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        ads.setStatus(1);
        ads.setShow_status(1);
        ads.setCreated_time(new Date());
        adsService.update(ads);
        controllerResult = ControllerResult.getSuccessResult("修改成功！");
        return "adsChangeInfo";
    }
// 前台显示广告
    public String adsShow() {
        adsList = new ArrayList<>();
        adsList = adsService.queryShow(beginNum,endNum);
        return "adsShow";
    }

    @Override
    public void setServletRequest(HttpServletRequest httpServletRequest) {
        this.request = httpServletRequest;
    }
}
