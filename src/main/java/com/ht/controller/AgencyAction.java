package com.ht.controller;

import com.ht.bean.Agency;

import com.ht.bean.Employee;
import com.ht.common.Content;
import com.ht.common.ControllerResult;
import com.ht.common.EncriptUtil;
import com.ht.common.Pager;
import com.ht.service.AgencyService;
import com.ht.util.FileUtil;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.commons.io.EndianUtils;
import org.apache.commons.io.FileUtils;
import org.apache.struts2.interceptor.ServletRequestAware;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;

/**
 * Created by CMY on 2017/8/28.
 */
public class AgencyAction extends ActionSupport  implements ServletRequestAware {

    private AgencyService agencyService;
    private HttpServletRequest request;
    private File upload; // 与form表单中file的name一致，temp文件， ROOT/upload_cc3fa222_9f87_4066_af9b_8b7f07e77389_00000000.tmp
    private String uploadFileName; // 此变量的名称固定为file的name + "FileName"

    private ControllerResult result;
    private Agency agency;
    private Pager<Agency> agencyPager;

    private int pageNo = 1;
    private int pageSize = 5;

    private String pwd;
    private String pwd1;

    public void setPwd(String pwd) {
        this.pwd = pwd;
    }

    public void setPwd1(String pwd1) {
        this.pwd1 = pwd1;
    }

    public void setUpload(File upload) {
        this.upload = upload;
    }

    public void setUploadFileName(String uploadFileName) {
        this.uploadFileName = uploadFileName;
    }

    public Agency getAgency() {
        return agency;
    }

    public void setAgency(Agency agency) {
        this.agency = agency;
    }

    public Pager<Agency> getAgencyPager() {
        return agencyPager;
    }

    public void setAgencyPager(Pager<Agency> agencyPager) {
        this.agencyPager = agencyPager;
    }

    public ControllerResult getResult() {
        return result;
    }

    public void setResult(ControllerResult result) {
        this.result = result;
    }

    public void setAgencyService(AgencyService agencyService) {
        this.agencyService = agencyService;
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

    //修改经销商密码
    public String updateAgencyPwd(){
        HttpSession session = request.getSession();
        if(session.getAttribute("agency")!=null){
           Agency agency1 = (Agency) session.getAttribute("agency");
           if(pwd.equals(pwd1)&&agency1.getPwd().equals(EncriptUtil.md5(agency.getPwd()))){
               agencyService.updateEmailPwd(agency1.getEmail(),EncriptUtil.md5(pwd));
               result = ControllerResult.getSuccessResult("修改成功！");
               agency1.setPwd(EncriptUtil.md5(pwd));
               session.setAttribute("agency",agency1);
           }else {
               result = ControllerResult.getFailResult("修改失败,你输入的原密码不正确");
           }
        }else {
            result = ControllerResult.getFailResult("请先登入！");
        }
        return "updateAgencyPwd";
    }

    /**
     * 进入入驻
     * @return
     */
    public String register(){
        return "register";
    }


    // 分页查询已激活并且以审核的经销商  /agency/agencyAll
    public String agencyAll() {
        agencyPager = new Pager<>();
        agencyPager.setPageSize(pageSize);
        if (pageNo < 1) {
            agencyPager.setPageNo(1);
        } else {
            agencyPager.setPageNo(pageNo);
        }
        agencyPager = agencyService.queryAllRight(agencyPager,1,1);
        return "agencyAll";
    }
    public String agencyAllPage(){
        return "agencyAllPage";
    }


    public String Message(){
        return "Message";
    }

    // 查询未审核的经销商  /agency/agencyCheck
    public String agencyCheck() {
        agencyPager = new Pager<>();
        agencyPager.setPageSize(pageSize);
        if (pageNo < 1) {
            agencyPager.setPageNo(1);
        } else {
            agencyPager.setPageNo(pageNo);
        }
        agencyPager = agencyService.queryAllChecked(agencyPager,Content.CheckNo);
        return "agencyCheck";
    }
    public String agencyCheckPage(){
        return "agencyCheckPage";
    }

    // 把未审核的改成审核,可多选
    public String checkChange() {
        String id = request.getParameter("checkedIds");    //获取前台隐藏域存着的选中的复选框的value
        String checkedIds[] = id.split(",");//进行分割存到数组
        agencyService.updateChecked(checkedIds, Content.CheckYes);
        result = ControllerResult.getSuccessResult("审核成功");
        return "checkChange";
    }

    // 显示被冻结的经销商
    public String agencyStatus() {
        agencyPager = new Pager<>();
        agencyPager.setPageSize(pageSize);
        if (pageNo < 1) {
            agencyPager.setPageNo(1);
        } else {
            agencyPager.setPageNo(pageNo);
        }
        agencyPager = agencyService.queryAllStatus(agencyPager,Content.StatusNo);
        return "agencyStatus";
    }
    public String agencyStatusPage(){
        return "agencyStatusPage";
    }

    // 把冻结的激活,可多选
    public String statusChange() {
        String id = request.getParameter("checkedIds");    //获取前台隐藏域存着的选中的复选框的value
        String checkedIds[] = id.split(",");//进行分割存到数组
        if(agency.getStatus() == 0) {
            agencyService.updateStatus(checkedIds, Content.StatusYes);
            result = ControllerResult.getSuccessResult("激活成功");
        } else if(agency.getStatus() == 1) {
            agencyService.updateStatus(checkedIds, Content.StatusNo);
            result = ControllerResult.getSuccessResult("冻结成功");
        }
        return "statusChange";
    }


    /**
     * 获取基本信息
     * @return
     */
    public String queryAgency(){
        HttpSession httpSession = request.getSession();
        if(httpSession.getAttribute("agency")!=null){
            agency = (Agency) httpSession.getAttribute("agency");
        }
        return "queryAgency";
    }

    /**
     * 修改密码
     * @return
     */
    public  String updatepwd(){

        return "updatepwd";
    }

    /**
     * 进入经销商个人信息页面
     * @param
     */
    public String AgencyMessage(){
        return "AgencyMessage";
        }

    /**
     * 保存修改的信息
     * @param
     */
    public String updateAgency(){
        HttpSession httpSession = request.getSession();
        if(httpSession.getAttribute("agency")!=null){
            Agency agency1 = (Agency) httpSession.getAttribute("agency");
            try {
                if(upload!=null&&!upload.equals("")){
                    if(agency1.getLogo()==null){
                        FileUtils.copyFile(upload, new File(FileUtil.uploadPath() + File.separator + uploadFileName));
                        agency.setLogo(FileUtil.UPLOADS+"/"+uploadFileName);
                    }else if(agency1.getLogo().equals(FileUtil.UPLOADS+"/"+uploadFileName)){
                        agency.setLogo(agency1.getLogo());
                    }else if(agency1.getLogo()!=null&&!agency1.getLogo().equals(FileUtil.UPLOADS+"/"+uploadFileName)){
                        if(agency1.getLogo().contains("public")){
                            FileUtils.copyFile(upload, new File(FileUtil.uploadPath() + File.separator + uploadFileName));
                            agency.setLogo(FileUtil.UPLOADS+"/"+uploadFileName);
                        }else {
                            FileUtil.removeFile(agency1.getLogo());
                            FileUtils.copyFile(upload, new File(FileUtil.uploadPath() + File.separator + uploadFileName));
                            agency.setLogo(FileUtil.UPLOADS+"/"+uploadFileName);
                        }
                    }
                }else {
                    agency.setLogo(agency.getLogo());
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
            agency.setId(agency1.getId());
            agencyService.updateAgency(agency);
            result = ControllerResult.getSuccessResult("修改成功");
            httpSession.setAttribute("agency",agency);
        }
        return "updateAgency";
    }

    /**
     *进入经销商个人中心页面
     * @return
     */
    public String Agency(){
        return "Agency";
    }

    /**
     * 进入登陆界面
     * @return
     */
    public String agencyloginpage(){
        return "agencyloginpage";
    }

    public String agencylogin(){
        Agency agency1 = agencyService.queryEmailPwd(agency.getEmail());
        if(agency1 == null){
            result = ControllerResult.getFailResult("用户名不存在");
        }else {
            if(agency1.getPwd().equals(EncriptUtil.md5(agency.getPwd()))) {
                HttpSession session = request.getSession();
                session.setAttribute("agency", agency1);
                result = ControllerResult.getSuccessResult("登入成功");
            }else {
                result = ControllerResult.getFailResult("你输入的密码错误");
            }
        }
        return "agencylogin";
    }

    //经销商详情
    public String agencyDetail(){
        agency=agencyService.queryById(agency.getId());
        return "agencyDetail";
    }
    //所有已审核已激活的经销商详情
    public String agencyDetailPage(){
        agency=agencyService.queryById(agency.getId());
        return "agencyDetailPage";
    }




    @Override
    public void setServletRequest(HttpServletRequest httpServletRequest) {
        this.request = httpServletRequest;
    }
}
