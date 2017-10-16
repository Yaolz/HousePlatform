package com.ht.dao.impl;

import com.ht.bean.Building;
import com.ht.bean.Comment;
import com.ht.bean.Employee;
import com.ht.common.Pager;
import com.ht.dao.AbstractBaseDAO;
import com.ht.dao.EmployeeDAO;
import com.ht.price.EmployeePrice;
import com.ht.price.MissionBean;
import com.ht.service.MissionService;
import org.hibernate.Session;
import org.hibernate.query.Query;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by CHEN JX on 2017/8/23.
 * 员工
 */
public class EmployeeDAOImpl extends AbstractBaseDAO implements EmployeeDAO {

    @Resource
    private MissionService missionService;

    @Override
    public Employee queryById(String s) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Employee  where id = :id ");
        query.setParameter("id",s);
        Object obj = query.uniqueResult(); // 返回单个结果
        return obj != null ? (Employee) obj : null;
    }

    @Override
    public void add(Employee employee) {
        getSessionFactory().getCurrentSession().save(employee);
    }

    @Override
    public void remove(Employee employee) {
        getSessionFactory().getCurrentSession().remove(employee);
    }

    @Override
    public void update(Employee employee) {
        getSessionFactory().getCurrentSession().update(employee);
    }

    @Override
    public Pager<Employee> queryPager(Pager<Employee> pager) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Employee order by created_time desc");
        query.setFirstResult(pager.getIndex());
        query.setMaxResults(pager.getPageSize());
        pager.setResult(query.list());
        pager.setTotal(5);
        return pager;
    }

    @Override
    public List<Employee> queryAll() {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("form Employee order by created_time desc");
        List<Employee> list = query.list();
        return list;
    }

    @Override
    public int count() {
        return 0;
    }

    @Override
    public Employee queryByPwd(String email) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Employee  where email = :email ");
        query.setParameter("email",email);
        Object obj = query.uniqueResult(); // 返回单个结果
        return obj != null ? (Employee) obj : null;
    }

    @Override//修改员工信息
    public void updateEmployee(Employee employee) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("update Employee set name = :name,phone = :phone," +
                "qq = :qq,wechat = :wechat,gender = :gender,exp = :exp,des = :des,basic_salary = :basic_salary" +
                ",address = :address,headicon = :headicon,intro = :intro" +
                "  where  id = :id");
        query.setParameter("name", employee.getName());
        query.setParameter("phone", employee.getPhone());
        query.setParameter("qq",employee.getQq());
        query.setParameter("wechat", employee.getWechat());
        query.setParameter("gender", employee.getGender());
        query.setParameter("exp", employee.getExp());
        query.setParameter("des", employee.getDes());
        query.setParameter("basic_salary", employee.getBasic_salary());
        query.setParameter("address", employee.getAddress());
        query.setParameter("headicon", employee.getHeadicon());
        query.setParameter("intro", employee.getIntro());
        query.setParameter("id", employee.getId());
        query.executeUpdate();
    }

    @Override//分页查询某个楼盘下工作的员工
    public Pager<Employee> queryAllEmployee(Pager<Employee> pager, String buildings_id) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Employee b where  b.buildingsPrice.id = :buildings_id order by created_time desc ");
        query.setParameter("buildings_id", buildings_id);
        query.setMaxResults(pager.getPageSize()); // 每页显示的个数
        query.setFirstResult(pager.getIndex());//当前页
        List<Employee> employees = query.list();
        pager.setResult(employees);
        pager.setTotal(countEmployee(buildings_id));//查询某个楼盘的户型有多少个
        return pager;
    }

    @Override//查询某个楼盘下工作的员工有多少个
    public long countEmployee(String buildings_id) {
        Session session = getSessionFactory().getCurrentSession();
        Query query =session.createQuery
                ("select count(id) from Employee  b  where  b.buildingsPrice.id = :buildings_id");
        query.setParameter("buildings_id",buildings_id);
        return (Long) query.uniqueResult();
    }

    @Override//分页查询某个楼盘下被冻结或激活的员工
    public Pager<Employee> queryAllEmployeeStatus(Pager<Employee> pager, String buildings_id, int status) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Employee b where  b.buildingsPrice.id = :buildings_id  and b.status = :status order by created_time desc");
        query.setParameter("buildings_id", buildings_id);
        query.setParameter("status", status);
        query.setMaxResults(pager.getPageSize()); // 每页显示的个数
        query.setFirstResult(pager.getIndex());//当前页
        List<Employee> employees = query.list();
        pager.setResult(employees);
        pager.setTotal(countEmployeeStatus(buildings_id,status));//查询某个楼盘的户型有多少个
        return pager;
    }

    @Override//查询某个楼盘下被冻结或激活的员工有多少个
    public long countEmployeeStatus(String buildings_id, int status) {
        Session session = getSessionFactory().getCurrentSession();
        Query query =session.createQuery
                ("select count(id) from Employee  b  where  b.buildingsPrice.id = :buildings_id and b.status = :status");
        query.setParameter("buildings_id",buildings_id);
        query.setParameter("status", status);
        return (Long) query.uniqueResult();
    }

    @Override//批量冻结或激活
    public void updateStatus(String[] id, int status) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("update Employee set status = :status  where   id  in  (:id)");
        query.setParameter("status", status);
        query.setParameterList("id", id);
        query.executeUpdate();
    }

    @Override
    public void updateEmailPwd(String email,String pwd) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("update Employee set pwd = :pwd  where   email =:email");
        query.setParameter("pwd", pwd);
        query.setParameter("email", email);
        query.executeUpdate();
    }

    @Override
    public Employee queryByPhone(String phone) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Employee  where phone = :phone ");
        query.setParameter("phone",phone);
        Object obj = query.uniqueResult(); // 返回单个结果
        return obj != null ? (Employee) obj : null;
    }

    @Override
    public Employee queryByName(String name) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Employee  where name = :name ");
        query.setParameter("name",name);
        Object obj = query.uniqueResult(); // 返回单个结果
        return obj != null ? (Employee) obj : null;
    }

    @Override//分页查询所有楼盘的员工有多少个
    public Pager<Employee> queryAllEmployeeAgency(Pager<Employee> pager, String agency_id, int status) {
        Session session = getSessionFactory().getCurrentSession();
        String hql = "from Employee b where  b.agencyPrice.id = :agency_id  order by created_time desc" ;
        if(status < 2){
            hql = "from Employee b where  b.agencyPrice.id = :agency_id  and b.status = :status order by created_time desc" ;
        }
        Query query = session.createQuery(hql);
        query.setParameter("agency_id", agency_id);
        if(status < 2){
            query.setParameter("status", status);
        }
        query.setMaxResults(pager.getPageSize()); // 每页显示的个数
        query.setFirstResult(pager.getIndex());//当前页
        List<Employee> employees = query.list();
        for(Employee employee :employees){
            MissionBean missionBean = missionService.queryByMissionMaxEnd(employee.getId());
            employee.setMissionBean(missionBean);
        }
        pager.setResult(employees);
        pager.setTotal(coutEmployeeAgency(agency_id,status));//查询某个楼盘的户型有多少个
        return pager;
    }

    @Override//查询所有楼盘下的员工有多少个
    public long coutEmployeeAgency(String agency_id, int status) {
        Session session = getSessionFactory().getCurrentSession();
        String hql = "select count(id) from Employee  b  where  b.agencyPrice.id = :agency_id";
        if(status <2){
            hql = "select count(id) from Employee  b  where  b.agencyPrice.id = :agency_id and b.status = :status";
        }
        Query query =session.createQuery(hql);
        query.setParameter("agency_id",agency_id);
        if(status < 2){
            query.setParameter("status", status);
        }
        return (Long) query.uniqueResult();
    }

}
