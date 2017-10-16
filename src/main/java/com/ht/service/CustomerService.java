package com.ht.service;

import com.ht.bean.Customer;
import com.ht.common.Pager;

/**
 * Created by ID.LQF on 2017/8/30.
 */
public interface CustomerService extends BaseService<String ,Customer> {

    Pager<Customer> queryCustomer(Pager<Customer> pager,String emp_id);//分页查询员工添加的客户

    long countCustomer(String emp_id);//查询员工添加的客户有多少个

    Pager<Customer> queryCustomerStatus(Pager<Customer> pager,String emp_id,int status);//分页查询员工添加的被冻结或激活的客户

    long countCustomerStatus(String emp_id,int status);//查询员工添加的被冻结或激活的客户有多少个

    void updateStatus(String[] id,int status);//批量冻结或激活

    void updateCustomer(Customer customer);//修改客户信息

    void updateContract(String id,String contract);//给客户上传电子版购房合同路径

    void updateArchives(String id,String archives);//给客户上传zip版电子档案路径

    Pager<Customer> pagerByBuildings(Pager<Customer> pager,String buildings_id);

    long NuCustomer(String buildings_id);

    Pager<Customer> queryBuildingsCustomer(Pager<Customer> pager,String buildings_id,int status);//分页查询楼盘下被冻结或激活的客户

    long countBuildingsCustomer(String buildings_id,int status);//查询楼盘下被冻结或激活的客户有多少个

    Pager<Customer> queryCustomerStatusAgency(Pager<Customer> pager,String age_id,int status);//分页查询经销商下被冻结或激活的客户

    long countCustomerStatusAgency(String age_id,int status);//查询经销商添加的被冻结或激活的客户有多少个
}
