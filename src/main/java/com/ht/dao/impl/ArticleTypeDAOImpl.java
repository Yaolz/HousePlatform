package com.ht.dao.impl;

import com.ht.bean.ArticleType;
import com.ht.common.Pager;
import com.ht.dao.AbstractBaseDAO;
import com.ht.dao.ArticleTypeDAO;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.query.Query;

import java.util.List;


/**
 * Created by CHEN JX on 2017/8/23.
 * 文章类型
 */
public class ArticleTypeDAOImpl extends AbstractBaseDAO implements ArticleTypeDAO {
    @Override
    public ArticleType queryById(String s) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from ArticleType  where id = :id ");
        query.setParameter("id", s);
        Object obj = query.uniqueResult(); // 返回单个结果
        return obj != null ? (ArticleType) obj : null;
    }

    @Override
    public void add(ArticleType articleType) {
        getSessionFactory().getCurrentSession().save(articleType);
    }

    @Override
    public void remove(ArticleType articleType) {
        getSessionFactory().getCurrentSession().remove(articleType);
    }

    @Override
    public void update(ArticleType articleType) {
        getSessionFactory().getCurrentSession().update(articleType);
    }

    @Override
    public Pager<ArticleType> queryPager(Pager<ArticleType> pager) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from ArticleType");
        query.setFirstResult(pager.getIndex());
        query.setMaxResults(pager.getPageSize());
        pager.setResult(query.list());
        pager.setTotal(countId());
        return pager;
    }

    @Override
    public List<ArticleType> queryAll() {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from ArticleType where status = 1");
        List<ArticleType> list = query.list();
        return list;
    }

    @Override
    public int count() {
        return 0;
    }

    @Override
    public long countId() {
        Session session = getSessionFactory().getCurrentSession();
        long count = (Long) session.createQuery("select count(id) from ArticleType ").uniqueResult();
        return count;
    }

    @Override
    public void updateStatusById(String[] id, int status) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("update ArticleType set status= :status where id in (:id)");
        query.setParameter("status", status);
        query.setParameterList("id", id);
        query.executeUpdate();
    }
}
