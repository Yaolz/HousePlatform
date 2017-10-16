package com.ht.dao.impl;

import com.ht.bean.Comment;
import com.ht.common.Pager;
import com.ht.dao.AbstractBaseDAO;
import com.ht.dao.CommentDAO;
import org.hibernate.Session;
import org.hibernate.query.Query;

import java.util.List;

/**
 * Created by CHEN JX on 2017/8/23.
 * 评价表
 */
public class CommentDAOImpl extends AbstractBaseDAO implements CommentDAO{
    @Override
    public Comment queryById(String s) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Comment  where id = :id ");
        query.setParameter("id",s);
        Object obj = query.uniqueResult(); // 返回单个结果
        return obj != null ? (Comment) obj : null;
    }

    @Override
    public void add(Comment comment) {
        getSessionFactory().getCurrentSession().save(comment);
    }

    @Override
    public void remove(Comment comment) {
        getSessionFactory().getCurrentSession().remove(comment);
    }

    @Override
    public void update(Comment comment) {
        getSessionFactory().getCurrentSession().update(comment);
    }

    @Override
    public Pager<Comment> queryPager(Pager<Comment> pager) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Comment order by comment_time desc");
        query.setFirstResult(pager.getIndex());
        query.setMaxResults(pager.getPageSize());
        pager.setResult(query.list());
        return pager;
    }

    @Override
    public List<Comment> queryAll() {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Comment order by comment_time desc");
        List<Comment> list = query.list();
        return list;
    }

    @Override
    public int count() {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("select  count(id) from Comment");
        Long countStr  = (Long) query.uniqueResult();
        int count = countStr.intValue();
        return count;
    }

    @Override//分页查询某个用户下的评价记录
    public Pager<Comment> queryAllComment(Pager<Comment> pager, String user_id) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Comment m where  m.userPrice.id = :user_id");
        query.setParameter("user_id", user_id);
        query.setMaxResults(pager.getPageSize()); // 每页显示的个数
        query.setFirstResult(pager.getIndex());//当前页
        List<Comment> likeList = query.list();
        pager.setResult(likeList);
        pager.setTotal(countComment(user_id));
        return pager;
    }

    @Override//查询某个用户下的评价有多少个
    public Long countComment(String user_id) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery
                ("select count(id) from Comment   b  where  b.userPrice.id = :user_id ");
        query.setParameter("user_id", user_id);
        return (Long) query.uniqueResult();
    }

    @Override//分页查询某个楼盘下的评价记录
    public Pager<Comment> queryAllCommentBuildings(Pager<Comment> pager, String buildings_id, int status) {
        Session session = getSessionFactory().getCurrentSession();
        String hql = "from Comment  where  buildingsPrice.id = :buildings_id  order by comment_time desc ";
        if(status<2){
            hql = "from Comment  where  buildingsPrice.id = :buildings_id and status = :status order by comment_time desc ";
        }
        Query query = session.createQuery(hql);
        query.setParameter("buildings_id", buildings_id);
        if(status<2){
            query.setParameter("status",status);
        }
        query.setMaxResults(pager.getPageSize()); // 每页显示的个数
        query.setFirstResult(pager.getIndex());//当前页
        List<Comment> commentList = query.list();
        pager.setResult(commentList);
        pager.setTotal(countCommentBuildings(buildings_id, 1));
        return pager;
    }

    @Override//查询某个楼盘下的评价有多少个
    public Long countCommentBuildings(String buildings_id, int status) {
        Session session = getSessionFactory().getCurrentSession();
        String hql = "select count(id) from Comment  where buildingsPrice.id = :buildings_id ";
        if(status<2){
            hql = "select count(id) from Comment  where buildingsPrice.id = :buildings_id and status = :status";
        }
        Query query =session.createQuery(hql);
        query.setParameter("buildings_id",buildings_id);
        if(status<2){
            query.setParameter("status",status);
        }
        return (Long) query.uniqueResult();
    }

    @Override//分页查询某个经销商下所有楼盘的评价记录
    public Pager<Comment> queryAllCommentAgency(Pager<Comment> pager, String agency_id, int status) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Comment  where  buildingsPrice.agencyPrice.id = :agency_id  and status = :status order by comment_time desc  ");
        query.setParameter("agency_id", agency_id);
        query.setParameter("status", status);
        query.setMaxResults(pager.getPageSize()); // 每页显示的个数
        query.setFirstResult(pager.getIndex());//当前页
        List<Comment> commentList = query.list();
        pager.setResult(commentList);
        return pager;
    }

    @Override//查询某个经销商下所有楼盘的评价记录有多少个
    public Long countCommentAgency(String agency_id, int status) {
        Session session = getSessionFactory().getCurrentSession();
        Query query =session.createQuery
                ("select count(id) from Comment  where buildingsPrice.agencyPrice.id = :agency_id and status = :status");
        query.setParameter("agency_id",agency_id);
        query.setParameter("status", status);
        return (Long) query.uniqueResult();
    }

    @Override
    public void updateCommentContext(String content, String id) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("update Comment set content = :content where id=:id");
        query.setParameter("content", content);
        query.setParameter("id", id);
        query.executeUpdate();
    }

    @Override
    public void updateCommentStatus(String id, int status) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("update Comment set status = :status where id=:id");
        query.setParameter("id", id);
        query.setParameter("status", status);
        query.executeUpdate();
    }

    @Override
    public void deleteComment(String[] id) {
        Session session=getSessionFactory().getCurrentSession();
        Query query=session.createQuery("delete Comment  where id in (:id)");
        query.setParameterList("id", id);
        query.executeUpdate() ;
    }

}
