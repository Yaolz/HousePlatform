package com.ht.dao.impl;

import com.ht.bean.History;
import com.ht.bean.House;
import com.ht.bean.Like;
import com.ht.common.Pager;
import com.ht.dao.AbstractBaseDAO;
import com.ht.dao.LikeDAO;
import org.hibernate.Session;
import org.hibernate.query.Query;

import java.awt.geom.GeneralPath;
import java.util.List;

/**
 * Created by CHEN JX on 2017/8/24.
 */
public class LikeDAOImpl extends AbstractBaseDAO implements LikeDAO {
    @Override
    public Like queryById(String s) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Like l where l.id = :id ");
        query.setParameter("id",s);
        Object obj = query.uniqueResult(); // 返回单个结果
        return obj != null ? (Like) obj : null;
    }

    @Override
    public void add(Like like) {
        getSessionFactory().getCurrentSession().save(like);
    }

    @Override
    public void remove(Like like) {
        getSessionFactory().getCurrentSession().remove(like);
    }

    @Override
    public void update(Like like) {
        getSessionFactory().getCurrentSession().update(like);
    }

    @Override
    public Pager<Like> queryPager(Pager<Like> pager) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Like order by created_time desc");
        query.setFirstResult(pager.getIndex());
        query.setMaxResults(pager.getPageSize());
        pager.setResult(query.list());
        return pager;

    }

    @Override
    public List<Like> queryAll() {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Like order by created_time desc");
        List<Like> list = query.list();
        return list;
    }

    @Override
    public int count() {
        Session session = getSessionFactory().getCurrentSession();
        Long longStr = (Long) session.createQuery("select count(id) from Like").uniqueResult();
        int count = longStr.intValue();
        return count;
    }

    @Override
    public Pager<Like> queryAllLike(Pager<Like> pager, String user_id) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Like l where  l.userPrice.id = :user_id");
        query.setParameter("user_id", user_id);
        query.setMaxResults(pager.getPageSize()); // 每页显示的个数
        query.setFirstResult(pager.getIndex());//当前页
        List<Like> likeList = query.list();
        pager.setResult(likeList);
        pager.setTotal(countLike(user_id));
        return pager;

    }

    @Override
    public long countLike(String user_id) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery
                ("select count(id) from Like   l  where  l.userPrice.id = :user_id ");
        query.setParameter("user_id", user_id);
        return (Long) query.uniqueResult();
    }

    @Override
    public Like queryByid(String user_id, String buildings_id) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Like where userPrice.id =:user_id and buildingsPrice.id =:buildings_id ");
        query.setParameter("user_id",user_id);
        query.setParameter("buildings_id",buildings_id);
        Like list = (Like) query.uniqueResult();
        return list;

    }
}
