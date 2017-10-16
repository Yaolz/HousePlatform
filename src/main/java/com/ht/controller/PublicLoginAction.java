package com.ht.controller;

import com.ht.bean.Agency;
import com.ht.bean.Employee;
import com.ht.bean.Role;
import com.ht.bean.User;
import com.ht.common.ControllerResult;
import com.ht.common.EncriptUtil;
import com.ht.price.UserPrice;
import com.ht.service.AgencyService;
import com.ht.service.EmployeeService;
import com.ht.service.UserService;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.interceptor.ServletRequestAware;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;

public class PublicLoginAction extends ActionSupport implements ServletRequestAware {

    private HttpServletRequest request;
    private String email;
    private String pwd;
    private String phone;
    private String pwds;
    private String name;
    private UserService userService;
    private AgencyService agencyService;
    private EmployeeService employeeService;//都是只有set方法的属性


    private String trues;//只有get的属性
    private ControllerResult result;

    public void setName(String name) {
        this.name = name;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public void setResult(ControllerResult result) {
        this.result = result;
    }

    public ControllerResult getResult() {
        return result;
    }

    public void setPwds(String pwds) {
        this.pwds = pwds;
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    public void setAgencyService(AgencyService agencyService) {
        this.agencyService = agencyService;
    }

    public void setEmployeeService(EmployeeService employeeService) {
        this.employeeService = employeeService;
    }

    public String getTrues() {
        return trues;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd;
    }

    public String index(){
        return "index";
    }

    public String indexRegister(){
        return "indexRegister";
    }


    //登入验证时的请求
    public String login() {
        HttpSession session = request.getSession();
        User user = null;
        Agency agency = null;
        Employee employee = null;
        if(email.contains("@")){
            user = userService.queryEmailPwd(email);
            agency = agencyService.queryEmailPwd(email);
            employee = employeeService.queryByPwd(email);
        }else{
            user = userService.queryByPhone(email);
            agency = agencyService.queryByPhone(email);
            employee = employeeService.queryByPhone(email);
        }
         if(user !=null){
            if(user.getStatus()!=0){
                if(user.getPwd().equals(EncriptUtil.md5(pwd))){
                    session.setAttribute("user", user);
                    session.removeAttribute("agency");
                    session.removeAttribute("employee");
                    result = ControllerResult.getSuccessResult("");
                    result.setUrl("index/index");
                }else {
                    result = ControllerResult.getFailResult("你输入的密码错误");
                }
            }else {
                result = ControllerResult.getFailResult("你的账户已被冻结，请联系客服进行解冻");
            }
        }else if(agency!=null){
             if(agency.getChecked_status()!=0&&agency.getStatus()!=0){
                 if(agency.getPwd().equals(EncriptUtil.md5(pwd))){
                     session.setAttribute("agency", agency);
                     session.removeAttribute("employee");
                     session.removeAttribute("user");
                     result = ControllerResult.getSuccessResult("");
                     result.setUrl("agency/Agency");
                 }else {
                     result = ControllerResult.getFailResult("你输入的密码错误");
                 }
             }else {
                 result = ControllerResult.getFailResult("你的账户已被冻结，请联系客服进行解冻");
             }
        }else if(employee!=null){
            if(employee.getStatus()!=0){
                if(employee.getPwd().equals(EncriptUtil.md5(pwd))){
                    employee.getAgencyPrice();
                    session.setAttribute("employee", employee);
                    session.removeAttribute("agency");
                    session.removeAttribute("user");
                    result = ControllerResult.getSuccessResult("");
                    result.setUrl("staff/home");
                }else {
                    result = ControllerResult.getFailResult("你输入的密码错误");
                }
            }else {
                result = ControllerResult.getFailResult("你的账户已被冻结，请联系所属经销商或客服进行解冻");
            }
        }else {
            result = ControllerResult.getFailResult("你输入的用户名不存在");
        }
        return "login";
    }

    //在首页点击登入后进行的转发页面方法
    public String indexlogin(){
        return "indexlogin";
    }

    //注册时验证次email有没有被注册的请求
    public String queryEmail(){
        User user = userService.queryEmailPwd(email);
        Agency agency = agencyService.queryEmailPwd(email);
        Employee employee = employeeService.queryByPwd(email);
        returnTrues(agency, user, employee);
        return "queryEmail";
    }

    //验证手机号有没有被注册的请求
    public String queryPhone(){
        HttpSession session =request.getSession();
        User user = userService.queryByPhone(phone);
        Agency agency = agencyService.queryByPhone(phone);
        Employee employee = employeeService.queryByPhone(phone);
        returnTrues(agency, user, employee);
        return "queryPhone";
    }

    //修改基础信息的时候验证名称是否已经存在了
    public String queryName(){
        HttpSession session =request.getSession();
        Agency agency = agencyService.queryByName(name);;
        User user = userService.queryByNickname(name);
        Employee employee  = employeeService.queryByName(name);;
        if(session.getAttribute("user")!=null){
            User user1 = (User)session.getAttribute("user");
            if(user1.getNickname()!=null&&user1.getNickname().equals(name)){
                trues = "false";
                return "queryName";
            }
        }else if(session.getAttribute("agency")!=null){
            Agency agency1 = (Agency) session.getAttribute("agency");
            if(agency1.getName()!=null&&agency1.getName().equals(name)){
                trues = "false";
                return "queryName";
            }
        } else if(session.getAttribute("employee")!=null){
            Employee employee1 = (Employee)session.getAttribute("employee");
            if(employee1.getName()!=null&&employee1.getName().equals(name)){
                trues = "false";
                return "queryName";
            }
        }
        returnTrues(agency, user, employee);
        return "queryName";
    }

    //查询此手机号码有没有被注册过
    public String queryByPhone(){
        HttpSession session =request.getSession();
        User user = userService.queryByPhone(phone);
        Agency agency = agencyService.queryByPhone(phone);
        Employee employee = employeeService.queryByPhone(phone);
        if(session.getAttribute("user")!=null){
            User user1 = (User)session.getAttribute("user");
            if(user1.getPhone()!=null&&user1.getPhone().equals(phone)){
                trues = "false";
                return "queryByPhone";
            }
        }else if(session.getAttribute("agency")!=null){
            Agency agency1 = (Agency) session.getAttribute("agency");
            if(agency1.getPhone()!=null&&agency1.getPhone().equals(phone)){
                trues = "false";
                return "queryByPhone";
            }
        } else if(session.getAttribute("employee")!=null){
            Employee employee1 = (Employee)session.getAttribute("employee");
            if(employee1.getPhone()!=null&&employee1.getPhone().equals(phone)){
                trues = "false";
                return "queryByPhone";
            }
        }
        returnTrues(agency, user, employee);
        return "queryByPhone";
    }

    private void returnTrues(Agency agency, User user, Employee employee) {
        if (user != null) {
            trues = "true";
        } else if (agency != null) {
            trues = "true";
        } else if (employee!=null){
            trues = "true";
        }else {
            trues = "false";
        }
    }

    /**
     * 普通用户注册
     * @return
     */
    public String reg(){
        HttpSession session =request.getSession();
        User user = new User();
        user.setEmail(email);
        if(!pwd.equals(pwds)){
            result = ControllerResult.getSuccessResult("注册失败，你两次输入的密码不一样");
            result.setUrl("index/indexRegister");
            return "reg";
        }
        user.setPwd(EncriptUtil.md5(pwd));
        user.setPhone(phone);
        Role role = new Role();
        role.setId("d737ab4487f411e7a5142c56dc7febbc");
        user.setRole(role);
        user.setStatus(1);
        user.setHeadicon("public/img/a1.jpg");
        user.setName(email);
        user.setGender("--");
        userService.add(user);
        result = ControllerResult.getSuccessResult("注册成功");
        result.setUrl("index/index");
        session.setAttribute("user",user);
        return "reg";
    }

    /**
     * 经销商注册
     * @return
     */
    public String waitaudit(){
        Agency agency = new Agency();
        agency.setEmail(email);
        agency.setPhone(phone);
        if(!pwd.equals(pwds)){
            result = ControllerResult.getSuccessResult("注册失败，你两次输入的密码不一样");
            result.setUrl("index/indexRegister");
            return "waitaudit";
        }
        agency.setPwd(EncriptUtil.md5(pwd));
        Role role = new Role();
        role.setId("d715a8c987f411e7a5142c56dc7febbc");
        agency.setRole(role);
        agency.setChecked_status(0);
        agency.setStatus(1);
        agency.setCreated_time(new Date());
        agency.setName(email);
        agencyService.add(agency);
        result = ControllerResult.getSuccessResult("注册成功，我们会在1到10分钟之内对你的资料进行审核，请在审核完毕后登入");
        result.setUrl("index/index");
        return "waitaudit";
    }

    public String remove(){
        HttpSession session = request.getSession();
        session.invalidate();
        return "remove";
    }

    public String buildingspage(){
        return "buildingspage";
    }
    public String housepage(){
        return "housepage";
    }
    public String Informationpage(){
        return "Informationpage";
    }
    public String activitypage(){
        return "activitypage";
     }


    @Override
    public void setServletRequest(HttpServletRequest httpServletRequest) {
        this.request = httpServletRequest;
    }

}
