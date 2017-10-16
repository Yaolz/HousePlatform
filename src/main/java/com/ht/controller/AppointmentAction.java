package com.ht.controller;

import com.ht.bean.Agency;
import com.ht.bean.Appointment;
import com.ht.bean.Buildings;
import com.ht.bean.User;
import com.ht.common.Content;
import com.ht.common.ControllerResult;
import com.ht.common.Pager;
import com.ht.price.UserPrice;
import com.ht.service.AppointmentService;
import com.ht.service.BuildingsService;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.interceptor.ServletRequestAware;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Calendar;
import java.util.List;

/**
 * Created by CHEN JX on 2017/9/8.
 * 用户预约
 */
public class AppointmentAction extends ActionSupport implements ServletRequestAware {

    private AppointmentService appointmentService;
    private BuildingsService buildingsService;
    private HttpServletRequest request;

    private Appointment appointment;
    private Buildings buildings;

    private List<Appointment> appointments;
    private Pager<Appointment> appointmentPager;

    private ControllerResult result;
    private long total;
    private int totalPage;
    private int page = 1;
    private int pageSize = 5;
    private int app_status;
    private int status;
    private int pageNo;

    public Pager<Appointment> getAppointmentPager() {
        return appointmentPager;
    }

    public void setPageNo(int pageNo) {
        this.pageNo = pageNo;
    }

    public int getPageNo() {
        return pageNo;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public void setApp_status(int app_status) {
        this.app_status = app_status;
    }

    public void setAppointmentService(AppointmentService appointmentService) {
        this.appointmentService = appointmentService;
    }

    public Appointment getAppointment() {
        return appointment;
    }

    public void setAppointment(Appointment appointment) {
        this.appointment = appointment;
    }

    public List<Appointment> getAppointments() {
        return appointments;
    }

    public void setAppointments(List<Appointment> appointments) {
        this.appointments = appointments;
    }

    public ControllerResult getResult() {
        return result;
    }

    public long getTotal() {
        return total;
    }

    public void setTotal(long total) {
        this.total = total;
    }

    public int getTotalPage() {
        return totalPage;
    }

    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }


    public Buildings getBuildings() {
        return buildings;
    }

    public void setBuildings(Buildings buildings) {
        this.buildings = buildings;
    }

    public void setBuildingsService(BuildingsService buildingsService) {
        this.buildingsService = buildingsService;
    }

    public String appointment(){
        HttpSession session = request.getSession();
        User loginUser = (User) session.getAttribute("user");
        Pager<Appointment> appointmentPager = new Pager<>();
        int count = (int) appointmentService.countAppointment(loginUser.getId());
        int pageCount = count % pageSize == 0 ? count / pageSize : (count / pageSize) + 1;
        if (page <= 0) {
            page = 1;
        }
        if (page > pageCount) {
            page = pageCount;
        }
        appointmentPager.setPageNo(page);//有多少页
        appointmentPager.setPageSize(pageSize);//每页多少个
        appointmentPager = appointmentService.queryAllAppointment(appointmentPager, loginUser.getId());
        appointments = appointmentPager.getResult();
        request.setAttribute("pageCount", pageCount);
        session.setAttribute("appointments", appointments);
        return "appointment";
    }


    public String status(){

        if(appointment.getStatus()==0){
            appointmentService.updateAppointmentStatus(appointment.getId(), Content.ShowStatusYes);
        }else{
            appointmentService.updateAppointmentStatus(appointment.getId(),Content.ShowStatusNo);
        }
        return "status";
    }


    //预约状态修改
    public String appointmentStatus(){
        appointmentService.updateAppStatus(appointment);
        result = ControllerResult.getSuccessResult("修改成功");
        return "appointmentStatus";
    }

    //页面中的预约
    public String appoint(){
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        UserPrice userPrice = new UserPrice();
        userPrice.setId(user.getId());
        Appointment appointment1 = appointmentService.queryAppointment(user.getId(), appointment.getEmployeePrice().getId());
        if(appointment1 == null || appointment1.equals("")){
            appointment.setUserPrice(userPrice);
            appointment.getEmployeePrice().getId();
            appointment.getAgencyPrice().getId();
            appointment.setCreated_time(Calendar.getInstance().getTime());
            appointmentService.add(appointment);
            result = ControllerResult.getSuccessResult("预约成功");
        } else {
            result = ControllerResult.getFailResult("您已预约");
        }
        return "appoint";
    }

    //经销商预约页面跳转url
    public String allAppointment(){
        return "allAppointment";
    }


    //经销商分页查看预约
    public String AllApp(){
        HttpSession session = request.getSession();
        appointmentPager = new Pager<>();
        appointmentPager.setPageSize(10);
        if(session.getAttribute("agency")!=null){
            Agency agency = (Agency) session.getAttribute("agency");
            if (pageNo < 1) {
                appointmentPager.setPageNo(1);
            } else {
                appointmentPager.setPageNo(pageNo);
            }
            appointmentPager = appointmentService.queryAllAppointmentAgency(appointmentPager,agency.getId(),app_status,status);
        }else {
            result = ControllerResult.getFailResult("服务器繁忙，请稍候在尝试!");
        }
        return "AllApp";
    }

    @Override
    public void setServletRequest(HttpServletRequest request) {
        this.request = request;
    }
}
