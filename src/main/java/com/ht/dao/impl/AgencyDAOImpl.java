package com.ht.dao.impl;

import com.ht.bean.Ads;
import com.ht.bean.Agency;
import com.ht.common.Content;
import com.ht.common.Pager;
import com.ht.dao.AbstractBaseDAO;
import com.ht.dao.AgencyDAO;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.List;


/**
 * Created by CHEN JX on 2017/8/23.
 * 房产经销商
 */
public class AgencyDAOImpl extends AbstractBaseDAO implements AgencyDAO{
    @Override
    public Agency queryById(String s) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from  Agency a where  a.id = :id  ");
        query.setParameter("id",s);
        Object obj = query.uniqueResult(); // 返回单个结果
        return obj != null ? (Agency) obj : null;
    }

    @Override
    public void add(Agency agency) {
        getSessionFactory().getCurrentSession().save(agency);
    }

    @Override
    public void remove(Agency agency) {
        getSessionFactory().getCurrentSession().remove(agency);
    }

    @Override
    public void update(Agency agency) {
        getSessionFactory().getCurrentSession().update(agency);
    }


    @Override
    public Pager<Agency> queryPager(Pager<Agency> pager) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Agency order by created_time desc");
        query.setFirstResult(pager.getPageSize());
        query.setMaxResults(pager.getIndex());
        pager.setResult(query.list());
        pager.setTotal(countAll(Content.CheckYes,Content.StatusYes));
        return pager;
    }

    @Override
    public List<Agency> queryAll() {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Agency order by created_time desc");
        List<Agency> list = query.list();
        return list;
    }

    @Override
    public int count() {
        return 0;
    }

    @Override//分页查询未审核或已审核的经销商
    public Pager<Agency> queryAllChecked(Pager<Agency> pager, int checked_status) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Agency a where  a.checked_status = :checked_status order by created_time desc");
        query.setParameter("checked_status", checked_status);
        query.setMaxResults(pager.getPageSize()); // 每页显示的个数
        query.setFirstResult(pager.getIndex());//当前页
        List<Agency> newss = query.list();
        pager.setResult(newss);
        pager.setTotal(countChecked(Content.CheckNo));
        return pager;
    }

    @Override
    public long countChecked(int checked_status) {//获取未审核或已审核的经销商一共有多少个
        Session session = getSessionFactory().getCurrentSession();
        long count = (Long) session.createQuery
                ("select count(id) from Agency a where  a.checked_status = " +checked_status+ "").uniqueResult();
        return count;
    }

    @Override
    public long countStatus(int status) {
        Session session = getSessionFactory().getCurrentSession();
        long num = (Long) session.createQuery("select count(id) from Agency ag where ag.status ="+status+"").uniqueResult();
        return num;
    }

    @Override
    public void updateChecked(String[] id, int checked_status) {//审核未审核的经销商
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("update Agency set checked_status = :checked_status  where  id  in  (:id)");
        query.setParameter("checked_status", checked_status);
        query.setParameterList("id", id);
        query.executeUpdate();
    }

    @Override
    public Pager<Agency> queryAllStatus(Pager<Agency> pager, int status) {
        Session session=getSessionFactory().getCurrentSession();
        Query query=session.createQuery("from Agency a where  a.status = :status order by created_time desc ");
        query.setParameter("status", status);
        query.setMaxResults(pager.getPageSize()); // 每页显示的个数
        query.setFirstResult(pager.getIndex());//当前页
        List<Agency> newss = query.list();
        pager.setResult(newss);
        pager.setTotal(countStatus(Content.StatusNo));
        return pager;
    }

    @Override
    public void updateStatus(String[] id, int status) {//激活和冻结经销商
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("update Agency set status = :status  where   id  in  (:id)");
        query.setParameter("status", status);
        query.setParameterList("id", id);
        query.executeUpdate();
    }

    @Override
    public long countAll(int checked_status, int status) {
        Session session = getSessionFactory().getCurrentSession();
        long all = (Long) session.createQuery("select count(id) from Agency a where a.checked_status ="+checked_status+" and a.status = " + status + "").uniqueResult();
        return all;
    }

    @Override
    public Pager<Agency> queryAllRight(Pager<Agency> pager, int checked_status, int status) {
        Session session=getSessionFactory().getCurrentSession();
        Query query=session.createQuery("from Agency a where  a.checked_status = :checked_status and a.status = :status order by created_time desc");
        query.setParameter("checked_status", checked_status);
        query.setParameter("status",status);
        query.setMaxResults(pager.getPageSize()); // 每页显示的个数
        query.setFirstResult(pager.getIndex());//当前页
        List<Agency> allRight = query.list();
        pager.setResult(allRight);
        pager.setTotal(countAll(Content.CheckYes,Content.StatusYes));
        return pager;
    }

    @Override
    public void updateAgency(Agency agency) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("update Agency  set  name = :name ," +
                " leader = :leader , tel = :tel, address = :address ,logo = :logo,intro = :intro,phone = :phone" +
                "  where  id = :id");
        query.setParameter("name", agency.getName());
        query.setParameter("leader", agency.getLeader());
        query.setParameter("tel", agency.getTel());
        query.setParameter("address", agency.getAddress());
        query.setParameter("logo", agency.getLogo());
        query.setParameter("phone", agency.getPhone());
        query.setParameter("intro", agency.getIntro());
        query.setParameter("id", agency.getId());
        query.executeUpdate();
    }

    @Override
    public void updateEmailPwd(String email, String pwd) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("update Agency set pwd = :pwd  where  email = :email");
        query.setParameter("pwd", pwd);
        query.setParameter("email", email);
        query.executeUpdate();
    }

    @Override
    public Agency queryEmailPwd(String email) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from  Agency a where  a.email = :email  ");
        query.setParameter("email",email);
        Object obj = query.uniqueResult(); // 返回单个结果
        return obj != null ? (Agency) obj : null;
    }

    @Override
    public Agency queryByPhone(String phone) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from  Agency a where  a.phone = :phone  ");
        query.setParameter("phone",phone);
        Object obj = query.uniqueResult(); // 返回单个结果
        return obj != null ? (Agency) obj : null;
    }

    @Override
    public Agency queryByName(String name) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from  Agency a where  a.name = :name  ");
        query.setParameter("name",name);
        Object obj = query.uniqueResult(); // 返回单个结果
        return obj != null ? (Agency) obj : null;
    }
}
