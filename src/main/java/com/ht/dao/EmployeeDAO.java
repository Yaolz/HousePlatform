package com.ht.dao;

import com.ht.bean.Employee;
import com.ht.common.Pager;
import com.ht.price.EmployeePrice;
import com.ht.price.UserPrice;

/**
 * Created by CHEN JX on 2017/8/23.
 * 员工表
 */
public interface EmployeeDAO extends BaseDAO<String, Employee>{

    Employee queryByPwd(String email);//根据邮箱查询信息

    void  updateEmployee(Employee employee);//修改员工信息

    Pager<Employee> queryAllEmployee(Pager<Employee> pager,String buildings_id);//分页查询某个楼盘下工作的员工

    long countEmployee(String buildings_id);//查询某个楼盘下工作的员工有多少个

    Pager<Employee> queryAllEmployeeStatus(Pager<Employee> pager,String buildings_id,int status);//分页查询某个楼盘下被冻结或激活的员工

    long countEmployeeStatus(String buildings_id,int status);//查询某个楼盘下被冻结或激活的员工有多少个

    void updateStatus(String[] id,int status);//批量冻结或激活

    void updateEmailPwd(String  email,String  pwd);//修改密码

    Employee queryByPhone(String phone);//根据手机查询账户是否存在

    Employee queryByName(String name);//根据名称查询账户是否存在

    Pager<Employee> queryAllEmployeeAgency(Pager<Employee> pager,String agency_id,int status);//分页查询所有楼盘的员工有多少个

    long coutEmployeeAgency(String agency_id,int status);//查询所有楼盘下的员工有多少个

//    Pager<EmployeePrice> queryAllEmployeePriceAgency(Pager<EmployeePrice> pager,String agency_id,int status);//分页查询所有楼盘的员工有多少个
//
//    long coutEmployeePriceAgency(String agency_id,int status);//查询所有楼盘下的员工有多少个
}
