package com.ht.dao.impl;

import com.ht.bean.Message;
import com.ht.bean.Role;
import com.ht.bean.User;
import com.ht.common.Pager;
import com.ht.dao.AbstractBaseDAO;
import com.ht.dao.RoleDAO;
import org.hibernate.Session;
import org.hibernate.query.Query;

import java.util.List;

/**
 * Created by CHEN JX on 2017/8/24.
 */
public class RoleDAOImpl extends AbstractBaseDAO implements RoleDAO {
    @Override
    public Role queryById(String id) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Role  where id = :id ");
        query.setParameter("id",id);
        Object obj = query.uniqueResult(); // 返回单个结果
        return obj != null ? (Role) obj : null;
    }

    @Override
    public void add(Role role) {
        getSessionFactory().getCurrentSession().save(role);
    }

    @Override
    public void remove(Role role) {
        getSessionFactory().getCurrentSession().remove(role);
    }

    @Override
    public void update(Role role) {
        getSessionFactory().getCurrentSession().remove(role);
    }

    @Override
    public Pager<Role> queryPager(Pager<Role> pager) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Role order by created_time desc");
        query.setFirstResult(pager.getPageSize());
        query.setMaxResults(pager.getIndex());
        pager.setResult(query.list());
        return pager;
    }

    @Override
    public List<Role> queryAll() {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Role order by created_time desc");
        List<Role> list = query.list();
        return list;
    }

    @Override
    public int count() {
        return 0;
    }
}
