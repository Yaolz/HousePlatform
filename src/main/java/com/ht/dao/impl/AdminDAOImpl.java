package com.ht.dao.impl;

import com.ht.bean.Activity;
import com.ht.bean.Admin;
import com.ht.bean.Agency;
import com.ht.common.Pager;
import com.ht.dao.AbstractBaseDAO;
import com.ht.dao.AdminDAO;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.List;
import java.util.concurrent.AbstractExecutorService;

/**
 * Created by yao on 2017/8/26.
 */
public class AdminDAOImpl extends AbstractBaseDAO implements AdminDAO {

    @Override
    public Admin queryById(String s) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Admin  where id = :id ");
        query.setParameter("id",s);
        Object obj = query.uniqueResult(); // 返回单个结果
        return obj != null ? (Admin) obj : null;
    }

    @Override
    public void add(Admin admin) {
        getSessionFactory().getCurrentSession().save(admin);
    }

    @Override
    public void remove(Admin admin) {}

    @Override
    public void update(Admin admin) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("update Admin  set  name = :name, email = :email, phone = :phone where  id = :id");
        query.setParameter("name", admin.getName());
        query.setParameter("email", admin.getEmail());
        query.setParameter("phone", admin.getPhone());
        query.setParameter("id", admin.getId());
        query.executeUpdate();
    }

    @Override
    public Pager<Admin> queryPager(Pager<Admin> pager) {
        return null;
    }

    @Override
    public List<Admin> queryAll() {
        return null;
    }

    @Override
    public int count() {
        return 0;
    }

    @Override
    public Admin queryByEmailPwd( String email) {
        Query query = getSessionFactory().getCurrentSession().createQuery("from Admin a where a.email = :email");
        query.setParameter("email", email);
        Object obj = query.uniqueResult(); // 返回单个结果
        return obj != null ? (Admin) obj : null;
    }

    @Override
    public Admin queryPwd(String pwd) {
        Query query = getSessionFactory().getCurrentSession().createQuery("from Admin a where a.pwd = :pwd");
        query.setParameter("pwd", pwd);
        Object obj = query.uniqueResult(); // 返回单个结果
        return obj != null ? (Admin) obj : null;
    }

    @Override
    public void updatePwd(Admin admin) {
        Session session=getSessionFactory().getCurrentSession();
        Query query=session.createQuery("update Admin set pwd = :pwd where id = :id");
        query.setParameter("pwd", admin.getPwd());
        query.setParameter("id", admin.getId());
        query.executeUpdate();
    }
}
