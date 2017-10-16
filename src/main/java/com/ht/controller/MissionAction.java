package com.ht.controller;

import com.ht.bean.Agency;
import com.ht.bean.Employee;
import com.ht.bean.Mission;
import com.ht.common.ControllerResult;
import com.ht.common.Pager;
import com.ht.price.BuildingsPrice;
import com.ht.price.EmployeePrice;
import com.ht.price.MissionBean;
import com.ht.price.UserPrice;
import com.ht.service.MissionService;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.interceptor.ServletRequestAware;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.math.BigInteger;


public class MissionAction extends ActionSupport implements ServletRequestAware {

    private Mission mission;
    private int pageNo;

    private HttpServletRequest request;
    private String chk_value;
    private MissionService missionService;
    private ControllerResult controllerResult;
    private String  task;
    private int status ;
    private String checkedIds[];
    private Pager<MissionBean> missionPager;
    private String emp_id;

    public void setEmp_id(String emp_id) {
        this.emp_id = emp_id;
    }

    public Pager<MissionBean> getMissionPager() {
        return missionPager;
    }

    public void setCheckedIds(String[] checkedIds) {
        this.checkedIds = checkedIds;
    }

    public int getPageNo() {
        return pageNo;
    }

    public void setPageNo(int pageNo) {
        this.pageNo = pageNo;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public void setTask(String task) {
        this.task = task;
    }

    public void setMissionService(MissionService missionService) {
        this.missionService = missionService;
    }

    public ControllerResult getControllerResult() {
        return controllerResult;
    }

    public Mission getMission() {
        return mission;
    }

    public void setMission(Mission mission) {
        this.mission = mission;
    }

    public void setChk_value(String chk_value) {
        this.chk_value = chk_value;
    }



    //给员工添加绩效
    public String addmission(){
        if(chk_value!=null&&!chk_value.equals("")&&mission!=null){
            String checkedIds[] = chk_value.split(",");//进行分割存到数组
            for(String chk :checkedIds){
                Mission mission1 = new Mission();
                mission1 =mission;
                mission1.setStatus(1);
                EmployeePrice employeePrice = new EmployeePrice();
                employeePrice.setId(chk);
                mission1.setEmployeePrice(employeePrice);
                missionService.add(mission1);
            }
            controllerResult = ControllerResult.getSuccessResult("添加成功!");
        }else {
            controllerResult = ControllerResult.getFailResult("添加失败!");
        }
        return "addmission";
    }

    //批量设置百分比
    public String updatepercent(){
        if(checkedIds!=null&&checkedIds.length>0&&mission!=null){
            missionService.updateMissionBonusPercent(checkedIds,mission.getBonus_percent());
            controllerResult = ControllerResult.getSuccessResult("设置成功!");
        }else {
            controllerResult = ControllerResult.getFailResult("设置失败!");
        }
        return "updatepercent";
    }

    //批量设置员工任务量
    public String  updatequantity(){
        if(checkedIds!=null&&checkedIds.length>0&&mission!=null){
            missionService.updateMissionQuantity(checkedIds,mission.getQuantity());
            controllerResult = ControllerResult.getSuccessResult("设置成功!");
        }else {
            controllerResult = ControllerResult.getFailResult("设置失败!");
        }
        return "updatequantity";
    }

    //批量冻结或激活
    public String updateStatus(){
        if(checkedIds!=null&&checkedIds.length>0&&status<2){
            missionService.updateStatus(checkedIds,status);
            if(status==1){
                controllerResult = ControllerResult.getSuccessResult("激活成功!");
            }else {
                controllerResult = ControllerResult.getSuccessResult("冻结成功!");
            }
        }else {
            controllerResult = ControllerResult.getFailResult("服务器繁忙，请稍候在尝试!");
        }
        return "updateStatus";
    }

    //分页查询某个经销商下的绩效
    public String allmission(){
        HttpSession session = request.getSession();
        missionPager = new Pager<>();
        missionPager.setPageSize(10);
        if(session.getAttribute("agency")!=null){
            Agency agency = (Agency) session.getAttribute("agency");
            if (pageNo < 1) {
                missionPager.setPageNo(1);
            } else {
                missionPager.setPageNo(pageNo);
            }
            if(task.equals("allTasks")){//查看所有任务
                missionPager = missionService.queryAllMissionBeanAgency(missionPager,agency.getId(),status);
            }else if(task.equals("allHistoryTasks")){//查看历史布置任务
                missionPager = missionService.queryAllMissionBeanAgencyHistory(missionPager,agency.getId(),status);
            }else if(task.equals("allNewestTasks")){//查看最新布置的任务
                missionPager = missionService.queryAllMissionBeanAgencyNewest(missionPager,agency.getId(),status);
            }
            forCount();
        }else {
            controllerResult = ControllerResult.getFailResult("服务器繁忙，请稍候在尝试!");
        }
        return "allmission";
    }

    private void forCount() {
        for(MissionBean missionBean :missionPager.getResult()){
            Object object = missionService.countSale(missionBean.getId());
            if(object != null){
                missionBean.setCoun( ((BigInteger) object).longValue());
            }
        }
    }

    //查看某个员工的其他绩效
    public String allEmployeeMission(){
        HttpSession session = request.getSession();
        missionPager = new Pager<>();
        missionPager.setPageSize(10);
        if (pageNo < 1) {
            missionPager.setPageNo(1);
        } else {
            missionPager.setPageNo(pageNo);
        }
        if(session.getAttribute("agency")!=null){
            missionPager = missionService.queryAllMissionBeanEmployee(missionPager,emp_id,status);
            forCount();
        }else  if(session.getAttribute("employee")!=null){
            Employee employee = (Employee)session.getAttribute("employee");
            missionPager = missionService.queryAllMissionBeanEmployee(missionPager,employee.getId(),status);
            forCount();
        } else{
            controllerResult = ControllerResult.getFailResult("服务器繁忙，请稍候在尝试!");
        }

        return "allEmployeeMission";
    }

    //转发到绩效页面
    public String allmissionpage(){
        return "allmissionpage";
    }

    @Override
    public void setServletRequest(HttpServletRequest httpServletRequest) {
        this.request =httpServletRequest;
    }
}
