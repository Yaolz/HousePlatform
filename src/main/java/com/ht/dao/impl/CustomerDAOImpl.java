package com.ht.dao.impl;

import com.ht.bean.Building;
import com.ht.bean.Customer;
import com.ht.common.Pager;
import com.ht.dao.AbstractBaseDAO;
import com.ht.dao.CustomerDAO;
import org.hibernate.Session;
import org.hibernate.query.Query;

import javax.transaction.Transactional;
import java.util.List;

/**
 * Created by ID.LQF on 2017/8/30.
 * 客户
 */
@Transactional
public class CustomerDAOImpl extends AbstractBaseDAO implements CustomerDAO {

    @Override
    public Customer queryById(String s) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Customer  where id = :id ");
        query.setParameter("id", s);
        Object obj = query.uniqueResult(); // 返回单个结果
        return obj != null ? (Customer) obj : null;
    }

    @Override
    public void add(Customer customer) {
        getSessionFactory().getCurrentSession().save(customer);
    }

    @Override
    public void remove(Customer customer) {
        getSessionFactory().getCurrentSession().remove(customer);
    }

    @Override
    public void update(Customer customer) {
        getSessionFactory().getCurrentSession().update(customer);
    }

    @Override
    public Pager<Customer> queryPager(Pager<Customer> pager) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Customer where order by created_time desc");
        query.setFirstResult(pager.getIndex());
        query.setMaxResults(pager.getPageSize());
        pager.setResult(query.list());
        return pager;
    }


    @Override
    public List<Customer> queryAll() {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Customer order by created_time desc");
        List<Customer> list = query.list();
        return list;
    }

    @Override
    public int count() {
        Session session = getSessionFactory().getCurrentSession();
        Long longStr = (Long) session.createQuery("select count(id) from Customer").uniqueResult();
        int count = longStr.intValue();
        return count;
    }

    @Override//分页查询员工添加的客户
    public Pager<Customer> queryCustomer(Pager<Customer> pager, String emp_id) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Customer where employeePrice.id = :emp_id");
        query.setParameter("emp_id", emp_id);
        query.setFirstResult(pager.getIndex());
        query.setMaxResults(pager.getPageSize());
        List<Customer> customers = query.list();
        pager.setResult(customers);
        pager.setTotal(countCustomer(emp_id));
        return pager;
    }

    @Override//查询员工添加的客户有多少个
    public long countCustomer(String emp_id) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery
                ("select count(id) from Customer  b  where  b.employeePrice.id = :emp_id");
        query.setParameter("emp_id", emp_id);
        return (Long) query.uniqueResult();
    }

    @Override//分页查询员工添加的被冻结或激活的客户
    public Pager<Customer> queryCustomerStatus(Pager<Customer> pager, String emp_id, int status) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Customer where employeePrice.id = :emp_id and status = :status");
        query.setParameter("emp_id", emp_id);
        query.setParameter("status", status);
        query.setFirstResult(pager.getIndex());
        query.setMaxResults(pager.getPageSize());
        List<Customer> customers = query.list();
        pager.setResult(customers);
        pager.setTotal(countCustomer(emp_id));
        return pager;
    }

    @Override//查询员工添加的被冻结或激活的客户有多少个
    public long countCustomerStatus(String emp_id, int status) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery
                ("select count(id) from Customer  b  where  b.employeePrice.id = :emp_id and status = :status");
        query.setParameter("emp_id", emp_id);
        query.setParameter("status", status);
        return (Long) query.uniqueResult();
    }

    @Override//批量冻结或激活
    public void updateStatus(String[] id, int status) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("update Customer set status = :status  where   id  in  (:id)");
        query.setParameter("status", status);
        query.setParameterList("id", id);
        query.executeUpdate();
    }

    @Override//修改客户信息
    public void updateCustomer(Customer customer) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("update Customer set name = :name,gender = :gender," +
                "birthday = :birthday,identity_id = :identity_id,email = :email,phone = :phone" +
                ",address = :address,customer_type = :customer_type,together = :together" +
                "  where  id = :id");
        query.setParameter("name", customer.getName());
        query.setParameter("gender", customer.getGender());
        query.setParameter("birthday", customer.getBirthday());
        query.setParameter("identity_id", customer.getIdentity_id());
        query.setParameter("email", customer.getEmail());
        query.setParameter("phone", customer.getPhone());
        query.setParameter("address", customer.getAddress());
        query.setParameter("customer_type", customer.getCustomer_type());
        query.setParameter("together", customer.getTogether());
        query.setParameter("id", customer.getId());
        query.executeUpdate();
    }

    @Override//给客户上传电子版购房合同路径
    public void updateContract(String id, String contract) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("update Customer set contract = :contract  where  id = :id");
        query.setParameter("contract", contract);
        query.setParameter("id", id);
        query.executeUpdate();
    }

    @Override//给客户上传zip版电子档案路径
    public void updateArchives(String id, String archives) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("update Customer set archives = :archives  where  id = :id");
        query.setParameter("archives", archives);
        query.setParameter("id", id);
        query.executeUpdate();
    }

    @Override
    public Pager<Customer> pagerByBuildings(Pager<Customer> pager, String buildings_id) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Customer where agencyPrice.id = :buildings_id");
        query.setParameter("buildings_id", buildings_id);
        query.setFirstResult(pager.getIndex());
        query.setMaxResults(pager.getPageSize());
        List<Customer> customers = query.list();
        pager.setResult(customers);
        pager.setTotal(NuCustomer(buildings_id));
        return pager;
    }

    @Override
    public long NuCustomer(String buildings_id) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery
                ("select count(id) from Customer  b  where  b.agencyPrice.id = :buildings_id");
        query.setParameter("buildings_id", buildings_id);
        return (Long) query.uniqueResult();
    }

    @Override//分页查询楼盘下被冻结或激活的客户
    public Pager<Customer> queryBuildingsCustomer(Pager<Customer> pager, String buildings_id, int status) {
        Session session = getSessionFactory().getCurrentSession();
        String hql = "from Customer where employeePrice.buildingsPrice.id = :buildings_id";
        if(status<2){
            hql = "from Customer where employeePrice.buildingsPrice.id = :buildings_id and status = :status";
        }
        Query query = session.createQuery(hql);
        query.setParameter("buildings_id", buildings_id);
        if(status<2){
            query.setParameter("status", status);
        }
        query.setFirstResult(pager.getIndex());
        query.setMaxResults(pager.getPageSize());
        List<Customer> customers = query.list();
        pager.setResult(customers);
        return pager;
    }

    @Override//查询楼盘下被冻结或激活的客户有多少个
    public long countBuildingsCustomer(String buildings_id, int status) {
        Session session = getSessionFactory().getCurrentSession();
        String hql = "select count(id) from Customer  b  where  b.employeePrice.buildingsPrice.id = :buildings_id";
        if(status<2){
            hql = "select count(id) from Customer  b  where  b.employeePrice.buildingsPrice.id = :buildings_id and status = :status";
        }
        Query query = session.createQuery(hql);
        query.setParameter("buildings_id", buildings_id);
        if(status<2){
            query.setParameter("status", status);
        }
        return (Long) query.uniqueResult();
    }

    @Override//查询经销商下被冻结或激活的客户
    public Pager<Customer> queryCustomerStatusAgency(Pager<Customer> pager, String age_id, int status) {
        Session session = getSessionFactory().getCurrentSession();
        String hql = "from Customer where agencyPrice.id = :age_id";
        if(status<2){
            hql = "from Customer where agencyPrice.id = :age_id and status = :status";
        }
        Query query = session.createQuery(hql);
        query.setParameter("age_id", age_id);
        if(status<2){
            query.setParameter("status", status);
        }
        query.setFirstResult(pager.getIndex());
        query.setMaxResults(pager.getPageSize());
        List<Customer> customers = query.list();
        pager.setResult(customers);
        return pager;
    }

    @Override
    public long countCustomerStatusAgency(String age_id, int status) {
        Session session = getSessionFactory().getCurrentSession();
        String hql = "select count(id) from Customer  b  where  b.agencyPrice.id = :age_id";
        if(status<2){
            hql= "select count(id) from Customer  b  where  b.agencyPrice.id = :age_id and status = :status";
        }
        Query query = session.createQuery(hql);
        query.setParameter("age_id", age_id);
        if(status<2){
            query.setParameter("status", status);
        }
        return (Long) query.uniqueResult();
    }
}
