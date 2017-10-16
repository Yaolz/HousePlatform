package com.ht.controller;

import com.ht.bean.*;
import com.ht.common.ControllerResult;
import com.ht.common.Pager;
import com.ht.price.BuildingPrice;
import com.ht.price.BuildingsPrice;
import com.ht.service.*;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.interceptor.ServletRequestAware;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

/**
 * Created by CMY on 2017/9/5.
 */
public class BuildingAction extends ActionSupport implements ServletRequestAware {

    private HttpServletRequest request;
    private BuildingService buildingService;
    private BuildingsService buildingsService;
    private BuildingPriceService buildingPriceService;
    private HouseService houseService;
    private RoomService roomService;
    private String  buildings_id;
    private String checkedIds[];
    private int status;
    private String buildingId;
    private int updatestatus;

    private Building building;
    private BuildingsPrice buildingsPrice;
    private List<Buildings> buildingsList;
    private ControllerResult controllerResult;
    private String[] houseId;
    private String buildingsId;
    private Pager<Building> pager;
    private int pageNo = 1;
    private List<String> house_Id;
    private List<BuildingPrice> buildingPrices;

    public List<BuildingPrice> getBuildingPrices() {
        return buildingPrices;
    }

    public void setUpdatestatus(int updatestatus) {
        this.updatestatus = updatestatus;
    }

    public void setHouseService(HouseService houseService) {
        this.houseService = houseService;
    }

    public List<String> getHouse_Id() {
        return house_Id;
    }

    public void setBuildingId(String buildingId) {
        this.buildingId = buildingId;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public void setBuildings_id(String buildings_id) {
        this.buildings_id = buildings_id;
    }

    public void setCheckedIds(String[] checkedIds) {
        this.checkedIds = checkedIds;
    }

    @Override
    public void setServletRequest(HttpServletRequest httpServletRequest) {
        this.request = httpServletRequest;
    }

    public void setHouseId(String[] houseId) {
        this.houseId = houseId;
    }

    public void setRoomService(RoomService roomService) {
        this.roomService = roomService;
    }

    public ControllerResult getControllerResult() {
        return controllerResult;
    }

    public Building getBuilding() {
        return building;
    }

    public void setBuilding(Building building) {
        this.building = building;
    }

    public void setBuildingsService(BuildingsService buildingsService) {
        this.buildingsService = buildingsService;
    }

    public BuildingsPrice getBuildingsPrice() {
        return buildingsPrice;
    }

    public void setBuildingsPrice(BuildingsPrice buildingsPrice) {
        this.buildingsPrice = buildingsPrice;
    }

    public void setBuildingPriceService(BuildingPriceService buildingPriceService) {
        this.buildingPriceService = buildingPriceService;
    }

    public void setBuildingService(BuildingService buildingService) {
        this.buildingService = buildingService;
    }

    public List<Buildings> getBuildingsList() {
        return buildingsList;
    }

    public void setBuildingsId(String buildingsId) {
        this.buildingsId = buildingsId;
    }

    public Pager<Building> getPager() {
        return pager;
    }

    public int getPageNo() {
        return pageNo;
    }

    public void setPageNo(int pageNo) {
        this.pageNo = pageNo;
    }

    /**
     * 查看全部楼栋
     * @return
     */
    public String totalbuilding(){
        return "totalbuilding";
    }

    /**
     * 添加楼栋页面
     * @return
     */
    public String addbuildingpage(){
        buildingsList = buildingsService.queryAll();
        return "addbuildingpage";
    }

    /**
     * 添加楼栋
     * @return
     */
    public String addbuilding(){
        if(houseId!=null&&buildingsPrice!=null){
            building.setFloor_rooms(houseId.length);//每层有多少户
            building.setTotal_room(building.getTotal_floor()*building.getFloor_rooms());//总户数等于 每层户数乘以总层数
            building.setBuildingsPrice(buildingsPrice);
            building.setCreated_time(new Date());
            buildingService.add(building);
            for(int i =1,len = building.getTotal_floor();i<=len;i++){
                for(int j =1,leng = houseId.length;j<=leng;j++){
                    Room room = new Room();
                    room.setName(i*100+j);
                    room.setSale_status("0");
                    House house = new House();
                    house.setId(houseId[j-1]);
                    room.setHouse(house);
                    BuildingPrice buildingPrice = new BuildingPrice();
                    buildingPrice.setId(building.getId());
                    room.setBuilding(buildingPrice);
                    roomService.add(room);
                }
            }
            controllerResult = ControllerResult.getSuccessResult("添加成功！");
        }else {
            controllerResult = ControllerResult.getFailResult("添加失败了");
        }
        return "addbuilding";
    }

    //查询某楼盘下的楼栋
    public String allBuilding(){
        pager = new Pager<>();
        pager.setPageSize(6);
        if (pageNo < 1) {
            pager.setPageNo(1);
        } else {
            pager.setPageNo(pageNo);
        }
       pager = buildingService.queryAllBuildingStatus(pager,buildingsId,1);
        return "allBuilding";
    }

    //查询某楼盘下的楼栋值对象，主要用于下拉框
    public String allBuildingPrice(){
        buildingPrices = buildingPriceService.queryAllBuildingPrice(buildingsId);
        return "allBuildingPrice";
    }

    //经销商分页查询楼栋
    public String allAgencyBuilding(){
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
                pager =buildingService .queryAllBuildingStatus(pager,buildings_id,status);
            }else if(buildings_id.equals("所有楼盘")){
                pager = buildingService.queryAllBuildingAgencyStatus(pager, agency.getId(), status);
            }
        }
        return "allAgencyBuilding";
    }

    public String updateStatus(){
        HttpSession session = request.getSession();
        pager = new Pager<>();
        pager.setPageSize(10);
        if(session.getAttribute("agency")!=null){
            Agency agency = (Agency) session.getAttribute("agency");
            if(updatestatus<2&&checkedIds!=null&&checkedIds.length>0){
                buildingService.updateBuildingStatus(checkedIds,updatestatus);
            }else {
                controllerResult = ControllerResult.getFailResult("服务器繁忙");
                return "updateStatus";
            }
            if (pageNo < 1) {
                pager.setPageNo(1);
            } else {
                pager.setPageNo(pageNo);
            }
            if(!buildings_id.equals("所有楼盘")){
                pager =buildingService .queryAllBuildingStatus(pager,buildings_id,status);
                if(pager.getResult()==null||pager.getResult().size()<1){
                    pager.setPageNo(pager.getPageNo()-1);
                    pager =buildingService .queryAllBuildingStatus(pager,buildings_id,status);
                }
            }else if(buildings_id.equals("所有楼盘")){
                pager = buildingService.queryAllBuildingAgencyStatus(pager, agency.getId(),status);
                if(pager.getResult()==null||pager.getResult().size()<1){
                    pager.setPageNo(pager.getPageNo()-1);
                    pager = buildingService.queryAllBuildingAgencyStatus(pager, agency.getId(),status);
                }
            }
            if(updatestatus==1){
                controllerResult = ControllerResult.getSuccessResult("激活成功!");
            }else {
                controllerResult = ControllerResult.getSuccessResult("冻结成功!");
            }
        } else {
            controllerResult = ControllerResult.getFailResult("服务器繁忙，请稍候在尝试!");
        }
        return "updateStatus";
    }

    //更新楼盘信息
    public String updateBuilding(){
        if(houseId!=null&&buildingsPrice!=null){
            building.setFloor_rooms(houseId.length);//每层有多少户
            building.setTotal_room(building.getTotal_floor()*building.getFloor_rooms());//总户数等于 每层户数乘以总层数
            buildingService.updateBuilding(building);
            roomService.deleteBuilding(building.getId());
            for(int i =1,len = building.getTotal_floor();i<=len;i++){
                for(int j =1,leng = houseId.length;j<=leng;j++){
                    Room room = new Room();
                    room.setName(i*100+j);
                    room.setSale_status("0");
                    House house = new House();
                    house.setId(houseId[j-1]);
                    room.setHouse(house);
                    BuildingPrice buildingPrice = new BuildingPrice();
                    buildingPrice.setId(building.getId());
                    room.setBuilding(buildingPrice);
                    roomService.add(room);
                }
            }
            controllerResult = ControllerResult.getSuccessResult("更新成功！");
        }else {
            controllerResult = ControllerResult.getFailResult("更新失败");
        }
        return "updateBuilding";
    }

    //根据楼盘id查询详细信息
    public String queryById(){
        building = buildingService.queryById(buildingId);
        house_Id = roomService.queryHouseId(buildingId);
        if(status!=0&&status==4){
            building.setHouses(houseService.queryByHouse(house_Id));
        }
        return "queryById";
    }
}
