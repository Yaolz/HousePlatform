package com.ht.service.impl;

import com.ht.bean.Customer;
import com.ht.common.Pager;
import com.ht.dao.CustomerDAO;
import com.ht.service.CustomerService;

import java.util.List;

/**
 * Created by ID.LQF on 2017/8/30.
 */
public class CustomerServiceImpl implements CustomerService {

    private CustomerDAO customerDAO;

    public void setCustomerDAO(CustomerDAO customerDAO) {
        this.customerDAO = customerDAO;
    }

    @Override
    public Customer queryById(String id) {
        return customerDAO.queryById(id);
    }

    @Override
    public void add(Customer customer) {
        customerDAO.add(customer);
    }

    @Override
    public void remove(Customer customer) {
        customerDAO.remove(customer);
    }

    @Override
    public void update(Customer customer) {
        customerDAO.update(customer);
    }

    @Override
    public Pager<Customer> queryPager(Pager<Customer> pager) {
        return customerDAO.queryPager(pager);
    }


    @Override
    public List<Customer> queryAll() {
        return customerDAO.queryAll();
    }

    @Override
    public int count() {
        return customerDAO.count();
    }

    @Override
    public Pager<Customer> queryCustomer(Pager<Customer> pager, String emp_id) {
        return customerDAO.queryCustomer(pager,emp_id);
    }

    @Override
    public long countCustomer(String emp_id) {
        return customerDAO.countCustomer(emp_id);
    }

    @Override
    public Pager<Customer> queryCustomerStatus(Pager<Customer> pager, String emp_id, int status) {
        return customerDAO.queryCustomerStatus(pager,emp_id,status);
    }

    @Override
    public long countCustomerStatus(String emp_id, int status) {
        return customerDAO.countCustomerStatus(emp_id,status);
    }

    @Override
    public void updateStatus(String[] id, int status) {
        customerDAO.updateStatus(id,status);
    }

    @Override
    public void updateCustomer(Customer customer) {
        customerDAO.updateCustomer(customer);
    }

    @Override
    public void updateContract(String id, String contract) {
        customerDAO.updateContract(id,contract);
    }

    @Override
    public void updateArchives(String id, String archives) {
        customerDAO.updateArchives(id,archives);
    }

    @Override
    public long countCustomerStatusAgency(String age_id, int status) {
        return customerDAO.countCustomerStatusAgency(age_id,status);
    }

    @Override
    public Pager<Customer> queryCustomerStatusAgency(Pager<Customer> pager, String age_id, int status) {
        pager.setTotal(customerDAO.countCustomerStatusAgency(age_id,status));
        return customerDAO.queryCustomerStatusAgency(pager,age_id,status);
    }

    @Override
    public Pager<Customer> pagerByBuildings(Pager<Customer> pager, String buildings_id) {
        return customerDAO.pagerByBuildings(pager,buildings_id);
    }

    @Override
    public long NuCustomer(String buildings_id) {
        return customerDAO.NuCustomer(buildings_id);
    }

    @Override
    public Pager<Customer> queryBuildingsCustomer(Pager<Customer> pager, String buildings_id, int status) {
        customerDAO.countBuildingsCustomer(buildings_id,status);
        return customerDAO.queryBuildingsCustomer(pager,buildings_id,status);
    }

    @Override
    public long countBuildingsCustomer(String buildings_id, int status) {
        return customerDAO.countBuildingsCustomer(buildings_id,status);
    }
}
