package com.ht.controller;

import com.ht.bean.Agency;
import com.ht.bean.Buildings;
import com.ht.bean.House;
import com.ht.common.ControllerResult;
import com.ht.common.Pager;
import com.ht.price.BuildingsPrice;
import com.ht.service.HouseService;
import com.ht.util.FileUtil;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.commons.io.FileUtils;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.springframework.util.StringUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Date;
import java.util.List;

/**
 * Created by CMY on 2017/9/6.
 */
public class HouseAction extends ActionSupport implements ServletRequestAware{
    private House house;
    private Buildings buildings;
    private BuildingsPrice buildingsPrice;
    private HttpServletRequest request;

    private File upload; // 与form表单中file的name一致，temp文件， ROOT/upload_cc3fa222_9f87_4066_af9b_8b7f07e77389_00000000.tmp
    private String uploadFileName; // 此变量的名称固定为file的name + "FileName"
    private List<Buildings> buildingsList;
    private List<House> houses;
    private ControllerResult result;
    private String buildings_id;
    private int status;
    private int updatestatus;
    private String[] checkedIds;

    private HouseService houseService;

    public File getUpload() {
        return upload;
    }

    private Pager<House> pager;

    private int pageNo = 1;
    private int pageSize = 6;

    private String like;
    private String prices;
    private String areas;

    public void setLike(String like) {
        this.like = like;
    }

    public void setPrices(String prices) {
        this.prices = prices;
    }

    public void setAreas(String areas) {
        this.areas = areas;
    }

    @Override
    public void setServletRequest(HttpServletRequest httpServletRequest) {
        this.request = httpServletRequest;
    }

    public void setCheckedIds(String[] checkedIds) {
        this.checkedIds = checkedIds;
    }

    public void setUpdatestatus(int updatestatus) {
        this.updatestatus = updatestatus;
    }

    public void setStatus(int status) {
        this.status = status;
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

    public ControllerResult getResult() {
        return result;
    }

    public void setBuildings_id(String buildings_id) {
        this.buildings_id = buildings_id;
    }

    public List<House> getHouses() {
        return houses;
    }

    public void setBuildingsPrice(BuildingsPrice buildingsPrice) {
        this.buildingsPrice = buildingsPrice;
    }

    public List<Buildings> getBuildingsList() {
        return buildingsList;
    }

    public void setBuildingsList(List<Buildings> buildingsList) {
        this.buildingsList = buildingsList;
    }

    public House getHouse() {
        return house;
    }

    public void setHouse(House house) {
        this.house = house;
    }

    public Buildings getBuildings() {
        return buildings;
    }

    public void setBuildings(Buildings buildings) {
        this.buildings = buildings;
    }

    public void setHouseService(HouseService houseService) {
        this.houseService = houseService;
    }

    public void setPager(Pager<House> pager) {
        this.pager = pager;
    }

    public void setPageNo(int pageNo) {
        this.pageNo = pageNo;
    }

    public Pager<House> getPager() {
        return pager;
    }

    public int getPageNo() {
        return pageNo;
    }

    public int getPageSize() {
        return pageSize;
    }

    /**
     * 进入添加户型页面
     *
     * @return
     */
    public String addhousepage() {
        String housename = request.getParameter("housename");
        String intro = request.getParameter("intro");
        if(!StringUtils.isEmpty(housename)&&!StringUtils.isEmpty(intro)){
            try {
                housename = URLDecoder.decode(housename,"UTF-8");
                intro =  URLDecoder.decode(intro,"UTF-8");
                request.setAttribute("housename",housename);
                request.setAttribute("intro",intro);
            }catch (Exception e){

            }
        }
        return "addhousepage";
    }

    /**
     * 添加户型
     *
     * @return
     */
    public String addhouse() {
        if (buildingsPrice != null) {
            if (upload != null) {
                try {
                    FileUtils.copyFile(upload, new File(FileUtil.uploadPath() + File.separator + uploadFileName));
                    house.setLogo(FileUtil.UPLOADS + "/" + uploadFileName);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            } else {
                house.setLogo("public/img/noimage.png");
            }
            house.setCreated_time(new Date());
            house.setStatus(1);
            house.setBuildingsPrice(buildingsPrice);
            houseService.add(house);
            result = ControllerResult.getSuccessResult("添加成功");
        } else {
            result = ControllerResult.getFailResult("添加失败");
        }
        return "addhouse";
    }

    public String queryhouse() {
        Pager<House> housePager = new Pager<>();
        housePager.setPageNo(1);
        housePager.setPageSize(3000);
        if (houseService.countHouse(buildings_id) > 0) {
            houses = houseService.queryAllHouse(housePager, buildings_id).getResult();
            result = ControllerResult.getSuccessResult("");
        } else {
            result = ControllerResult.getFailResult("");
        }
        return "queryhouse";
    }

    //前台首页显示户型
    public String indexHouse() {
        double unit_price = 0;
        double unit_price1 = 0;
        String avg[];
        double area = 0;
        double area1 = 0;
        String a[];
        pager = new Pager<>();
        pager.setPageSize(10);
        if (pageNo < 1) {
            pager.setPageNo(1);
        } else {
            pager.setPageNo(pageNo);
        }
        if (prices != null && prices.equals("0") || prices.equals("30000")) {
            unit_price = Double.parseDouble(prices);
            unit_price1 = unit_price;
        } else {
            avg = prices.split(",");//进行分割存到数组
            unit_price = Double.parseDouble(avg[0]);
            unit_price1 = Double.parseDouble(avg[1]);
        }
        if (areas != null && areas.equals("0") || areas.equals("300")) {
            area = Double.parseDouble(areas);
            area1 = area;
        } else {
            a = areas.split(",");//进行分割存到数组
            area = Double.parseDouble(a[0]);
            area1 = Double.parseDouble(a[1]);
        }
        pager = houseService.queryAllindex(pager, unit_price, unit_price1, area, area1, like);
        return "indexHouse";
    }

    //首页显示户型信息
    public String indexHouseDetail() {
        house = houseService.queryById(house.getId());
        return "indexHouseDetail";
    }

    //页面显示某楼盘下的户型
    public String navHouse() {
        pager = new Pager<>();
        pager.setPageSize(pageSize);
        if (pageNo < 1) {
            pager.setPageNo(1);
        } else {
            pager.setPageNo(pageNo);
        }
        pager = houseService.queryAllHouseStatus(pager, buildings_id, 1);
        return "navHouse";
    }


    //经销商分页查询户型
    public String allHouse(){
        HttpSession session = request.getSession();
        pager = new Pager<>();
        pager.setPageSize(10);
        if(session.getAttribute("agency")!=null){
            Agency agency = (Agency) session.getAttribute("agency");
            if (pageNo < 1) {
                pager.setPageNo(1);
            } else {
                pager.setPageNo(pageNo);
            }
            if(!buildings_id.equals("所有楼盘")){
                pager =houseService .queryAllHouseStatus(pager,buildings_id,status);
            }else if(buildings_id.equals("所有楼盘")){
                pager = houseService.queryAllHouseAgencyStatus(pager, agency.getId(), status);
            }
        }
        return "allHouse";
    }
    public String allHousePage(){
        return "allHousePage";
    }

    //批量冻结或激活户型
    public String updateHouseStatus(){
        HttpSession session = request.getSession();
        pager = new Pager<>();
        pager.setPageSize(10);
        if(session.getAttribute("agency")!=null){
            Agency agency = (Agency) session.getAttribute("agency");
            if(updatestatus<2&&checkedIds!=null&&checkedIds.length>0){
                houseService.updateStatus(checkedIds,updatestatus);
            }else {
                result = ControllerResult.getFailResult("服务器繁忙");
                return "updateStatus";
            }
            if (pageNo < 1) {
                pager.setPageNo(1);
            } else {
                pager.setPageNo(pageNo);
            }
            if(!buildings_id.equals("所有楼盘")){
                pager =houseService .queryAllHouseStatus(pager,buildings_id,status);
                if(pager.getResult()==null||pager.getResult().size()<1){
                    pager.setPageNo(pager.getPageNo()-1);
                    pager =houseService .queryAllHouseStatus(pager,buildings_id,status);
                }
            }else if(buildings_id.equals("所有楼盘")){
                pager = houseService.queryAllHouseAgencyStatus(pager, agency.getId(), status);
                if(pager.getResult()==null||pager.getResult().size()<1){
                    pager.setPageNo(pager.getPageNo()-1);
                    pager = houseService.queryAllHouseAgencyStatus(pager, agency.getId(), status);
                }
            }
            if(updatestatus==1){
                result = ControllerResult.getSuccessResult("激活成功!");
            }else {
                result = ControllerResult.getSuccessResult("冻结成功!");
            }
        } else {
            result = ControllerResult.getFailResult("服务器繁忙，请稍候在尝试!");
        }
        return "updateHouseStatus";
    }

    public String updateHouse(){
        HttpSession session = request.getSession();
        if(session.getAttribute("agency")!=null){
            if(upload!=null){
                try {
                    FileUtils.copyFile(upload, new File(FileUtil.uploadPath() + File.separator + uploadFileName));
                    house.setLogo(FileUtil.UPLOADS+"/"+uploadFileName);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            houseService.updateHouse(house);
            result = ControllerResult.getSuccessResult("修改成功!");
        }
        return "updateHouse";
    }
    public String navHousePage(){
        return "navHousePage";
    }

    public String housePage(){
        pager = new Pager<>();
        pager.setPageSize(pageSize);
        if (pageNo < 1) {
            pager.setPageNo(1);
        } else {
            pager.setPageNo(pageNo);
        }
        pager = houseService.queryPager(pager);
        return "housePage";
    }

}
