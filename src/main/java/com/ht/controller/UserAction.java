package com.ht.controller;

import com.ht.bean.*;
import com.ht.common.Content;
import com.ht.common.ControllerResult;
import com.ht.common.EncriptUtil;
import com.ht.common.Pager;
import com.ht.service.*;
import com.ht.util.FileUtil;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.commons.io.FileUtils;
import org.apache.struts2.interceptor.ServletRequestAware;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;

/**
 * Created by CHEN JX on 2017/8/24.
 */
public class UserAction extends ActionSupport implements ServletRequestAware {
    private UserService userService;
    private HttpServletRequest request;
    private HttpSession session;
    private File upload; // 与form表单中file的name一致，temp文件， ROOT/upload_cc3fa222_9f87_4066_af9b_8b7f07e77389_00000000.tmp
    private String uploadFileName; // 此变量的名称固定为file的name + "FileName"


    private User user;
    private String email;
    private String pwd;
    private ControllerResult result;
    private int pageNo = 1;
    private int pageSize = 5;
    private Pager<User> userPager;

    public HttpSession getSession() {
        return session;
    }

    public void setSession(HttpSession session) {
        this.session = session;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Pager<User> getUserPager() {
        return userPager;
    }

    public void setUserPager(Pager<User> userPager) {
        this.userPager = userPager;
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    public ControllerResult getResult() {
        return result;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPwd() {
        return pwd;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd;
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

    public String regPage() { //到注册界url:user/page
        return "regPage";
    }

    public String loginPage() { //到登入界面url:user/loginpage
        return "loginPage";
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

    public String login() {//做登入操作
        user = userService.queryEmailPwd(email);
        if (user == null) {
            result = ControllerResult.getFailResult("用户名不存在");
        } else {
            if (user.getPwd().equals(EncriptUtil.md5(pwd))) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                result = ControllerResult.getSuccessResult("登入成功");
            }

        }
        return "login";
    }

    public String home() {
        return "home";
    }

    public String index() {//首页:user/index
        return "index";
    }


    // 分页查询所有用户： /user/userAll
    public String userAlljson() {
        userPager = new Pager<User>();
        userPager.setPageSize(pageSize);
        if (pageNo < 1) {
            userPager.setPageNo(1);
        } else {
            userPager.setPageNo(pageNo);
        }
        userPager = userService.queryPager(userPager);
        return "userAlljson";
    }

    public String userAll() {
        return "userAll";
    }


    //查看基本信息 user/information
    public String save() {
        HttpSession httpSession = request.getSession();
        if(httpSession.getAttribute("user")!=null){
            User user1 = (User) httpSession.getAttribute("user");
            try {
                if(upload!=null&&!upload.equals("")){
                    if(user1.getHeadicon()==null){
                        FileUtils.copyFile(upload, new File(FileUtil.uploadPath() + File.separator + uploadFileName));
                        user.setHeadicon(FileUtil.UPLOADS+"/"+uploadFileName);
                    }else if(user1.getHeadicon().equals(FileUtil.UPLOADS+"/"+uploadFileName)){
                        user.setHeadicon(user1.getHeadicon());
                    }else if(user1.getHeadicon()!=null&&!user1.getHeadicon().equals(FileUtil.UPLOADS+"/"+uploadFileName)){
                        if(user1.getHeadicon().contains("public")){
                            FileUtils.copyFile(upload, new File(FileUtil.uploadPath() + File.separator + uploadFileName));
                            user.setHeadicon(FileUtil.UPLOADS+"/"+uploadFileName);
                        }else {
                            FileUtil.removeFile(user1.getHeadicon());
                            FileUtils.copyFile(upload, new File(FileUtil.uploadPath() + File.separator + uploadFileName));
                            user.setHeadicon(FileUtil.UPLOADS+"/"+uploadFileName);
                        }
                    }
                }else {
                    user.setHeadicon(user.getHeadicon());
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
            user.setId(user1.getId());
            userService.updateUser(user);
            result = ControllerResult.getSuccessResult("修改成功");
            httpSession.setAttribute("user",user);
        }
        return "save";
    }

    public String informationJson() {
        HttpSession session = request.getSession();
        if(session.getAttribute("user")!=null){
            user = (User) session.getAttribute("user");
        }
        return "informationJson";
    }

    public String information() {
        return "information";
    }

    public String updatePwd() {
        return "updatePwd";
    }


    public String update(){
       userService.updatePwd(EncriptUtil.md5(user.getPwd()),user.getId());
        result = ControllerResult.getSuccessResult("修改成功");
        return "update";
    }
    //验证密码
    public String checkPwd() {
        HttpSession session = request.getSession();
        String oldpwd = request.getParameter("oldpwd");
        if (session.getAttribute("user") != null) {
            User user1 = (User) session.getAttribute("user");
            user = userService.queryById(user1.getId());
        }
        if (EncriptUtil.md5(oldpwd).equals(user.getPwd())) {
            result = ControllerResult.getSuccessResult("密码正确！");
        } else  {
            result = ControllerResult.getFailResult("密码错误！");
        }
        return "checkPwd";
    }


    //用户详情
    public String queryUser() {
        HttpSession httpSession = request.getSession();
        if (httpSession.getAttribute("user") != null) {
            user = (User) httpSession.getAttribute("user");
        }
        return "queryUser";
    }

    //用户详情
    public String userDetail() {
        String id = request.getParameter("id");
        user = userService.queryById(id);
        request.setAttribute("user", user);
        return "userDetail";
    }

    //修改状态
    public String status() {
        String id = request.getParameter("userId");    //获取前台隐藏域存着的选中的复选框的value
        String checkedIds[] = id.split(",");
        if (user.getStatus() == Content.StatusNo) {
            userService.updateStatusById(checkedIds, Content.CheckYes);
        } else {
            userService.updateStatusById(checkedIds, Content.CheckNo);
        }
        return "status";
    }

    @Override
    public void setServletRequest(HttpServletRequest httpServletRequest) {
        this.request = httpServletRequest;
    }
}
