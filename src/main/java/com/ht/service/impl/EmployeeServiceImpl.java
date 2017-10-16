package com.ht.service.impl;

import com.ht.bean.Employee;
import com.ht.common.Pager;
import com.ht.dao.EmployeeDAO;
import com.ht.service.EmployeeService;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by CHEN JX on 2017/8/23.
 * 员工
 */
@Transactional
public class EmployeeServiceImpl implements EmployeeService {
    private EmployeeDAO employeeDAO;

    public void setEmployeeDAO(EmployeeDAO employeeDAO) {
        this.employeeDAO = employeeDAO;
    }

    @Override
    public Employee queryById(String s) {
        return employeeDAO.queryById(s);
    }

    @Override
    public void add(Employee employee) {
        employeeDAO.add(employee);
    }

    @Override
    public void remove(Employee employee) {
        employeeDAO.remove(employee);
    }

    @Override
    public void update(Employee employee) {
        employeeDAO.update(employee);
    }

    @Override
    public Pager<Employee> queryPager(Pager<Employee> pager) {
        return employeeDAO.queryPager(pager);
    }

    @Override
    public List<Employee> queryAll() {
        return employeeDAO.queryAll();
    }

    @Override
    public int count() {
        return 0;
    }

    @Override
    public Employee queryByPwd(String email) {
        return employeeDAO.queryByPwd(email);
    }

    @Override
    public void updateEmployee(Employee employee) {
        employeeDAO.updateEmployee(employee);
    }

    @Override
    public Pager<Employee> queryAllEmployee(Pager<Employee> pager, String buildings_id) {
        return employeeDAO.queryAllEmployee(pager,buildings_id);
    }

    @Override
    public long countEmployee(String buildings_id) {
        return employeeDAO.countEmployee(buildings_id);
    }

    @Override
    public Pager<Employee> queryAllEmployeeStatus(Pager<Employee> pager, String buildings_id, int status) {
        return employeeDAO.queryAllEmployeeStatus(pager,buildings_id,status);
    }

    @Override
    public long countEmployeeStatus(String buildings_id, int status) {
        return employeeDAO.countEmployeeStatus(buildings_id,status);
    }

    @Override
    public void updateStatus(String[] id, int status) {
        employeeDAO.updateStatus(id,status);
    }

    @Override
    public void updateEmailPwd(String email, String pwd) {
        employeeDAO.updateEmailPwd(email,pwd);
    }

    @Override
    public Employee queryByPhone(String phone) {
        return employeeDAO.queryByPhone(phone);
    }

    @Override
    public Employee queryByName(String name) {
        return employeeDAO.queryByName(name);
    }

    @Override
    public Pager<Employee> queryAllEmployeeAgency(Pager<Employee> pager, String agency_id, int status) {
        return employeeDAO.queryAllEmployeeAgency(pager,agency_id,status);
    }

    @Override
    public long coutEmployeeAgency( String agency_id, int status) {
        return employeeDAO.coutEmployeeAgency(agency_id,status);
    }
}
