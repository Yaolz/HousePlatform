package com.ht.dao.impl;

import com.ht.bean.Appointment;
import com.ht.bean.Like;
import com.ht.bean.Message;
import com.ht.common.Pager;
import com.ht.dao.AbstractBaseDAO;
import com.ht.dao.MessageDAO;
import org.hibernate.Session;
import org.hibernate.query.Query;

import java.util.List;

/**
 * Created by CHEN JX on 2017/8/24.
 * 留言
 */
public class MessageDAOImpl extends AbstractBaseDAO implements MessageDAO {
    @Override
    public Message queryById(String s) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Message  where id = :id ");
        query.setParameter("id", s);
        Object obj = query.uniqueResult(); // 返回单个结果
        return obj != null ? (Message) obj : null;
    }

    @Override
    public void add(Message message) {
        getSessionFactory().getCurrentSession().save(message);
    }

    @Override
    public void remove(Message message) {
        getSessionFactory().getCurrentSession().remove(message);
    }

    @Override
    public void update(Message message) {
        getSessionFactory().getCurrentSession().update(message);
    }

    @Override
    public Pager<Message> queryPager(Pager<Message> pager) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Message order by created_time desc");
        query.setFirstResult(pager.getIndex());
        query.setMaxResults(pager.getPageSize());
        pager.setResult(query.list());
        return pager;
    }

    @Override
    public List<Message> queryAll() {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Message order by created_time desc");
        List<Message> list = query.list();
        return list;
    }

    @Override
    public int count() {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("select count(id) from Message");
        Long countStr = (Long) query.uniqueResult();
        int count = countStr.intValue();
        return count;
    }

    @Override//分页查询某个用户自己的留言
    public Pager<Message> queryAllMessage(Pager<Message> pager, String user_id) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Message m where  m.userPrice.id = :user_id");
        query.setParameter("user_id", user_id);
        query.setMaxResults(pager.getPageSize()); // 每页显示的个数
        query.setFirstResult(pager.getIndex());//当前页
        List<Message> likeList = query.list();
        pager.setResult(likeList);
        pager.setTotal(countMessage(user_id));
        return pager;
    }

    @Override//查询用户自己的留言有多少个
    public Long countMessage(String user_id) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery
                ("select count(id) from Message   b  where  b.userPrice.id = :user_id ");
        query.setParameter("user_id", user_id);
        return (Long) query.uniqueResult();
    }

    @Override//分页查询某个用户下被冻结或激活的留言有多少个
    public Pager<Message> queryAllMessage(Pager<Message> pager, String user_id, int status) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Message m where  m.userPrice.id = :user_id  and  m.status = :status ");
        query.setParameter("user_id", user_id);
        query.setParameter("status", status);
        query.setMaxResults(pager.getPageSize()); // 每页显示的个数
        query.setFirstResult(pager.getIndex());//当前页
        List<Message> likeList = query.list();
        pager.setResult(likeList);
        pager.setTotal(countMessage(user_id));
        return pager;
    }

    @Override//查询某个用户下被冻结或激活的留言有多少个
    public long countMessage(String user_id, int status) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery
                ("select count(id) from Message   b  where  b.userPrice.id = :user_id  and b.status = :status ");
        query.setParameter("user_id", user_id);
        query.setParameter("status", status);
        return (Long) query.uniqueResult();
    }

    @Override//分页查询某个楼盘下被冻结或激活的留言有多少
    public Pager<Message> queryAllMessageBuildings(Pager<Message> pager, String buildings_id, int status) {
        Session session = getSessionFactory().getCurrentSession();
        String hql = "from Message  where  buildingsPrice.id = :buildings_id ";
        if(status<2){
            hql = "from Message  where  buildingsPrice.id = :buildings_id and status = :status";
        }
        Query query = session.createQuery(hql);
        query.setParameter("buildings_id", buildings_id);
        if(status<2){
            query.setParameter("status",status);
        }
        query.setMaxResults(pager.getPageSize()); // 每页显示的个数
        query.setFirstResult(pager.getIndex());//当前页
        List<Message> commentList = query.list();
        pager.setResult(commentList);
        return pager;
    }

    @Override//某个楼盘下被冻结或激活的留言有多少个
    public long countMessageBuildings(String buildings_id, int status) {
        Session session = getSessionFactory().getCurrentSession();
        String hql = "select count(id) from Message  where buildingsPrice.id = :buildings_id ";
        if(status<2){
            hql ="select count(id) from Message  where buildingsPrice.id = :buildings_id and status = :status ";
        }
        Query query =session.createQuery(hql);
        query.setParameter("buildings_id",buildings_id);
        if(status<2){
            query.setParameter("status",status);
        }
        return (Long) query.uniqueResult();
    }

    @Override//分页查询经销商下的所有楼盘下被冻结或激活的留言有多少
    public Pager<Message> queryAllMessageAgency(Pager<Message> pager, String agency_id, int status) {
        Session session = getSessionFactory().getCurrentSession();
        String hql = "from Message   where  buildingsPrice.agencyPrice.id = :agency_id order by created_time desc ";
        if (status<2) {
            hql = "from Message   where  buildingsPrice.agencyPrice.id = :agency_id  and status = :status order by created_time desc";
        }
        Query query = session.createQuery(hql);
        query.setParameter("agency_id", agency_id);
        if (status<2) {
            query.setParameter("status", status);
        }
        query.setMaxResults(pager.getPageSize()); // 每页显示的个数
        query.setFirstResult(pager.getIndex());//当前页
        List<Message> messages = query.list();
        pager.setResult(messages);
        return pager;
    }

    @Override//查询经销商下的所有楼盘下被冻结或激活的留言有多少个
    public long countMessageAgency(String agency_id, int status) {
        Session session = getSessionFactory().getCurrentSession();
        String hql = "select count(id) from Message     where  buildingsPrice.agencyPrice.id = :agency_id ";
        if (status<2) {
            hql = "select count(id) from Message    where  buildingsPrice.agencyPrice.id = :agency_id and status = :status";
        }
        Query query = session.createQuery(hql);
        query.setParameter("agency_id", agency_id);
        if (status<2) {
            query.setParameter("status", status);
        }
        return (Long) query.uniqueResult();
    }

    @Override//批量冻结留言
    public void updateMessageStatus(String[] id, int status) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("update Message set status = :status  where   id  in  (:id)");
        query.setParameter("status", status);
        query.setParameterList("id", id);
        query.executeUpdate();
    }

    @Override//用户修改留言信息
    public void updateupdateMessageUser(Message message) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("update Message set content = :content,leave_time = :leave_time  where   id  = :id");
        query.setParameter("content", message.getContent());
        query.setParameter("leave_time", message.getLeave_time());
        query.setParameter("id", message.getId());
        query.executeUpdate();
    }

    @Override//楼盘回复留言内容
    public void updateupdateMessageBuildings(Message message) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("update Message set reply = :reply,reply_time = :reply_time,status = :status  where   id  = :id");
        query.setParameter("reply", message.getReply());
        query.setParameter("reply_time", message.getReply_time());
        query.setParameter("status", message.getStatus());
        query.setParameter("id", message.getId());
        query.executeUpdate();
    }

    @Override
    public void updateMessageContent(String content, String id) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("update Message set content = :content where id=:id");
        query.setParameter("content", content);
        query.setParameter("id", id);
        query.executeUpdate();

    }

    @Override
    public void updateMessageStatus(String id, int status) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("update Message set status = :status where id=:id");
        query.setParameter("status", status);
        query.setParameter("id", id);
        query.executeUpdate();
    }
}


