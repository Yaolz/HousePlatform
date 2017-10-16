package com.ht.service.impl;

import com.ht.bean.Appointment;
import com.ht.bean.Like;
import com.ht.common.Pager;
import com.ht.dao.AbstractBaseDAO;
import com.ht.dao.AppointmentDAO;
import com.ht.service.AppointmentService;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by CHEN JX on 2017/8/23.
 * 预约
 */
@Transactional
public class AppointmentServiceImpl extends AbstractBaseDAO implements AppointmentService {


    private AppointmentDAO appointmentDAO;

    public void setAppointmentDAO(AppointmentDAO appointmentDAO) {
        this.appointmentDAO = appointmentDAO;
    }

    @Override
    public Appointment queryById(String s) {
        return appointmentDAO.queryById(s);
    }

    @Override
    public void add(Appointment appointment) {
        appointmentDAO.add(appointment);
    }

    @Override
    public void remove(Appointment appointment) {
        appointmentDAO.remove(appointment);
    }

    @Override
    public void update(Appointment appointment) {
        appointmentDAO.update(appointment);
    }

    @Override
    public Pager<Appointment> queryPager(Pager<Appointment> pager) {
        return appointmentDAO.queryPager(pager);
    }

    @Override
    public List<Appointment> queryAll() {
        return appointmentDAO.queryAll();
    }

    @Override
    public int count() {
        return appointmentDAO.count();
    }

    @Override
    public Pager<Appointment> queryAllAppointment(Pager<Appointment> pager, String user_id) {
        return appointmentDAO.queryAllAppointment(pager,user_id);
    }

    @Override
    public Appointment queryAppointment(String user_id, String emp_id) {
        return appointmentDAO.queryAppointment(user_id,emp_id);
    }

    @Override
    public void updateAppStatus(Appointment appointment) {
        appointmentDAO.updateAppStatus(appointment);
    }

    //查询员工下的预约记录有多少个
    @Override
    public long countApp(String emp_id) {
        return appointmentDAO.countApp(emp_id);
    }

    //批量冻结或激活
    @Override
    public void updateStatus(String[] id, int status) {
        appointmentDAO.updateStatus(id,status);
    }

    @Override
    public long countAppointment(String user_id) {
         return appointmentDAO.countAppointment(user_id);
    }

    @Override
    public Pager<Appointment> queryPager(Pager<Appointment> pager, String emp_id) {
        return appointmentDAO.queryPager(pager,emp_id);
    }

    @Override
    public void updateAppointmentStatus(String id, int status) {
        appointmentDAO.updateAppointmentStatus(id,status);
    }

    @Override
    public Pager<Appointment> queryAllAppointmentAgency(Pager<Appointment> pager, String agency_id, int app_status, int status) {
        pager.setTotal(appointmentDAO.countAppointmentAgency(agency_id,app_status,status));
        return appointmentDAO.queryAllAppointmentAgency(pager,agency_id,app_status,status);
    }

    @Override
    public long countAppointmentAgency(String agency_id, int app_status, int status) {
        return appointmentDAO.countAppointmentAgency(agency_id,app_status,status);
    }
}
