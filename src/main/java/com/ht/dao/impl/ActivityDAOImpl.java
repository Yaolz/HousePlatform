package com.ht.dao.impl;

import com.ht.bean.Activity;
import com.ht.common.Pager;
import com.ht.dao.AbstractBaseDAO;
import com.ht.dao.ActivityDAO;
import org.hibernate.Session;
import org.hibernate.query.Query;

import java.util.List;

/**
 * Created by CHEN JX on 2017/8/23.
 * 活动
 */
public class ActivityDAOImpl extends AbstractBaseDAO implements ActivityDAO {
    @Override
    public Activity queryById(String id) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Activity  where id = :id ");
        query.setParameter("id",id);
        Object obj = query.uniqueResult(); // 返回单个结果
        return obj != null ? (Activity) obj : null;
    }

    @Override
    public void add(Activity activity) {
        getSessionFactory().getCurrentSession().save(activity);
    }

    @Override
    public void remove(Activity activity) {
        getSessionFactory().getCurrentSession().remove(activity);
    }

    @Override
    public void update(Activity activity) {
        getSessionFactory().getCurrentSession().update(activity);

    }

    @Override
    public Pager<Activity> queryPager(Pager<Activity> pager) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Activity order by start_time desc");
        query.setMaxResults(pager.getPageSize()); // 每页显示的个数
        query.setFirstResult(pager.getIndex());//当前页
        List<Activity> list = query.list();
        pager.setResult(list);
        pager.setTotal(countId());
        return pager;
    }

    @Override
    public List<Activity> queryAll() {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Activity order by start_time desc");
        List<Activity> list = query.list();
        return list;
    }

    @Override
    public int count() {
        return 0;
    }

    @Override
    public long countId() {
        Session session = getSessionFactory().getCurrentSession();
        long count = (Long) session.createQuery("select count(id) from Activity ").uniqueResult();
        return count;
    }

    @Override
    public Pager<Activity> queryPagers(Pager<Activity> pager, String agency_id) {
        Session session = getSessionFactory().getCurrentSession();
        String hql = "from Activity where agencyPrice.id is null order by start_time desc";
        if (agency_id != null) { 
            hql = "from Activity where agencyPrice.id = :agency_id order by start_time desc";
        }
        Query query = session.createQuery(hql);
        if (agency_id != null) {
            query.setParameter("agency_id", agency_id);
        }
        query.setFirstResult(pager.getIndex());
        query.setMaxResults(pager.getPageSize());
        List<Activity> activities = query.list();
        pager.setResult(activities);
        pager.setTotal(countId());
        return pager;
    }

    @Override
    public void updateStatusById(String[] id, int status) {
        Session session=getSessionFactory().getCurrentSession();
        Query query=session.createQuery("update Activity set status = :status where id in (:id)");
        query.setParameter("status",status);
        query.setParameterList("id", id);
        query.executeUpdate();
    }

    @Override
    public Pager<Activity> queryPagerByStatus(Pager<Activity> pager, String agency_id, int status) {
        Session session = getSessionFactory().getCurrentSession();
        String  hql = "from Activity where agencyPrice.id = :agency_id  order by start_time desc";
        if(status<2){
            hql = "from Activity where agencyPrice.id = :agency_id and status = :status order by start_time desc";
        }
        Query query = session.createQuery(hql);
        query.setParameter("agency_id", agency_id);
        if(status<2){
            query.setParameter("status", status);
        }
        query.setMaxResults(pager.getPageSize()); // 每页显示的个数
        query.setFirstResult(pager.getIndex());//当前页
        List<Activity> list = query.list();
        pager.setResult(list);
        pager.setTotal(countActivityStatus(agency_id,status));
        return pager;
    }

    @Override
    public long countActivityStatus(String agency_id, int status) {
        Session session = getSessionFactory().getCurrentSession();
        String hql = "select count(id) from Activity  b  where  b.agencyPrice.id = :agency_id";
        if(status <2){
            hql = "select count(id) from Activity  b  where  b.agencyPrice.id = :agency_id and b.status = :status";
        }
        Query query =session.createQuery(hql);
        query.setParameter("agency_id",agency_id);
        if(status < 2){
            query.setParameter("status", status);
        }
        return (Long) query.uniqueResult();
    }

    @Override//分页查询某个楼盘下的活动
    public Pager<Activity> queryPagerByBuildings(Pager<Activity> pager, String buildings_id, int status) {
        Session session = getSessionFactory().getCurrentSession();
        String  hql = "from Activity where buildingsPrice.id = :buildings_id  order by start_time desc";
        if(status <2){
            hql = "from Activity where buildingsPrice.id = :buildings_id and status = :status order by start_time desc";
        }
        Query query = session.createQuery(hql);
        query.setParameter("buildings_id", buildings_id);
        if(status <2){
            query.setParameter("status", status);
        }
        query.setMaxResults(pager.getPageSize()); // 每页显示的个数
        query.setFirstResult(pager.getIndex());//当前页
        List<Activity> list = query.list();
        pager.setResult(list);
        pager.setTotal(countActivityBuildings(buildings_id,status));
        return pager;
    }

    @Override//查询所有楼盘下的员工有多少个
    public long countActivityBuildings(String buildings_id, int status) {
        Session session = getSessionFactory().getCurrentSession();
        String hql = "select count(id) from Activity  b  where  b.buildingsPrice.id = :buildings_id";
        if(status <2){
            hql = "select count(id) from Activity  b  where  b.buildingsPrice.id = :buildings_id and b.status = :status";
        }
        Query query =session.createQuery(hql);
        query.setParameter("buildings_id",buildings_id);
        if(status < 2){
            query.setParameter("status", status);
        }
        return (Long) query.uniqueResult();
    }

    @Override
    public void updateActivity(Activity activity) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("update Activity set title = :title,start_time = :start_time," +
                "end_time = :end_time,address = :address,content = :content,logo = :logo  where  id = :id");
        query.setParameter("title", activity.getTitle());
        query.setParameter("start_time", activity.getStart_time());
        query.setParameter("end_time", activity.getEnd_time());
        query.setParameter("address", activity.getAddress());
        query.setParameter("content", activity.getContent());
        query.setParameter("logo", activity.getLogo());
        query.setParameter("id", activity.getId());
        query.executeUpdate();
    }

    @Override
    public Activity queryByBuildingsId(String id) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Activity where status = 1 and buildingsPrice.id = :id order by start_time desc");
        query.setParameter("id",id);
        List<Activity> list = query.list();
        return list.get(0);
    }
}
