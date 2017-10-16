package com.ht.controller;

import com.ht.bean.Admin;
import com.ht.common.ControllerResult;
import com.ht.common.EncriptUtil;
import com.ht.service.AdminService;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.interceptor.ServletRequestAware;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * Created by yao on 2017/8/26.
 */
public class AdminAction extends ActionSupport implements ServletRequestAware {
    private Admin admin;
    private AdminService adminService;
    private HttpServletRequest request;
    private ControllerResult controllerResult;

    public void setAdminService(AdminService adminService) {
        this.adminService = adminService;
    }

    public ControllerResult getControllerResult() {
        return controllerResult;
    }

    public Admin getAdmin() {
        return admin;
    }

    public void setAdmin(Admin admin) {
        this.admin = admin;
    }

    // 管理员登录页面：/admin/loginpage
    public String loginpage() {
        return "loginpage";
    }

    // 管理员登录的数据操作： /admin/login
    public String login() {
        admin = adminService.queryByEmailPwd(admin.getEmail());
        if (admin != null) {
            HttpSession session = request.getSession();
            session.setAttribute("admin", admin);
            controllerResult = ControllerResult.getSuccessResult("登录成功！");
        } else {
            controllerResult = ControllerResult.getFailResult("登录失败！");
        }
        return "login";
    }

    // 登录到后台页面 : /amin/home
    public String home() {
        return "home";
    }

    // 退出到首页的请求：/admin/out
    public String out() {
        HttpSession session = request.getSession();
        session.removeAttribute("admin");
        controllerResult = ControllerResult.getSuccessResult("退出成功！");
        return "out";
    }

    // 退出页面
    public String outPage() {
        return "outPage";
    }

    // 进入详情页
    public String queryInfoPage() {
        return "queryInfoPage";
    }

    // 获取管理员信息
    public String queryInfo() {
        admin = adminService.queryById("7850cc60886411e7a5142c56dc7febbc");
        return "queryInfo";
    }

    // 区域
    public String area() {
        return "area";
    }

    // 修改管理员信息
    public String updateAdmin() {
        adminService.update(admin);
        controllerResult = ControllerResult.getSuccessResult("修改成功！");
        return "updateAdmin";
    }

    // 判断密码是否正确
    public String checkPwd() {
        String oldpwd = request.getParameter("oldpwd");
        admin = adminService.queryById(admin.getId());
        if (EncriptUtil.md5(oldpwd).equals(admin.getPwd())) {
            controllerResult = ControllerResult.getSuccessResult("密码正确！");
        } else {
            controllerResult = ControllerResult.getFailResult("密码错误！");
        }
        return "checkPwd";
    }

    // 修改密码
    public String changePwd() {
        admin.setPwd(EncriptUtil.md5(admin.getPwd()));
        adminService.updatePwd(admin);
        controllerResult = ControllerResult.getSuccessResult("修改成功！");
        return "changePwd";
    }

    @Override
    public void setServletRequest(HttpServletRequest httpServletRequest) {
        this.request = httpServletRequest;
    }
}
