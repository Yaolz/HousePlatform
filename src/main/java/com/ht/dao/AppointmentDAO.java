package com.ht.dao;

import com.ht.bean.Appointment;
import com.ht.bean.Employee;
import com.ht.bean.Like;
import com.ht.common.Pager;

/**
 * Created by CHEN JX on 2017/8/23.
 * 预约
 */
public interface AppointmentDAO extends BaseDAO<String,Appointment> {

    Pager<Appointment> queryPager(Pager<Appointment> pager,String emp_id);//分页查询某个员工下的预约记录

    Appointment queryAppointment(String user_id,String emp_id);//根据用户id和员工id来获取预约记录

    void updateAppStatus(Appointment appointment); //根据id来修改预约

    long countApp(String emp_id);//查询员工下的预约记录有多少个

    void updateStatus(String[] id,int status);//批量冻结或激活

    Pager<Appointment> queryAllAppointment(Pager<Appointment> pager, String user_id);//分页查询某个用户下的预约记录

    long countAppointment(String user_id);//查询某个用户下的预约记录有多少个

    Pager<Appointment> queryAllAppointment
    (Pager<Appointment> pager, String user_id ,String status);//分页查询某个用户下的预约记录 app_status表示预约状态 status表示是否冻结或激活

    long countAppointment(String user_id,String status);//查询某个用户下的预约记录有多少个

    Pager<Appointment> queryAllAppointmentEmp
    (Pager<Appointment> pager, String emp_id,String app_status ,String status);//分页查询某个员工下的预约表 app_status表示预约状态 status表示是否冻结或激活

    long countAppointmentEmp(String emp_id,String app_status ,String status);//查询某个员工下的预约记录有多少个

    Pager<Appointment> queryAllAppointmentAgency
    (Pager<Appointment> pager,String agency_id,int app_status ,int status);//分页查询某个经销商的预约表信息 app_status表示预约状态 status表示是否冻结或激活

    long countAppointmentAgency(String agency_id,int app_status ,int status);//查询某个经销商的预约记录有多少个

    void updateAppointmentStatus(String id,int status);//根据id来修改状态
}


