package com.ht.controller;

import com.ht.bean.Employee;
import com.ht.bean.Sale;
import com.ht.common.ControllerResult;
import com.ht.service.SaleService;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.interceptor.ServletRequestAware;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * 销售记录表
 * Created by ID.LQF on 2017/9/25.
 */
public class SaleAction extends ActionSupport implements ServletRequestAware {

    private ControllerResult result;
    private HttpServletRequest request;
    private SaleService saleService;
    private Sale sale;
    private Employee employee;

    private List<Sale> sales;

    public ControllerResult getResult() {
        return result;
    }

    public void setResult(ControllerResult result) {
        this.result = result;
    }

    public Sale getSale() {
        return sale;
    }

    public void setSale(Sale sale) {
        this.sale = sale;
    }

    public void setSaleService(SaleService saleService) {
        this.saleService = saleService;
    }

    public List<Sale> getSales() {
        return sales;
    }

    public void setSales(List<Sale> sales) {
        this.sales = sales;
    }

    public Employee getEmployee() {
        return employee;
    }

    public void setEmployee(Employee employee) {
        this.employee = employee;
    }

    //房屋销售图表查看
    public String saleChart(){
        HttpSession session = request.getSession();
        employee = (Employee)session.getAttribute("employee");
        sales = saleService.queryAllSale(employee.getId());
        return "saleChart";
    }

    @Override
    public void setServletRequest(HttpServletRequest httpServletRequest) {
        this.request = httpServletRequest;
    }
}
