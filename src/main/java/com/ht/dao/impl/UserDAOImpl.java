package com.ht.dao.impl;

import com.ht.bean.User;
import com.ht.common.Content;
import com.ht.common.EncriptUtil;
import com.ht.common.Pager;
import com.ht.dao.AbstractBaseDAO;
import com.ht.dao.UserDAO;
import com.ht.price.UserPrice;
import org.hibernate.Session;
import org.hibernate.query.Query;

import java.util.List;

/**
 * Created by CHEN JX on 2017/8/24.
 * 用户
 */
public class UserDAOImpl extends AbstractBaseDAO implements UserDAO {
    @Override
    public User queryById(String s) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from User  where id = :id ");
        query.setParameter("id",s);
        Object obj = query.uniqueResult(); // 返回单个结果
        return obj != null ? (User) obj : null;
    }

    @Override
    public void add(User user) {
        getSessionFactory().getCurrentSession().save(user);
    }

    @Override
    public void remove(User user) {
        getSessionFactory().getCurrentSession().remove(user);
    }

    @Override
    public void update(User user) {
        getSessionFactory().getCurrentSession().update(user);
    }

    @Override
    public Pager<User> queryPager(Pager<User> pager) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from User");
        query.setFirstResult(pager.getIndex());
        query.setMaxResults(pager.getPageSize());
        pager.setResult(query.list());
        pager.setTotal(countId());
        return pager;
    }

    @Override
    public List<User> queryAll() {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from User");
        List<User> list = query.list();
        return list;
    }

    @Override
    public int count() {
        return 0;
    }

    @Override
    public long countId() {
        Session session = getSessionFactory().getCurrentSession();
        long count = (Long) session.createQuery("select count(id) from User ").uniqueResult();
        return count;
    }

    @Override
    public User queryEmailPwd(String email) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from User  where email = :email ");
        query.setParameter("email",email);
        Object obj = query.uniqueResult(); // 返回单个结果
        return obj != null ? (User) obj : null;
    }

    @Override
    public void updateStatusById(String[] id, int status) {
        Session session=getSessionFactory().getCurrentSession();
        Query query=session.createQuery("update User set status = :status where   id  in (:id)");
        query.setParameter("status",status);
        query.setParameterList("id", id);
        query.executeUpdate();
    }

    @Override
    public Pager<User> queryPagerStatus(Pager<User> pager, int status) {
        Session session = getSessionFactory().getCurrentSession();
        String hql="from User";
        if(status== Content.CheckYes){
            hql="from User where status=1";
        } else if(status== Content.CheckNo) {
            hql="from User where status=0";
        }
        Query query = session.createQuery(hql);
        query.setParameter("status",status);
        query.setFirstResult(pager.getIndex());
        query.setMaxResults(pager.getPageSize());
        pager.setResult(query.list());
        return pager;
    }

    @Override
    public User queryByPhone(String phone) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from User  where phone = :phone ");
        query.setParameter("phone",phone);
        Object obj = query.uniqueResult(); // 返回单个结果
        return obj != null ? (User) obj : null;
    }

    @Override
    public User queryByNickname(String nickname) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from User  where nickname = :nickname ");
        query.setParameter("nickname",nickname);
        Object obj = query.uniqueResult(); // 返回单个结果
        return obj != null ? (User) obj : null;
    }

    @Override
    public void updatePwd(String pwd,String user_id) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("update User set pwd = :pwd where id = :id");
        query.setParameter("pwd", pwd);
        query.setParameter("id",user_id);
        query.executeUpdate();

    }

    @Override
    public void updateUser(User user) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("update User set phone = :phone," +
                "qq = :qq,wechat = :wechat,gender = :gender, birthday = :birthday,nickname = :nickname,name = :name" +
                ",headicon = :headicon" +
                "  where  id = :id");
        query.setParameter("phone", user.getPhone());
        query.setParameter("qq",user.getQq());
        query.setParameter("wechat",user.getWechat());
        query.setParameter("gender", user.getGender());
        query.setParameter("birthday", user.getBirthday());
        query.setParameter("nickname", user.getNickname());
        query.setParameter("name", user.getName());
        query.setParameter("headicon", user.getHeadicon());
        query.setParameter("id", user.getId());
        query.executeUpdate();
    }
}
