package com.ht.controller;

import com.ht.bean.Agency;
import com.ht.bean.Employee;
import com.ht.bean.Room;
import com.ht.common.ControllerResult;
import com.ht.common.Pager;
import com.ht.service.RoomService;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.interceptor.ServletRequestAware;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * Created by yao on 2017/9/20.
 */
public class RoomAction extends ActionSupport implements ServletRequestAware {
    private HttpServletRequest request;
    private RoomService roomService;

    private int pageNo = 1;
    private Pager<Room> pager;
    private String buildings_id;//楼盘id
    private int sale_status;//房屋销售状态
    private String[] chk_value1;
    private ControllerResult controllerResult;
    private Employee employee;
    private String buildingId;

    public ControllerResult getControllerResult() {
        return controllerResult;
    }

    public void setChk_value1(String[] chk_value1) {
        this.chk_value1 = chk_value1;
    }

    public void setBuildings_id(String buildings_id) {
        this.buildings_id = buildings_id;
    }

    public void setSale_status(int sale_status) {
        this.sale_status = sale_status;
    }

    public int getPageNo() {
        return pageNo;
    }

    public void setPageNo(int pageNo) {
        this.pageNo = pageNo;
    }

    public void setRoomService(RoomService roomService) {
        this.roomService = roomService;
    }

    public String getBuildingId() {
        return buildingId;
    }

    public void setBuildingId(String buildingId) {
        this.buildingId = buildingId;
    }

    public Pager<Room> getPager() {
        return pager;
    }

    public Employee getEmployee() {
        return employee;
    }

    public void setEmployee(Employee employee) {
        this.employee = employee;
    }

    //显示某楼盘下的房间号
    public String navRoom(){
        pager=new Pager<>();
        pager.setPageSize(36);
        if (pageNo < 1) {
            pager.setPageNo(1);
        } else {
            pager.setPageNo(pageNo);
        }
        pager=roomService.queryPagers(pager,buildingId);
        return "navRoom";
    }
    public String navRoomPage(){
        return "navRoomPage";
    }

    //房屋状态页面跳转
    public String allRoomPage(){
        return "allRoomPage";
    }

    //房屋页面分页
    public String allRoom(){
        HttpSession session = request.getSession();
        pager = new Pager<>();
        pager.setPageSize(10);
        if (pageNo < 1) {
            pager.setPageNo(1);
        } else {
            pager.setPageNo(pageNo);
        }
        if(session.getAttribute("agency")!=null){
            Agency agency = (Agency) session.getAttribute("agency");
            if(buildings_id!=null&&!buildings_id.equals("所有楼盘")&&buildingId.equals("所有楼栋")){
                pager =roomService .AllBuildingsRoom(pager,buildings_id,sale_status);
            }else if(buildings_id.equals("所有楼盘")&&buildingId.equals("所有楼栋")){
                pager = roomService.AllAgencyRoom(pager, agency.getId(), sale_status);
            }else if(!buildings_id.equals("所有楼盘")&&!buildingId.equals("所有楼栋")){
                pager = roomService.AllBuildingRoom(pager, buildingId, sale_status);
            }
        }else if(session.getAttribute("employee")!=null){
            if(buildings_id!=null&&!buildings_id.equals("所有楼盘")&&buildingId.equals("所有楼栋")){
                pager =roomService .AllBuildingsRoom(pager,buildings_id,sale_status);
            }else if(!buildings_id.equals("所有楼盘")&&!buildingId.equals("所有楼栋")){
                pager = roomService.AllBuildingRoom(pager, buildingId, sale_status);
            }
        }
        return "allRoom";
    }

    //批量修改房屋状态
    public String updateSaleStatus(){
        if(chk_value1.length>0&&sale_status<5){
            roomService.updateSaleStatus(chk_value1,sale_status);
            controllerResult = ControllerResult.getSuccessResult("修改成功!");
        }else {
            controllerResult = ControllerResult.getFailResult("服务器繁忙，请稍候在尝试!");
            return "updateSaleStatus";
        }
        return "updateSaleStatus";
    }

    public String roomPageJson(){
        pager = new Pager<Room>();
        pager.setPageSize(10);
        if (pageNo < 1) {
            pager.setPageNo(1);
        } else {
            pager.setPageNo(pageNo);
        }
        pager = roomService.queryPager(pager);
        return "roomPageJson";
    }

    @Override
    public void setServletRequest(HttpServletRequest httpServletRequest) {
        this.request=httpServletRequest;
    }
}
