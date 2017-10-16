package com.ht.controller;

import com.ht.bean.*;
import com.ht.common.Content;
import com.ht.common.ControllerResult;
import com.ht.common.Pager;
import com.ht.price.AgencyPrice;
import com.ht.price.EmployeePrice;
import com.ht.service.AppointmentService;
import com.ht.service.CustomerService;
import com.ht.service.SaleService;
import com.ht.service.impl.SaleServiceImpl;
import com.ht.util.FileUtil;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.commons.io.FileUtils;
import org.apache.struts2.interceptor.ServletRequestAware;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * Created by ID.LQF on 2017/8/30.
 */
public class CustomerAction extends ActionSupport implements ServletRequestAware{

    private HttpServletRequest request;
    private ControllerResult result;
    private CustomerService customerService;
    private SaleService saleService;
    private AppointmentService appointmentService;
    private Customer customer;
    private Sale sale;
    private Appointment appointment;
    private Employee employee;

    private File upload; // 与form表单中file的name一致，temp文件， ROOT/upload_cc3fa222_9f87_4066_af9b_8b7f07e77389_00000000.tmp
    private File upload1;
    private String uploadFileName; // 此变量的名称固定为file的name + "FileName"
    private String upload1FileName; // 此变量的名称固定为file的name + "FileName"

    private List<Appointment> appointments;
    private Pager<Customer> cusPager;
    private String category_id;
    private Long total;
    private int totalPage;
    private int pageSize = 5;
    private int pageNo = 1;
    private Agency agency;
    private int status;
    private String buildings_id;
    private String checkedIds[];
    private int updatestatus;

    public void setBuildings_id(String buildings_id) {
        this.buildings_id = buildings_id;
    }

    public void setCheckedIds(String[] checkedIds) {
        this.checkedIds = checkedIds;
    }

    public void setUpdatestatus(int updatestatus) {
        this.updatestatus = updatestatus;
    }

    public ControllerResult getResult() {
        return result;
    }

    public void setResult(ControllerResult result) {
        this.result = result;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public void setCustomerService(CustomerService customerService) {
        this.customerService = customerService;
    }

    public void setAppointmentService(AppointmentService appointmentService) {
        this.appointmentService = appointmentService;
    }

    public void setSaleService(SaleService saleService) {
        this.saleService = saleService;
    }

    public Sale getSale() {
        return sale;
    }

    public void setSale(Sale sale) {
        this.sale = sale;
    }

    public Appointment getAppointment() {
        return appointment;
    }

    public void setAppointment(Appointment appointment) {
        this.appointment = appointment;
    }

    public Employee getEmployee() {
        return employee;
    }

    public void setEmployee(Employee employee) {
        this.employee = employee;
    }

    public Pager<Customer> getCusPager() {
        return cusPager;
    }

    public void setCusPager(Pager<Customer> cusPager) {
        this.cusPager = cusPager;
    }

    public String getCategory_id() {
        return category_id;
    }

    public void setCategory_id(String category_id) {
        this.category_id = category_id;
    }

    public List<Appointment> getAppointments() {
        return appointments;
    }

    public void setAppointments(List<Appointment> appointments) {
        this.appointments = appointments;
    }

    public Long getTotal() {
        return total;
    }

    public void setTotal(Long total) {
        this.total = total;
    }

    public int getTotalPage() {
        return totalPage;
    }

    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getPageNo() {
        return pageNo;
    }

    public void setPageNo(int pageNo) {
        this.pageNo = pageNo;
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

    public String getUpload1FileName() {
        return upload1FileName;
    }

    public void setUpload1FileName(String upload1FileName) {
        this.upload1FileName = upload1FileName;
    }

    public File getUpload1() {
        return upload1;
    }

    public void setUpload1(File upload1) {
        this.upload1 = upload1;
    }

    public Agency getAgency() {
        return agency;
    }

    public void setAgency(Agency agency) {
        this.agency = agency;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    //客户的添加  url：cus/add
    public String add(){
        HttpSession session = request.getSession();
        Agency agency =null;
        Employee employee = null;
        if(session.getAttribute("agency")!=null){
            agency = (Agency) session.getAttribute("agency");
            AgencyPrice agencyPrice = new AgencyPrice();
            agencyPrice.setId(agency.getId());
            customer.setAgencyPrice(agencyPrice);
        }
        if(session.getAttribute("employee")!=null){
            employee = (Employee) session.getAttribute("employee");
            AgencyPrice agencyPrice = new AgencyPrice();
            agencyPrice.setId(employee.getAgencyPrice().getId());
            customer.setAgencyPrice(agencyPrice);
            EmployeePrice employeePrice = new EmployeePrice();
            employeePrice.setId(employee.getId());
            customer.setEmployeePrice(employeePrice);
        }
        customer.setCreated_time(Calendar.getInstance().getTime());
        customerService.add(customer);
        result = ControllerResult.getSuccessResult("添加成功");
        return "add";
    }

    //经销商员工的个人中心页面中添加客户后的页面跳转操作 url：cus/cusCheck
    public String cusCheck(){
        return "cusCheck";
    }

    //查看客户资料页面中的点击查看详情后的页面跳转  url：cus/cusSingleCheck
    public String cusSingleCheck(){
        HttpSession session = request.getSession();
        String id = (String) session.getAttribute("id");
        customer = customerService.queryById(id);
        session.setAttribute("cus",customer);
        result = ControllerResult.getSuccessResult("跳转成功");
        return "cusSingleCheck";
    }


    //客户修改资料后的保存操作 url：cus/cusSave
    public String cusSave(){
        customerService.updateCustomer(customer);
        result = ControllerResult.getSuccessResult("修改成功");
        return "cusSave";
    }

    //客户的冻结和激活操作 url：cus/status
    public String status(){
        String[] id = new String[10];
        id[0]= customer.getId();
        if (customer.getStatus() == 0) {
            customerService.updateStatus(id, Content.StatusYes);
        } else if (customer.getStatus() == 1) {
            customerService.updateStatus(id, Content.StatusNo);
        }
        return "status";
    }

    //客户页面返回的json信息  url：staff/cusCheckJson
    public String cusCheckJson(){
        HttpSession session = request.getSession();
        cusPager = new Pager<>();
        cusPager.setPageSize(10);
        if (pageNo < 1) {
            cusPager.setPageNo(1);
        } else {
            cusPager.setPageNo(pageNo);
        }
        if(session.getAttribute("employee")!=null){
            Employee employee = (Employee)session.getAttribute("employee");
            cusPager = customerService.queryCustomer(cusPager,employee.getId());
        }else if(session.getAttribute("agency")!=null){
            Agency agency1 = (Agency)session.getAttribute("agency");
            if(!buildings_id.equals("所有楼盘")){
                cusPager =customerService .queryBuildingsCustomer(cusPager,buildings_id,status);
            }else if(buildings_id.equals("所有楼盘")){
                cusPager = customerService.queryCustomerStatusAgency(cusPager, agency1.getId(),status);
            }
        }
        return "cusCheckJson";
    }

    //批量冻结或激活客户
    public String updateStatus(){
        HttpSession session = request.getSession();
        cusPager = new Pager<>();
        cusPager.setPageSize(10);
        if (pageNo < 1) {
            cusPager.setPageNo(1);
        } else {
            cusPager.setPageNo(pageNo);
        }
        if(updatestatus<2&&checkedIds!=null&&checkedIds.length>0){
            customerService.updateStatus(checkedIds,updatestatus);
        }else {
            result = ControllerResult.getFailResult("服务器繁忙");
            return "updateStatus";
        }
        if(updatestatus==1){
            result = ControllerResult.getSuccessResult("激活成功!");
        }else {
            result = ControllerResult.getSuccessResult("冻结成功!");
        }
        if(session.getAttribute("agency")!=null){
            Agency agency1 = (Agency)session.getAttribute("agency");
            if(!buildings_id.equals("所有楼盘")){
                cusPager =customerService .queryBuildingsCustomer(cusPager,buildings_id,status);
                if(cusPager.getResult()==null||cusPager.getResult().size()<1){
                    cusPager.setPageNo(cusPager.getPageNo()-1);
                    cusPager =customerService .queryBuildingsCustomer(cusPager,buildings_id,status);
                }
            }else if(buildings_id.equals("所有楼盘")){
                cusPager = customerService.queryCustomerStatusAgency(cusPager, agency1.getId(),status);
                if(cusPager.getResult()==null||cusPager.getResult().size()<1){
                    cusPager.setPageNo(cusPager.getPageNo()-1);
                    cusPager = customerService.queryCustomerStatusAgency(cusPager, agency1.getId(),status);
                }
            }
        } else {
            result = ControllerResult.getFailResult("服务器繁忙，请稍候在尝试!");
        }
        return "updateStatus";
    }

    //销售记录的状态的冻结和激活  url: cus/saleStatus
    public String saleStatus(){
        String[] id = new String[10];
        id[0]= sale.getId();
        if (sale.getStatus() == 0) {
            saleService.updateStatus(id, Content.StatusYes);
        } else if (sale.getStatus() == 1) {
            saleService.updateStatus(id, Content.StatusNo);
        }
        return "saleStatus";
    }

    //购房预约查看中预约状态的冻结和激活
    public String appStatus(){
        String[] id = new String[10];
        id[0]= appointment.getId();
        if (appointment.getStatus() == 0) {
            appointmentService.updateStatus(id, Content.StatusYes);
        } else if (appointment.getStatus() == 1) {
            appointmentService.updateStatus(id, Content.StatusNo);
        }
        return "appStatus";
    }


    //修改状态成功后的页面跳转
    public String appoint(){
        return "appoint";
    }

    //修改销售记录时的页面跳转  url: cus/sellRecord
    public String sellRecord(){
        return "sellRecord";
    }

    //根据经销商页面提供的id查出客户的信息 url：cus/queryCustomer
    public String queryCustomer(){
        String cus_id = request.getParameter("id");
        customer = customerService.queryById(cus_id);
        return "queryCustomer";
    }

    //销售记录的信息修改  url: cus/sellSave
    public String sellSave(){
        saleService.updateSale(sale);
        result = ControllerResult.getSuccessResult("修改成功");
        return "sellSave";
    }

    //添加电子版购房合同路径 url：cus/contract
    public String contract(){
        HttpSession httpSession = request.getSession();
        if(httpSession.getAttribute("employee")!=null||httpSession.getAttribute("agency")!=null){
            Customer customer1 = customerService.queryById(customer.getId());
            try {
                if(upload!=null&&!upload.equals("")){
                    if(customer1.getContract()==null){
                        FileUtils.copyFile(upload, new File(FileUtil.frequencyPath() + File.separator + uploadFileName));
                        customer.setContract(uploadFileName);
                    }else if(customer1.getContract().equals(uploadFileName)){
                        customer.setContract(customer1.getContract());
                    }else if(customer1.getContract()!=null&&!customer1.getContract().equals(uploadFileName)){
                        FileUtil.removeFile(FileUtil.FREQUENCY+"/"+customer1.getContract());
                        FileUtils.copyFile(upload, new File(FileUtil.frequencyPath() + File.separator + uploadFileName));
                        customer.setContract(uploadFileName);
                    }
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
            customerService.updateContract(customer.getId(),customer.getContract());
            result = ControllerResult.getSuccessResult("上传成功");
        }
        return "contract";
    }

    //添加zip版电子档案路径 url：cus/archives
    public String archives(){
        HttpSession httpSession = request.getSession();
        if(httpSession.getAttribute("employee")!=null||httpSession.getAttribute("agency")!=null){
            customer.setId(customer.getId());
            Customer customer2 = customerService.queryById(customer.getId());
            try {
                if(upload1!=null&&!upload1.equals("")){
                    if(customer2.getArchives()==null){
                        FileUtils.copyFile(upload1, new File(FileUtil.frequencyPath() + File.separator + upload1FileName));
                        customer.setArchives(upload1FileName);
                    }else if(customer2.getArchives().equals(upload1FileName)){
                        customer.setArchives(customer2.getArchives());
                    }else if(customer2.getArchives()!=null&&!customer2.getArchives().equals(upload1FileName)){
                        FileUtil.removeFile(FileUtil.FREQUENCY+"/"+customer2.getArchives());
                        FileUtils.copyFile(upload1, new File(FileUtil.frequencyPath() + File.separator + upload1FileName));
                        customer.setArchives(upload1FileName);
                    }
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        customerService.updateArchives(customer.getId(),customer.getArchives());
        result = ControllerResult.getSuccessResult("上传成功");
        return "archives";
    }




    /**
     * 经销商添加客户
     * @return
     */
    public String agencyaddcustomerpage(){
        return "agencyaddcustomerpage";
    }

    //经销商用选择状态显示客户信息
    public String pagerByStatus() {
        HttpSession session = request.getSession();
            cusPager = new Pager<>();
            cusPager.setPageSize(pageSize);
            if (session.getAttribute("agency") != null) {
                Agency agency = (Agency) session.getAttribute("agency");
                if (pageNo < 1) {
                    cusPager.setPageNo(1);
                } else {
                    cusPager.setPageNo(pageNo);
                }
                if(status==1){
                    cusPager = customerService.queryCustomerStatusAgency(cusPager, agency.getId(),1);
                }else if(status==0){
                    cusPager = customerService.queryCustomerStatusAgency(cusPager, agency.getId(),0);
                }else{
                    cusPager = customerService.pagerByBuildings(cusPager,agency.getId());
                }

            }
        return "pagerByStatus";
    }
    //客户信息页面
    public String customerPage(){
        return "customerPage";
    }

    @Override
    public void setServletRequest(HttpServletRequest httpServletRequest) {
        this.request = httpServletRequest;
    }
}
