package com.ht.dao.impl;

import com.ht.bean.Ads;
import com.ht.common.Pager;
import com.ht.dao.AbstractBaseDAO;
import com.ht.dao.AdsDAO;
import org.hibernate.Session;
import org.hibernate.query.Query;

import java.util.List;

/**
 * Created by CHEN JX on 2017/8/23.
 * 广告
 */
public class AdsDAOImpl extends AbstractBaseDAO implements AdsDAO {
    @Override
    public Ads queryById(String s) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Ads  where id = :id ");
        query.setParameter("id",s);
        Object obj = query.uniqueResult(); // 返回单个结果
        return obj != null ? (Ads) obj : null;
    }


    @Override
    public void add(Ads ads) {
        getSessionFactory().getCurrentSession().save(ads);
    }

    @Override
    public void remove(Ads ads) {
        getSessionFactory().getCurrentSession().remove(ads);
    }

    @Override
    public void update(Ads ads) {
        getSessionFactory().getCurrentSession().update(ads);

    }

    @Override
    public Pager<Ads> queryPager(Pager<Ads> pager) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Ads order by show_order asc");
        query.setFirstResult(pager.getIndex());
        query.setMaxResults(pager.getPageSize());
        pager.setResult(query.list());
        pager.setTotal(countId());
        return pager;
    }

    @Override
    public List<Ads> queryAll() {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Ads order by show_order asc");
        List<Ads> list = query.list();
        return list;
    }

    @Override
    public int count() {
        return 0;
    }

    @Override
    public long countId() {
        Session session = getSessionFactory().getCurrentSession();
        long count = (Long) session.createQuery("select count(id) from Ads").uniqueResult();
        return count;
    }

    @Override
    public Pager<Ads> queryAllStatus(Pager<Ads> pager, int status) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Ads a where  a.status = :status order by show_order asc");
        query.setParameter("status", status);
        query.setMaxResults(pager.getPageSize()); // 每页显示的个数
        query.setFirstResult(pager.getIndex());//当前页
        List<Ads> adsList = query.list();
        pager.setResult(adsList);
//        pager.setTotal(countChecked(checked_status));
        return pager;
    }

    @Override
    public void updateStatus(String[] id, int status) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("update Ads set status = :status  where   id  in  (:id)");
        query.setParameter("status", status);
        query.setParameterList("id", id);
        query.executeUpdate();
    }

    @Override
    public List<Ads> queryShow(int beginNum, int endNum) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Ads where status = 1 and show_order >=  "+beginNum+"   and  show_order <=  "+endNum + "order by show_order asc");
        List<Ads> list = query.list();
        return list;
    }

}
