package com.ht.controller;

import com.ht.bean.*;
import com.ht.common.Content;
import com.ht.common.ControllerResult;
import com.ht.common.Pager;
import com.ht.price.BuildingsPrice;
import com.ht.service.BuildingsAvgpriceService;
import com.ht.service.BuildingsService;
import com.ht.service.LikeService;
import com.ht.util.FileUtil;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.commons.io.FileUtils;
import org.apache.struts2.interceptor.ServletRequestAware;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;

/**
 * Created by CMY on 2017/9/4.
 */
public class BuildingsAction extends ActionSupport implements ServletRequestAware {
    private Buildings buildings;
    private Agency agency;
    private File upload; // 与form表单中file的name一致，temp文件， ROOT/upload_cc3fa222_9f87_4066_af9b_8b7f07e77389_00000000.tmp
    private String uploadFileName; // 此变量的名称固定为file的name + "FileName"

    private List<Buildings> rows;
    private List<BuildingsPrice> buildingsPriceList;
    private List<BuildingsAvgprice> avgprices;

    private BuildingsService buildingsService;
    private BuildingsAvgpriceService buildingsAvgpriceService;
    private LikeService likeService;
    private int status;
    private int updatestatus;
    private String checkedIds[];
    private String like;
    private String avg_price;
    private String area;
    private String house_type;

    private String id;
    private int pageNo = 1;

    private Pager<Buildings> pager;
    private Pager<Buildings> buildingsPager;
    private ControllerResult controllerResult;
    private String buildingsId;

    public void setAvg_price(String avg_price) {
        this.avg_price = avg_price;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public void setHouse_type(String house_type) {
        this.house_type = house_type;
    }

    public void setBuildingsAvgpriceService(BuildingsAvgpriceService buildingsAvgpriceService) {
        this.buildingsAvgpriceService = buildingsAvgpriceService;
    }

    public void setLike(String like) {
        this.like = like;
    }

    public void setCheckedIds(String[] checkedIds) {
        this.checkedIds = checkedIds;
    }

    public void setUpdatestatus(int updatestatus) {
        this.updatestatus = updatestatus;
    }

    public ControllerResult getControllerResult() {
        return controllerResult;
    }

    public Pager<Buildings> getBuildingsPager() {
        return buildingsPager;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public void setRows(List<Buildings> rows) {
        this.rows = rows;
    }

    public int getPageNo() {
        return pageNo;
    }

    public void setPageNo(int pageNo) {
        this.pageNo = pageNo;
    }

    private HttpServletRequest request;
    private ControllerResult result;


    public List<BuildingsPrice> getBuildingsPriceList() {
        return buildingsPriceList;
    }

    public ControllerResult getResult() {
        return result;
    }

    public void setResult(ControllerResult result) {
        this.result = result;
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

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Agency getAgency() {
        return agency;
    }

    public void setAgency(Agency agency) {
        this.agency = agency;
    }

    public Buildings getBuildings() {
        return buildings;
    }

    public void setBuildings(Buildings buildings) {
        this.buildings = buildings;
    }

    public List<Buildings> getRows() {
        return rows;
    }

    public List<BuildingsAvgprice> getAvgprices() {
        return avgprices;
    }

    public void setBuildingsService(BuildingsService buildingsService) {
        this.buildingsService = buildingsService;
    }

    public Pager<Buildings> getPager() {
        return pager;
    }

    public void setPager(Pager<Buildings> pager) {
        this.pager = pager;
    }

    public String getBuildingsId() {
        return buildingsId;
    }

    public void setBuildingsId(String buildingsId) {
        this.buildingsId = buildingsId;
    }

    // 管理员进入所有楼盘的页面
    public String admBuildingsPage() {
        return "admBuildingsPage";
    }

    // 管理员查看所有楼盘
    public String admBuildingsAll() {
        int pageSize = Integer.parseInt(request.getParameter("pageSize"));//前后台交互的每页显示数据
        int pageNumber = Integer.parseInt(request.getParameter("pageNumber"));//前后台交互的页码
        pager = new Pager<Buildings>();
        pager.setPageSize(pageSize);
        if (pageNumber < 1) {
            pager.setPageNo(1);
        } else {
            pager.setPageNo(pageNumber);
        }
        pager = buildingsService.queryStatusAll(pager, Content.StatusYes, null);
        rows = pager.getResult();
        return "admBuildingsAll";
    }

    //根据ID查询楼盘资料
    public String admBuildingsDet() {
        buildings = buildingsService.queryById(buildings.getId());
        return "admBuildingsDet";
    }

    /**
     * 根据ID查询楼盘详细信息
     *
     * @return
     */
    public String buildingsDetail() {
        if (id != null && !id.equals("")) {
            buildings = buildingsService.queryById(id);
        } else {
            buildings = buildingsService.queryById(buildings.getId());
        }
        return "buildingsDetail";
    }

    public String remove() {
        buildingsService.remove(buildings);
        return "remove";
    }

    /**
     * 查看全部楼盘
     *
     * @return
     */
    public String totalbuildings() {
        return "totalbuildings";

    }

    /**
     * 添加楼盘页面
     *
     * @return
     */
    public String addbuildingspage() {
        return "addbuildingspage";
    }

    /**
     * 添加楼盘
     *
     * @return
     */
    public String addbuildings() {
        HttpSession session = request.getSession();
        if (session.getAttribute("agency") != null) {
            Agency agency = (Agency) session.getAttribute("agency");
            if (upload != null) {
                try {
                    FileUtils.copyFile(upload, new File(FileUtil.uploadPath() + File.separator + uploadFileName));
                    buildings.setLogo(FileUtil.UPLOADS + "/" + uploadFileName);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            } else {
                buildings.setLogo("public/img/noimage.png");
            }
            buildings.setStatus(1);
            buildings.setAgency(agency);
            buildingsService.add(buildings);
            result = ControllerResult.getSuccessResult("添加成功");
        } else {
            result = ControllerResult.getFailResult("添加失败");
        }
        return "addbuildings";
    }

    //获取楼盘的下拉框值对象
    public String queryBuildingsPrice() {
        HttpSession session = request.getSession();
        if (session.getAttribute("agency") != null) {
            Agency agency = (Agency) session.getAttribute("agency");
            Pager<BuildingsPrice> pricePager = new Pager<>();
            buildingsPriceList = buildingsService.queryAllBuildingsPrice(pricePager, agency.getId(), 3).getResult();
            result = ControllerResult.getSuccessResult("添加成功");
        } else {
            result = ControllerResult.getFailResult("");
        }
        return "queryBuildingsPrice";
    }

    public String allBuildings() {
        buildingsPager = new Pager<>();
        buildingsPager.setPageSize(10);
        HttpSession session = request.getSession();
        if (session.getAttribute("agency") != null) {
            Agency agency = (Agency) session.getAttribute("agency");
            if (pageNo < 1) {
                buildingsPager.setPageNo(1);
            } else {
                buildingsPager.setPageNo(pageNo);
            }
            buildingsPager = buildingsService.queryAllBuildings(buildingsPager, agency.getId(), status);
        } else {
            controllerResult = ControllerResult.getFailResult("服务器繁忙,请重新登入");
        }
        return "allBuildings";
    }

    public String updatestatus() {
        buildingsPager = new Pager<>();
        buildingsPager.setPageSize(10);
        HttpSession session = request.getSession();
        if (session.getAttribute("agency") != null) {
            Agency agency = (Agency) session.getAttribute("agency");
            if (updatestatus < 2 && checkedIds != null && checkedIds.length > 0) {
                buildingsService.updateStatus(checkedIds, updatestatus);
            } else {
                controllerResult = ControllerResult.getFailResult("服务器繁忙");
                return "updatestatus";
            }
            if (pageNo < 1) {
                buildingsPager.setPageNo(1);
            } else {
                buildingsPager.setPageNo(pageNo);
            }
            buildingsPager = buildingsService.queryAllBuildings(buildingsPager, agency.getId(), status);
            if (buildingsPager.getResult() == null || buildingsPager.getResult().size() < 1) {
                buildingsPager.setPageNo(buildingsPager.getPageNo() - 1);
                buildingsPager = buildingsService.queryAllBuildings(buildingsPager, agency.getId(), status);
            }
            if (updatestatus == 0) {
                controllerResult = ControllerResult.getSuccessResult("冻结成功");
            } else if (updatestatus == 1) {
                controllerResult = ControllerResult.getSuccessResult("激活成功");
            }
        } else {
            controllerResult = ControllerResult.getFailResult("服务器繁忙,请重新登入");
        }
        return "updatestatus";
    }

    //修改楼盘时同时也记录楼盘的楼盘均价是否修改了
    public String updateBuildings() {
        HttpSession session = request.getSession();
        if (session.getAttribute("agency") != null && buildings != null) {
            Buildings buildings1 = buildingsService.queryById(buildings.getId());
            if (buildings1.getAvg_price() != buildings.getAvg_price()) {
                BuildingsAvgprice buildingsAvgprice = new BuildingsAvgprice();
                buildingsAvgprice.setAvg_price(buildings.getAvg_price());
                buildingsAvgprice.setRecording_time(new Date());
                buildingsAvgprice.setBuildings(buildings);
                buildingsAvgpriceService.add(buildingsAvgprice);
            }
            if (upload != null) {
                try {
                    FileUtils.copyFile(upload, new File(FileUtil.uploadPath() + File.separator + uploadFileName));
                    buildings.setLogo(FileUtil.UPLOADS + "/" + uploadFileName);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            buildingsService.updateBuildings(buildings);
            result = ControllerResult.getSuccessResult("修改成功");
        } else {
            result = ControllerResult.getFailResult("修改失败");
        }
        return "updateBuildings";
    }

    //首页显示已审核的楼盘
    public String indexBuildings() {
        double avg_prices = 0;
        double avg_prices1 = 0;
        String avg[];
        pager = new Pager<>();
        pager.setPageSize(10);
        if (pageNo < 1) {
            pager.setPageNo(1);
        } else {
            pager.setPageNo(pageNo);
        }
        if (avg_price != null && avg_price.equals("0") || avg_price.equals("30000")) {
            avg_prices = Double.parseDouble(avg_price);
            avg_prices1 = avg_prices;
        } else {
            avg = avg_price.split(",");//进行分割存到数组
            avg_prices = Double.parseDouble(avg[0]);
            avg_prices1 = Double.parseDouble(avg[1]);
        }
        pager = buildingsService.queryAllindex(pager, area, avg_prices, avg_prices1, house_type, like);
        return "indexBuildings";
    }

    //首页楼盘详情
    public String indexBuildingsDetail() {
        buildings = buildingsService.queryById(buildingsId);
        return "indexBuildingsDetail";
    }

    public String indexBuildingsDetailPage() {
        return "indexBuildingsDetailPage";
    }

    //楼盘信息页面
    public String navBuildingsPage() {
        return "navBuildingsPage";
    }

    // 进入历史价格页面
    public String avgPricePage() {
        buildings = buildingsService.queryById(buildingsId);
        request.setAttribute("buildings", buildings);
        return "avgPricePage";
    }

    // 获取历史价格数据
    public String avgPrice() {
        avgprices = buildingsAvgpriceService.queryAllBuildingsAvgprice(buildingsId);
        return "avgPrice";
    }

    @Override
    public void setServletRequest(HttpServletRequest httpServletRequest) {
        this.request = httpServletRequest;
    }

}
