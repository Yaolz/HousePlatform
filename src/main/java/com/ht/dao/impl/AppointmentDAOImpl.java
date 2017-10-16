package com.ht.dao.impl;

import com.ht.bean.Appointment;
import com.ht.bean.Employee;
import com.ht.bean.Like;
import com.ht.common.Pager;
import com.ht.dao.AbstractBaseDAO;
import com.ht.dao.AppointmentDAO;
import org.hibernate.Session;
import org.hibernate.query.Query;

import java.util.List;

/**
 * Created by CHEN JX on 2017/8/23.
 * 预约
 */
public class AppointmentDAOImpl extends AbstractBaseDAO implements AppointmentDAO {
    @Override
    public Appointment queryById(String s) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Appointment  where id = :id ");
        query.setParameter("id",s);
        Object obj = query.uniqueResult(); // 返回单个结果
        return obj != null ? (Appointment) obj : null;
    }

    @Override
    public void add(Appointment appointment) {
        getSessionFactory().getCurrentSession().save(appointment);
    }

    @Override
    public void remove(Appointment appointment) {
        getSessionFactory().getCurrentSession().remove(appointment);
    }

    @Override
    public void update(Appointment appointment) {
        getSessionFactory().getCurrentSession().update(appointment);
    }

    @Override
    public Pager<Appointment> queryPager(Pager<Appointment> pager) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Appointment order by created_time desc");
        query.setFirstResult(pager.getIndex());
        query.setMaxResults(pager.getPageSize());
        pager.setResult(query.list());
        return pager;
    }

    @Override
    public List<Appointment> queryAll() {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Appointment order by created_time desc");
        List<Appointment> list = query.list();
        return list;
    }

    @Override
    public int count() {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("select  count(id) from Appointment");
        Long longStr = (Long) query.uniqueResult();
        int count = longStr.intValue();
        return count;
    }

    //分页查询某个员工下的预约记录
    @Override
    public Pager<Appointment> queryPager(Pager<Appointment> pager, String emp_id) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Appointment where emp_id = :emp_id order by created_time desc");
        query.setParameter("emp_id",emp_id);
        query.setFirstResult(pager.getIndex());
        query.setMaxResults(pager.getPageSize());
        List<Appointment> appointments = query.list();
        pager.setResult(appointments);
        pager.setTotal(countApp(emp_id));
        return pager;
    }

    @Override
    public Appointment queryAppointment(String user_id, String emp_id) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Appointment where userPrice.id = :user_id and employeePrice.id = :emp_id");
        query.setParameter("user_id",user_id);
        query.setParameter("emp_id",emp_id);
        Object obj = query.uniqueResult(); // 返回单个结果
        return obj != null ? (Appointment) obj : null;
    }

    //根据id来修改预约状态
    @Override
    public void updateAppStatus(Appointment appointment) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("update Appointment set app_status = :app_status,arrive_time = :arrive_time where id in (:id)");
        query.setParameter("app_status", appointment.getApp_status());
        query.setParameter("arrive_time", appointment.getArrive_time());
        query.setParameter("id", appointment.getId());
        query.executeUpdate();
    }

    //查询员工下的预约记录有多少个
    @Override
    public long countApp(String emp_id) {
        Session session = getSessionFactory().getCurrentSession();
        Query query =session.createQuery
                ("select count(id) from Appointment s where s.employeePrice.id = :emp_id");
        query.setParameter("emp_id",emp_id);
        return (Long) query.uniqueResult();
    }

    //批量冻结或激活
    @Override
    public void updateStatus(String[] id, int status) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("update Appointment set status = :status  where   id  in  (:id)");
        query.setParameter("status", status);
        query.setParameterList("id", id);
        query.executeUpdate();
    }

    @Override//分页查询某个用户下的预约记录
    public Pager<Appointment> queryAllAppointment(Pager<Appointment> pager, String user_id) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Appointment  l where  l.userPrice.id = :user_id order by created_time desc ");
        query.setParameter("user_id", user_id);
        query.setMaxResults(pager.getPageSize()); // 每页显示的个数
        query.setFirstResult(pager.getIndex());//当前页
        List<Appointment> appointments = query.list();
        pager.setResult(appointments);
        pager.setTotal(countAppointment(user_id));
        return pager;
    }

    @Override//查询某个用户下的预约记录有多少个
    public long countAppointment(String user_id) {
        Session session = getSessionFactory().getCurrentSession();
        Query query =session.createQuery
                ("select count(id) from Appointment   b  where  b.userPrice.id = :user_id ");
        query.setParameter("user_id",user_id);
        return (Long) query.uniqueResult();
    }

    @Override//分页查询某个用户下的预约记录 app_status表示预约状态 status表示是否冻结或激活
    public Pager<Appointment> queryAllAppointment(Pager<Appointment> pager, String user_id, String status) {
        Session session = getSessionFactory().getCurrentSession();
        String  hql = "from Appointment  l where  l.userPrice.id = :user_id order by created_time desc ";
        if(status!=null&&!status.equals("")){
            hql = "from Appointment  l where  l.userPrice.id = :user_id  and status = :status order by created_time desc";
        }
        Query query = session.createQuery(hql);
        query.setParameter("user_id", user_id);
        if(status!=null&&!status.equals("")){
            query.setParameter("status", status);
        }
        query.setMaxResults(pager.getPageSize()); // 每页显示的个数
        query.setFirstResult(pager.getIndex());//当前页
        List<Appointment> appointments = query.list();
        pager.setResult(appointments);
        pager.setTotal(countAppointment(user_id,status));
        return pager;
    }

    @Override//查询某个用户下的预约记录有多少个
    public long countAppointment(String user_id, String status) {
        Session session = getSessionFactory().getCurrentSession();
        String hql = "select count(id) from Appointment   b  where  b.userPrice.id = :user_id ";
        if(status!=null&&!status.equals("")){
            hql = "select count(id) from Appointment   b  where  b.userPrice.id = :user_id and status = :status";
        }
        Query query =session.createQuery(hql);
        query.setParameter("user_id",user_id);
        if(status!=null&&!status.equals("")){
            query.setParameter("status", status);
        }
        return (Long) query.uniqueResult();
    }

    @Override//分页查询某个员工下的预约表 app_status表示预约状态 status表示是否冻结或激活
    public Pager<Appointment> queryAllAppointmentEmp(Pager<Appointment> pager, String emp_id, String app_status, String status) {
        Session session = getSessionFactory().getCurrentSession();
        String  hql = "from Appointment  l where  l.employeePrice.id = :emp_id order by created_time desc ";
        if(app_status!=null&&!app_status.equals("")&&status==null||status.equals("")){
            hql = "from Appointment  l where  l.employeePrice.id = :emp_id  and app_status = :app_status order by created_time desc";
        }else if(status!=null&&!status.equals("")&&app_status==null||app_status.equals("")){
            hql = "from Appointment  l where  l.employeePrice.id = :emp_id  and status = :status order by created_time desc";
        }else if(status!=null&&!status.equals("")&&app_status!=null&&!app_status.equals("")){
            hql = "from Appointment  l where  l.employeePrice.id = :emp_id  and app_status = :app_status  and status = :status order by created_time desc";
        }
        Query query = session.createQuery(hql);
        query.setParameter("emp_id", emp_id);
        if(app_status!=null&&!app_status.equals("")&&status==null||status.equals("")){
            query.setParameter("app_status", app_status);
        }else if(status!=null&&!status.equals("")&&app_status==null||app_status.equals("")){
            query.setParameter("status", status);
        }else if(status!=null&&!status.equals("")&&app_status!=null&&!app_status.equals("")){
            query.setParameter("status", status);
            query.setParameter("app_status", app_status);
        }
        query.setMaxResults(pager.getPageSize()); // 每页显示的个数
        query.setFirstResult(pager.getIndex());//当前页
        List<Appointment> appointments = query.list();
        pager.setResult(appointments);
        pager.setTotal(countAppointmentEmp(emp_id,app_status,status));
        return pager;
    }

    @Override//查询某个员工下的预约记录有多少个
    public long countAppointmentEmp(String emp_id, String app_status, String status) {
        Session session = getSessionFactory().getCurrentSession();
        String hql = "select count(id) from Appointment   b  where  b.employeePrice.id = :emp_id ";
        if(app_status!=null&&!app_status.equals("")&&status==null||status.equals("")){
            hql = "select count(id) from Appointment   b  where  b.employeePrice.id = :emp_id  and app_status = :app_status";
        }else if(status!=null&&!status.equals("")&&app_status==null||app_status.equals("")){
            hql = "select count(id) from Appointment   b  where  b.employeePrice.id = :emp_id and status = :status";
        }else if(status!=null&&!status.equals("")&&app_status!=null&&!app_status.equals("")){
            hql = "select count(id) from Appointment   b  where  b.employeePrice.id = :emp_id and app_status = :app_status  and status = :status";
        }
        Query query =session.createQuery(hql);
        query.setParameter("emp_id",emp_id);
        if(app_status!=null&&!app_status.equals("")&&status==null||status.equals("")){
            query.setParameter("app_status", app_status);
        }else if(status!=null&&!status.equals("")&&app_status==null||app_status.equals("")){
            query.setParameter("status", status);
        }else if(status!=null&&!status.equals("")&&app_status!=null&&!app_status.equals("")){
            query.setParameter("status", status);
            query.setParameter("app_status", app_status);
        }
        return (Long) query.uniqueResult();
    }

    @Override//分页查询某个经销商的预约表信息 app_status表示预约状态 status表示是否冻结或激活
    public Pager<Appointment> queryAllAppointmentAgency(Pager<Appointment> pager, String agency_id, int app_status, int status) {
        Session session = getSessionFactory().getCurrentSession();
        String  hql = "from Appointment  l where  l.agencyPrice.id = :agency_id order by created_time desc ";
        if(status>1&&app_status>0){
            hql = "from Appointment  l where  l.agencyPrice.id = :agency_id  and app_status = :app_status order by created_time desc";
        }else if(status<2&&app_status<1){
            hql = "from Appointment  l where  l.agencyPrice.id = :agency_id  and status = :status order by created_time desc";
        }else if(status<2&&app_status>0){
            hql = "from Appointment  l where  l.agencyPrice.id = :agency_id  and app_status = :app_status  and status = :status order by created_time desc";
        }
        Query query = session.createQuery(hql);
        query.setParameter("agency_id", agency_id);
        if(status>1&&app_status>0){
            query.setParameter("app_status", app_status);
        }else if(status<2&&app_status<1){
            query.setParameter("status", status);
        }else if(status<2&&app_status>0){
            query.setParameter("status", status);
            query.setParameter("app_status", app_status);
        }
        query.setMaxResults(pager.getPageSize()); // 每页显示的个数
        query.setFirstResult(pager.getIndex());//当前页
        List<Appointment> appointments = query.list();
        pager.setResult(appointments);
        return pager;
    }

    @Override//查询某个经销商的预约记录有多少个
    public long countAppointmentAgency(String agency_id, int app_status, int status) {
        Session session = getSessionFactory().getCurrentSession();
        String hql = "select count(id) from Appointment   b  where  b.agencyPrice.id = :agency_id ";
        if(status>1&&app_status>0){
            hql = "select count(id) from Appointment   b  where  b.agencyPrice.id = :agency_id  and app_status = :app_status";
        }else if(status<2&&app_status<1){
            hql = "select count(id) from Appointment   b  where  b.agencyPrice.id = :agency_id and status = :status";
        }else if(status<2&&app_status>0){
            hql = "select count(id) from Appointment   b  where  b.agencyPrice.id = :agency_id and app_status = :app_status  and status = :status";
        }
        Query query =session.createQuery(hql);
        query.setParameter("agency_id",agency_id);
        if(status>1&&app_status>0){
            query.setParameter("app_status", app_status);
        }else if(status<2&&app_status<1){
            query.setParameter("status", status);
        }else if(status<2&&app_status>0){
            query.setParameter("status", status);
            query.setParameter("app_status", app_status);
        }
        return (Long) query.uniqueResult();
    }

    @Override
    public void updateAppointmentStatus(String id, int status) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("update Appointment set status = :status where id=:id");
        query.setParameter("id", id);
        query.setParameter("status", status);
        query.executeUpdate();
    }
}
