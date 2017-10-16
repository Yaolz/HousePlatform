package com.ht.dao.impl;

import com.ht.bean.Employee;
import com.ht.bean.History;
import com.ht.bean.Like;
import com.ht.bean.Message;
import com.ht.common.Pager;
import com.ht.dao.AbstractBaseDAO;
import com.ht.dao.HistoryDAO;
import org.hibernate.Session;
import org.hibernate.query.Query;

import java.util.List;

/**
 * Created by CHEN JX on 2017/8/23.
 * 历史纪录
 */
public class HistoryDAOImpl extends AbstractBaseDAO implements HistoryDAO {
    @Override
    public History queryById(String s) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from History  where id = :id ");
        query.setParameter("id",s);
        Object obj = query.uniqueResult(); // 返回单个结果
        return obj != null ? (History) obj : null;
    }

    @Override
    public void add(History history) {
        getSessionFactory().getCurrentSession().save(history);
    }

    @Override
    public void remove(History history) {
        getSessionFactory().getCurrentSession().remove(history);
    }

    @Override
    public void update(History history) {
        Session session=getSessionFactory().getCurrentSession();
        Query query=session.createQuery("update History set created_time = :created_time where id = :id");
        query.setParameter("created_time", history.getCreated_time());
        query.setParameter("id", history.getId());
        query.executeUpdate();
    }

    @Override
    public Pager<History> queryPager(Pager<History> pager) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from History order by created_time desc");
        query.setFirstResult(pager.getIndex());
        query.setMaxResults(pager.getPageSize());
        pager.setResult(query.list());
        return pager;
    }

    @Override
    public List<History> queryAll() {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from History order by created_time desc");
        List<History> list = query.list();
        return list;
    }

    @Override
    public int count() {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("select count(id) from History");
        Long countStr = (Long) query.uniqueResult();
        int count = countStr.intValue();
        return count;

    }

    @Override
    public Pager<History> queryAllHistory(Pager<History> pager, String user_id) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from History m where  m.userPrice.id = :user_id");
        query.setParameter("user_id", user_id);
        query.setMaxResults(pager.getPageSize()); // 每页显示的个数
        query.setFirstResult(pager.getIndex());//当前页
        List<History> likeList = query.list();
        pager.setResult(likeList);
        pager.setTotal(countHistory(user_id));
        return pager;

    }

    @Override
    public Long countHistory(String user_id) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery
                ("select count(id) from History   b  where  b.userPrice.id = :user_id");
        query.setParameter("user_id", user_id);
        return (Long) query.uniqueResult();
    }

    @Override
    public History queryById(String user_id, String buildings_id) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from History where userPrice.id =:user_id and buildingsPrice.id =:buildings_id");
        query.setParameter("user_id",user_id);
        query.setParameter("buildings_id",buildings_id);
        Object obj = query.uniqueResult(); // 返回单个结果
        return obj != null ? (History) obj : null;
    }


}
