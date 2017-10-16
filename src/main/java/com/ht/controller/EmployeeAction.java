package com.ht.controller;

import com.ht.bean.Agency;
import com.ht.bean.Employee;
import com.ht.bean.Role;
import com.ht.common.ControllerResult;
import com.ht.common.EncriptUtil;
import com.ht.common.Pager;
import com.ht.price.AgencyPrice;
import com.ht.price.BuildingsPrice;
import com.ht.service.EmployeeService;
import com.ht.util.FileUtil;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.commons.io.FileUtils;
import org.apache.struts2.interceptor.ServletRequestAware;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;

/**
 * Created by yao on 2017/9/13.
 */
public class EmployeeAction extends ActionSupport implements ServletRequestAware {
    private HttpServletRequest request;
    private EmployeeService employeeService;
    private ControllerResult controllerResult;
    private Employee employee;
    private AgencyPrice agencyPrice;
    private BuildingsPrice buildingsPrice;
    private int status;
    private String buildings_id;
    private String checkedIds[];
    private int updatestatus;

    public void setUpdatestatus(int updatestatus) {
        this.updatestatus = updatestatus;
    }

    public void setCheckedIds(String[] checkedIds) {
        this.checkedIds = checkedIds;
    }

    public void setBuildings_id(String buildings_id) {
        this.buildings_id = buildings_id;
    }
    public BuildingsPrice getBuildingsPrice() {
        return buildingsPrice;
    }

    public void setBuildingsPrice(BuildingsPrice buildingsPrice) {
        this.buildingsPrice = buildingsPrice;
    }

    public AgencyPrice getAgencyPrice() {
        return agencyPrice;
    }

    public void setAgencyPrice(AgencyPrice agencyPrice) {
        this.agencyPrice = agencyPrice;
    }

    private File upload; // 与form表单中file的name一致，temp文件， ROOT/upload_cc3fa222_9f87_4066_af9b_8b7f07e77389_00000000.tmp
    private String uploadFileName; // 此变量的名称固定为file的name + "FileName"

    public void setUpload(File upload) {
        this.upload = upload;
    }

    public void setUploadFileName(String uploadFileName) {
        this.uploadFileName = uploadFileName;
    }

    private Pager<Employee> employeePager;
    private int pageNo = 1;
    private int pageSize = 10;

    public Employee getEmployee() {
        return employee;
    }

    public void setEmployee(Employee employee) {
        this.employee = employee;
    }

    public ControllerResult getControllerResult() {
        return controllerResult;
    }

    public void setEmployeeService(EmployeeService employeeService) {
        this.employeeService = employeeService;
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

    public Pager<Employee> getEmployeePager() {
        return employeePager;
    }

    public void setEmployeePager(Pager<Employee> employeePager) {
        this.employeePager = employeePager;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    @Override
    public void setServletRequest(HttpServletRequest httpServletRequest) {
        this.request = httpServletRequest;
    }

    //添加员工
    public String addEmployee(){
        if(agencyPrice!=null&&buildingsPrice!=null){
            if(upload!=null){
                try {
                    FileUtils.copyFile(upload, new File(FileUtil.uploadPath() + File.separator + uploadFileName));
                    employee.setHeadicon(FileUtil.UPLOADS + "/" + uploadFileName);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }else {
                employee.setHeadicon("public/img/noimage.png");
            }
            employee.setPwd(EncriptUtil.md5("123456"));//默认给他设置密码为123456
            employee.setBuildingsPrice(buildingsPrice);
            employee.setAgencyPrice(agencyPrice);
            Role role = new Role();
            role.setId("d7227c6487f411e7a5142c56dc7febbc");
            employee.setRole(role);
            if(employee.getGender().equals("")||employee.getGender() ==null){
                employee.setGender("男");
            }
            employee.setStatus(1);
            employeeService.add(employee);
            controllerResult=ControllerResult.getSuccessResult("添加成功！密码默认为123456");
        }else {
            controllerResult = ControllerResult.getFailResult("添加失败");
        }
        return"addEmployee";
    }
    public String addEmployeePage(){
        return "addEmployeePage";
    }
    //所有员工信息
    public String allEmployee(){
        employeePager = new Pager<Employee>();
        employeePager.setPageSize(pageSize);
        if (pageNo < 1) {
            employeePager.setPageNo(1);
        } else {
            employeePager.setPageNo(pageNo);
        }
        employeePager =employeeService .queryPager(employeePager);
        return "allEmployee";
    }
    public String allEmployeePage(){
        return "allEmployeePage";
    }

    //员工分页
    public String pagerByStatus(){
        employeePager = new Pager<Employee>();
        employeePager.setPageSize(pageSize);
        HttpSession session = request.getSession();
        if(session.getAttribute("agency")!=null){
            Agency agency = (Agency) session.getAttribute("agency");
            if (pageNo < 1) {
                employeePager.setPageNo(1);
            } else {
                employeePager.setPageNo(pageNo);
            }
            if(status < 2&&!buildings_id.equals("所有楼盘")){
                employeePager =employeeService .queryAllEmployeeStatus(employeePager,buildings_id,status);
            }else if(status>1&&!buildings_id.equals("所有楼盘")){
                employeePager =employeeService .queryAllEmployee(employeePager,buildings_id);
            }else if(buildings_id.equals("所有楼盘")){
                employeePager = employeeService.queryAllEmployeeAgency(employeePager,agency.getId(),status);
            }
        }
        return "pagerByStatus";
    }
    //修改状态
    public String status(){
        //checkedIds获取前台隐藏域存着的选中的复选框的value
        employeePager = new Pager<Employee>();
        employeePager.setPageSize(pageSize);
        HttpSession session = request.getSession();
        if(session.getAttribute("agency")!=null){
            Agency agency = (Agency) session.getAttribute("agency");
            if(updatestatus<2&&checkedIds!=null&&checkedIds.length>0){
                employeeService.updateStatus(checkedIds,updatestatus);
            }else {
                controllerResult = ControllerResult.getFailResult("服务器繁忙");
                return "status";
            }
            if (pageNo < 1) {
                employeePager.setPageNo(1);
            } else {
                employeePager.setPageNo(pageNo);
            }
            if(status < 2&&!buildings_id.equals("所有楼盘")){
                employeePager =employeeService .queryAllEmployeeStatus(employeePager,buildings_id,status);
                if(employeePager.getResult()==null||employeePager.getResult().size()<1){
                    employeePager.setPageNo(employeePager.getPageNo()-1);
                    employeePager =employeeService .queryAllEmployeeStatus(employeePager,buildings_id,status);
                }
            }else if(status>1&&!buildings_id.equals("所有楼盘")){
                employeePager =employeeService .queryAllEmployee(employeePager,buildings_id);
                if(employeePager.getResult()==null||employeePager.getResult().size()<1){
                    employeePager.setPageNo(employeePager.getPageNo()-1);
                    employeePager =employeeService .queryAllEmployee(employeePager,buildings_id);
                }
            }else if(buildings_id.equals("所有楼盘")){
                employeePager = employeeService.queryAllEmployeeAgency(employeePager,agency.getId(),status);
                if(employeePager.getResult()==null||employeePager.getResult().size()<1){
                    employeePager.setPageNo(employeePager.getPageNo()-1);
                    employeePager = employeeService.queryAllEmployeeAgency(employeePager,agency.getId(),status);
                }
            }
            if(updatestatus==0){
                controllerResult=ControllerResult.getSuccessResult("冻结成功");
            }else if(updatestatus==1) {
                controllerResult=ControllerResult.getSuccessResult("激活成功");
            }
        }else {
            controllerResult = ControllerResult.getFailResult("服务器繁忙");
        }
        return "status";
    }
    //修改员工
    public String employeeChange(){
        if(upload!=null){
            try {
                FileUtils.copyFile(upload, new File(FileUtil.uploadPath() + File.separator + uploadFileName));
                employee.setHeadicon(FileUtil.UPLOADS+"/"+uploadFileName);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        employeeService.updateEmployee(employee);
        controllerResult=ControllerResult.getSuccessResult("修改成功！");
        return "employeeChange";
    }
    //首页显示员工
    public String indexEmployee(){
        employeePager = new Pager<>();
        employeePager.setPageSize(pageSize);
        if (pageNo < 1) {
            employeePager.setPageNo(1);
        } else {
            employeePager.setPageNo(pageNo);
        }
        employeePager=employeeService.queryAllEmployeeStatus(employeePager,buildings_id,1);
        return "indexEmployee";
    }
    //显示某楼盘下的员工
    public String navEmployeePage(){
        return "navEmployeePage";
    }

}
