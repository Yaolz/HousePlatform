package com.ht.dao.impl;

import com.ht.bean.Article;
import com.ht.common.Pager;
import com.ht.dao.AbstractBaseDAO;
import com.ht.dao.ArticleDAO;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.query.Query;

import java.util.List;

/**
 * Created by CHEN JX on 2017/8/23.
 * 文章
 */
public class ArticleDAOImpl extends AbstractBaseDAO implements ArticleDAO {
    @Override
    public Article queryById(String s) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Article  where id = :id ");
        query.setParameter("id",s);
        Object obj = query.uniqueResult(); // 返回单个结果
        return obj != null ? (Article) obj : null;
    }

    @Override
    public void add(Article article) {
        getSessionFactory().getCurrentSession().save(article);
    }

    @Override
    public void remove(Article  article) {
        getSessionFactory().getCurrentSession().remove(article);
    }

    @Override
    public void update(Article article) {
        getSessionFactory().getCurrentSession().update(article);
    }

    @Override
    public Pager<Article> queryPager(Pager<Article> pager) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Article order by created_time desc");
        query.setFirstResult(pager.getIndex());
        query.setMaxResults(pager.getPageSize());
        List<Article> articles = query.list();
        pager.setResult(articles);
        pager.setTotal(countId());
        return pager;
    }

    @Override
    public List<Article> queryAll() {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Article order by created_time desc");
        List<Article> list = query.list();
        return list;
    }

    @Override
    public int count() {
        return 0;
    }

    @Override
    public long countId() {
        Session session = getSessionFactory().getCurrentSession();
        long count = (Long) session.createQuery("select count(id) from Article ").uniqueResult();
        return count;
    }

    @Override
    public void updateStatusById(String[] id,int status) {
        Session session=getSessionFactory().getCurrentSession();
        Query query=session.createQuery("update Article set status = :status where id in (:id)");
        query.setParameter("status",status);
        query.setParameterList("id", id);
        query.executeUpdate();
    }

    @Override
    public Pager<Article> queryPager(Pager<Article> pager, int status) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Article where status=:status order by created_time desc");
        query.setParameter("status",status);
        query.setFirstResult(pager.getIndex());
        query.setMaxResults(pager.getPageSize());
        List<Article> articles = query.list();
        pager.setResult(articles);
        pager.setTotal(countId());
        return pager;
    }

    @Override
    public Pager<Article> queryAllindex(Pager<Article> pager, String type, String like) {
        Session session = getSessionFactory().getCurrentSession();
        Criteria criteria = session.createCriteria(Article.class); // 基于对象的条件查询
        criteria.add(Restrictions.eq("status",1));
        if(type!=null&&!type.equals("")&&!type.equals("undefined")&&!type.contains(" ")){
            criteria.add(Restrictions.eq("articleType.id",type));
        }
        if(like!=null&&!like.equals("")&&!like.equals("undefined")&&!like.contains(" ")){
            criteria.add(Restrictions.like("title", "%"+like+"%"));
        }
        criteria.setMaxResults(pager.getPageSize()); // 每页显示的个数
        criteria.setFirstResult(pager.getIndex());//当前页
        criteria.addOrder(Order.desc("created_time"));//根据名字升序排列
        List<Article> buildings = criteria.list();
        pager.setResult(buildings);
        return pager;
    }

    @Override
    public long countAllindex(String type, String like) {
        Session session = getSessionFactory().getCurrentSession();
        Criteria criteria = session.createCriteria(Article.class); // 基于对象的条件查询
        criteria.add(Restrictions.eq("status",1));
        if(type!=null&&!type.equals("")&&!type.equals("undefined")&&!type.contains(" ")){
            criteria.add(Restrictions.eq("articleType.id",type));
        }
        if(like!=null&&!like.equals("")&&!like.equals("undefined")&&!like.contains(" ")){
            criteria.add(Restrictions.like("title", "%"+like+"%"));
        }
        criteria.setProjection(Projections.rowCount());
        long count =   Long.parseLong(criteria.uniqueResult().toString());
        return count;
    }
}
