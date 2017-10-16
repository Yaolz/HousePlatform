package com.ht.controller;

import com.ht.bean.*;
import com.ht.common.ControllerResult;
import com.ht.common.EncriptUtil;
import com.ht.common.Pager;
import com.ht.service.*;
import com.ht.util.FileUtil;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.commons.io.FileUtils;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.hibernate.Session;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.Calendar;
import java.util.List;

/**
 * Created by ID.LQF on 2017/8/28.
 */
public class StaffAction extends ActionSupport implements ServletRequestAware {

    private ControllerResult result;
    private HttpServletRequest request;
    private EmployeeService employeeService;
    private SaleService saleService;
    private CustomerService customerService;
    private AppointmentService appointmentService;
    private MissionService missionService;
    private Employee employee;
    private Customer customer;
    private Sale sale;
    private Appointment appointment;
    private Mission mission;

    private File upload; // 与form表单中file的name一致，temp文件， ROOT/upload_cc3fa222_9f87_4066_af9b_8b7f07e77389_00000000.tmp
    private String uploadFileName; // 此变量的名称固定为file的name + "FileName"
    private int pageSize = 5;
    private int pageNo = 1;
    private String roomId;

    private Pager<Customer> pager;
    private Pager<Sale> salePager;
    private Pager<Appointment> appPager;
    private Pager<Mission> missionPager;

    public void setRoomId(String roomId) {
        this.roomId = roomId;
    }

    public Pager<Customer> getPager() {
        return pager;
    }

    public void setPager(Pager<Customer> pager) {
        this.pager = pager;
    }

    public Pager<Sale> getSalePager() {
        return salePager;
    }

    public void setSalePager(Pager<Sale> salePager) {
        this.salePager = salePager;
    }

    public Pager<Appointment> getAppPager() {
        return appPager;
    }

    public void setAppPager(Pager<Appointment> appPager) {
        this.appPager = appPager;
    }

    public Pager<Mission> getMissionPager() {
        return missionPager;
    }

    public void setMissionPager(Pager<Mission> missionPager) {
        this.missionPager = missionPager;
    }

    public Sale getSale() {
        return sale;
    }

    public void setSale(Sale sale) {
        this.sale = sale;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public Employee getEmployee() {
        return employee;
    }

    public void setEmployee(Employee employee) {
        this.employee = employee;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public void setAppointmentService(AppointmentService appointmentService) {
        this.appointmentService = appointmentService;
    }

    public void setMissionService(MissionService missionService) {
        this.missionService = missionService;
    }

    public int getPageNo() {
        return pageNo;
    }

    public void setPageNo(int pageNo) {
        this.pageNo = pageNo;
    }

    public Mission getMission() {
        return mission;
    }

    public void setMission(Mission mission) {
        this.mission = mission;
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

    public void setEmployeeService(EmployeeService employeeService) {
        this.employeeService = employeeService;
    }

    public void setSaleService(SaleService saleService) {
        this.saleService = saleService;
    }

    public void setCustomerService(CustomerService customerService) {
        this.customerService = customerService;
    }

    public ControllerResult getResult() {
        return result;
    }

    public void setResult(ControllerResult result) {
        this.result = result;
    }

    public Appointment getAppointment() {
        return appointment;
    }

    public void setAppointment(Appointment appointment) {
        this.appointment = appointment;
    }

    //查询销售记录表的信息并且返回
    public String queryBySale(){
        Sale sale = saleService.queryByRoom(roomId);
        if(sale!=null){
            customer = customerService.queryById(sale.getCustomer().getId());
        }

        return "queryBySale";
    }

    public String reg(){//注册请求 url：staff/reg
        employee.setPhone(employee.getPhone());
        employee.setEmail(employee.getEmail());
        employee.setBasic_salary(employee.getBasic_salary());
        employee.setPwd(EncriptUtil.md5(employee.getPwd()));
        employee.setCreated_time(Calendar.getInstance().getTime());
        employeeService.add(employee);
        return "reg";
    }

    public String login(){//登入请求 url：staff/login
        String pwd = EncriptUtil.md5(employee.getPwd());
        Employee em = employeeService.queryByPwd(employee.getEmail());
        if(em!=null) {
            if(pwd.equals(em.getPwd())) {
                HttpSession session = request.getSession();
                session.setAttribute("employee", em);
                result = ControllerResult.getSuccessResult("登入成功");
            } else {
                result = ControllerResult.getFailResult("密码错误");
            }
        } else {
            result = ControllerResult.getFailResult("邮箱错误");
        }
        return "login";
    }

    public String save(){//个人中心的首页中，点击编辑后的保存操作 url：staff/save
        HttpSession httpSession = request.getSession();
        if(httpSession.getAttribute("employee")!=null){
            Employee employee1 = (Employee) httpSession.getAttribute("employee");
            try {
                if(upload!=null&&!upload.equals("")){
                    if(employee1.getHeadicon()==null){
                        FileUtils.copyFile(upload, new File(FileUtil.uploadPath() + File.separator + uploadFileName));
                        employee.setHeadicon(FileUtil.UPLOADS+"/"+uploadFileName);
                    }else if(employee1.getHeadicon().equals(FileUtil.UPLOADS+"/"+uploadFileName)){
                        employee.setHeadicon(employee1.getHeadicon());
                    }else if(employee1.getHeadicon()!=null&&!employee1.getHeadicon().equals(FileUtil.UPLOADS+"/"+uploadFileName)){
                        if(employee1.getHeadicon().contains("public")){
                            FileUtils.copyFile(upload, new File(FileUtil.uploadPath() + File.separator + uploadFileName));
                            employee.setHeadicon(FileUtil.UPLOADS+"/"+uploadFileName);
                        }else {
                            FileUtil.removeFile(employee1.getHeadicon());
                            FileUtils.copyFile(upload, new File(FileUtil.uploadPath() + File.separator + uploadFileName));
                            employee.setHeadicon(FileUtil.UPLOADS+"/"+uploadFileName);
                        }
                    }
                }else {
                    employee.setHeadicon(employee.getHeadicon());
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
            employee.setId(employee1.getId());
            employeeService.updateEmployee(employee);
            result = ControllerResult.getSuccessResult("修改成功");
            httpSession.setAttribute("employee",employee);
        }
        return "save";
    }

    //验证密码
    public String checkPwd() {
        HttpSession session = request.getSession();
        String oldpwd = request.getParameter("oldpwd");
        if (session.getAttribute("employee") != null) {
            Employee e = (Employee) session.getAttribute("employee");
            employee = employeeService.queryById(e.getId());
        }
        if (EncriptUtil.md5(oldpwd).equals(employee.getPwd())) {
            result = ControllerResult.getSuccessResult("密码正确！");
        } else {
            result = ControllerResult.getFailResult("密码错误！");
        }
        return "checkPwd";
    }

    public String confirm(){//个人中心修改密码页面中的确认操作 url：staff/confirm
        employeeService.updateEmailPwd(employee.getEmail(),EncriptUtil.md5(employee.getPwd()));
        result = ControllerResult.getSuccessResult("修改成功");
        return "confirm";
    }

    //登入成功后跳转到个人中心 url：staff/home
    public String home(){
        return "home";
    }

    //注册页面 url：staff/regPage
    public String regPage(){
        return "regPage";
    }

    //登入页面 url：staff/loginPage
    public String loginPage(){
        HttpSession session = request.getSession();
        return "loginPage";
    }

    //客户页面返回的json信息  url：staff/cusCheckJson
    public String cusCheckJson(){
        HttpSession session = request.getSession();
        pager = new Pager<>();
        pager.setPageSize(pageSize);
        if(session.getAttribute("employee")!=null){
            Employee employee = (Employee)session.getAttribute("employee");
            if (pageNo < 1) {
                pager.setPageNo(1);
            } else {
                pager.setPageNo(pageNo);
            }
            pager = customerService.queryCustomer(pager,employee.getId());
        }
   
        return "cusCheckJson";
    }

    //个人中心的客户查看页面 url：staff/cusCheck
    public String cusCheck(){
        return "cusCheck";
    }

    //个人中心的销售记录页面跳转时返回的json数据 url：staff/sellRecordJson
    public String sellRecordJson(){
        HttpSession session = request.getSession();
        employee = (Employee) session.getAttribute("employee");
        if(employee != null ){
            salePager = new Pager<>();
            salePager.setPageSize(pageSize);
            if (pageNo < 1) {
                salePager.setPageNo(1);
            } else {
                salePager.setPageNo(pageNo);
            }
            salePager = saleService.queryPager(salePager,employee.getId());

        }
        return "sellRecordJson";
    }

    //个人中心的销售记录页面 url：staff/sellRecord
    public String sellRecord(){
        return "sellRecord";
    }

    //个人中心返回的json数据
    public String staffCenterJson(){
        HttpSession session = request.getSession();
        if(session.getAttribute("employee")!=null){
            employee = (Employee) session.getAttribute("employee");
        }
        return "staffCenterJson";
    }

    //个人中心的个人资料页面 url：staff/staffCenter
    public String staffCenter(){
        return "staffCenter";
    }

    //个人中心的修改密码页面 url：staff/editPwd
    public String editPwd(){
        return "editPwd";
    }

    //个人中心修改页面中点击取消按钮后的操作  url：staff/cancel
    public String cancel(){
        return "cancel";
    }

    //个人中心的添加客户页面的操作 url：staff/addClient
    public String addClient(){
        HttpSession session = request.getSession();
        session.setAttribute("customer",customer);
        return "addClient";
    }

    //经销商员工的个人中心页面中添加销售记录的页面 url：staff/addSell
    public String addSell(){
        return "addSell";
    }

    //绩效查看页面 url：staff/mission
    public String mission(){
        return "mission";
    }

    //绩效查看页面 url：staff/mission
    public String missionJson(){
        HttpSession session = request.getSession();
        employee = (Employee) session.getAttribute("employee");
        if(employee != null) {
            missionPager = new Pager<>();
            missionPager.setPageSize(pageSize);
            if (pageNo < 1) {
                missionPager.setPageNo(1);
            } else {
                missionPager.setPageNo(pageNo);
            }
            missionPager = missionService.queryPager(missionPager, employee.getId());
        }
        return "missionJson";
    }

    //房屋销售图表查看 url：staff/homeSellChart
    public String homeSellChart(){
        return "homeSellChart";
    }

    //房屋业主信息查看 url： staff/houseHostCheck
    public String houseHostCheck(){
        return "houseHostCheck";
    }

    //购房预约查看  url：staff/appointment
    public String appointment(){
        return "appointment";
    }

    //根据ID来查询员工的信息
    public String employeeDetail() {
        String empId = request.getParameter("emp_id");
        employee =employeeService.queryById(empId);
        return "employeeDetail";
    }

    //购房预约查看返回的json数据  url：staff/appointmentJson
    public String appointmentJson(){
        HttpSession session = request.getSession();
        appPager = new Pager<>();
        appPager.setPageSize(pageSize);
        if (pageNo < 1) {
            appPager.setPageNo(1);
        } else {
            appPager.setPageNo(pageNo);
        }
        if(session.getAttribute("employee") != null) {
            Employee employee1 = (Employee) session.getAttribute("employee");
            appPager = appointmentService.queryPager(appPager, employee1.getId());
        }
        return "appointmentJson";
    }

    //从个人中心退出的操作 url：staff/out
    public String out(){
        HttpSession session = request.getSession();
        session.removeAttribute("employee");
        result = ControllerResult.getSuccessResult("成功退出");
        return "out";
    }

    //从个人中心返回首页的操作 url：staff/index
    public String index(){
        result = ControllerResult.getSuccessResult("成功返回首页");
        return "index";
    }


    @Override
    public void setServletRequest(HttpServletRequest httpServletRequest) {
        this.request = httpServletRequest;
    }

}

