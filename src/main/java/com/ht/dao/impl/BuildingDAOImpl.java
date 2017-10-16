package com.ht.dao.impl;

import com.ht.bean.ArticleType;
import com.ht.bean.Building;
import com.ht.bean.House;
import com.ht.common.Pager;
import com.ht.dao.AbstractBaseDAO;
import com.ht.dao.BuildingDAO;
import com.sun.org.apache.bcel.internal.generic.GETFIELD;
import org.hibernate.Session;
import org.hibernate.query.Query;

import java.util.List;

/**
 * Created by CHEN JX on 2017/8/23.
 * 楼栋
 */
public class BuildingDAOImpl extends AbstractBaseDAO implements BuildingDAO{
    @Override
    public Building queryById(String s) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Building  where id = :id ");
        query.setParameter("id",s);
        Object obj = query.uniqueResult(); // 返回单个结果
        return obj != null ? (Building) obj : null;
    }

    @Override
    public void add(Building building) {
        getSessionFactory().getCurrentSession().save(building);
    }

    @Override
    public void remove(Building building) {
        getSessionFactory().getCurrentSession().save(building);
    }

    @Override
    public void update(Building building) {
        getSessionFactory().getCurrentSession().save(building);
    }

    @Override
    public Pager<Building> queryPager(Pager<Building> pager) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Building order by created_time desc");
        query.setFirstResult(pager.getIndex());
        query.setMaxResults(pager.getPageSize());
        pager.setResult(query.list());
        return pager;
    }

    @Override
    public List<Building> queryAll() {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Building order by created_time desc");
        List<Building> list = query.list();
        return list;
    }

    @Override
    public int count() {
        return 0;
    }

    @Override//修改楼栋信息
    public void updateBuilding(Building building) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("update Building set name = :name,total_floor = :total_floor," +
                "total_lift = :total_lift,floor_rooms = :floor_rooms,total_room = :total_room  where  id = :id");
        query.setParameter("name", building.getName());
        query.setParameter("total_floor", building.getTotal_floor());
        query.setParameter("total_lift", building.getTotal_lift());
        query.setParameter("floor_rooms", building.getFloor_rooms());
        query.setParameter("total_room", building.getTotal_room());
        query.setParameter("id", building.getId());
        query.executeUpdate();
    }

    @Override//分页查询某个楼盘的楼栋
    public Pager<Building> queryAllBuilding(Pager<Building> pager, String buildings_id) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Building b where  b.buildingsPrice.id = :buildings_id  order by created_time desc ");
        query.setParameter("buildings_id", buildings_id);
        query.setMaxResults(pager.getPageSize()); // 每页显示的个数
        query.setFirstResult(pager.getIndex());//当前页
        List<Building> buildings = query.list();
        pager.setResult(buildings);
        pager.setTotal(countBuilding(buildings_id));//查询某个楼盘的户型有多少个
        return pager;
    }

    @Override//查询某个楼盘的楼栋有多少个
    public long countBuilding(String buildings_id) {
        Session session = getSessionFactory().getCurrentSession();
        Query query =session.createQuery
                ("select count(id) from Building   b  where  b.buildingsPrice.id = :buildings_id");
        query.setParameter("buildings_id",buildings_id);
        return (Long) query.uniqueResult();
    }

    @Override//分页查询某个楼盘下被冻结或激活的楼栋
    public Pager<Building> queryAllBuildingStatus(Pager<Building> pager, String buildings_id, int status) {
        Session session = getSessionFactory().getCurrentSession();
        String hql = "from Building b where  b.buildingsPrice.id = :buildings_id  order by created_time desc ";
        if(status<2){
            hql = "from Building b where  b.buildingsPrice.id = :buildings_id  and b.status = :status order by created_time desc";
        }
        Query query = session.createQuery(hql);
        query.setParameter("buildings_id", buildings_id);
        if(status<2){
            query.setParameter("status", status);
        }
        query.setMaxResults(pager.getPageSize()); // 每页显示的个数
        query.setFirstResult(pager.getIndex());//当前页
        List<Building> buildings = query.list();
        pager.setResult(buildings);
        pager.setTotal(countBuildingStatus(buildings_id,status));//查询某个楼盘的户型有多少个
        return pager;
    }

    @Override//查询某个楼盘下被冻结或激活的楼栋有多少个
    public long countBuildingStatus(String buildings_id, int status) {
        Session session = getSessionFactory().getCurrentSession();
        String hql = "select count(id) from Building   b  where  b.buildingsPrice.id = :buildings_id ";
        if(status<2){
            hql = "select count(id) from Building   b  where  b.buildingsPrice.id = :buildings_id and b.status = :status";
        }
        Query query =session.createQuery(hql);
        query.setParameter("buildings_id",buildings_id);
        if(status<2){
            query.setParameter("status", status);
        }
        return (Long) query.uniqueResult();
    }

    @Override//批量冻结或激活
    public void updateBuildingStatus(String[] id, int status) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("update Building set status = :status  where   id  in  (:id)");
        query.setParameter("status", status);
        query.setParameterList("id", id);
        query.executeUpdate();
    }

    @Override
    public Pager<Building> queryAllBuildingAgencyStatus(Pager<Building> pager, String agency_id, int status) {
        Session session = getSessionFactory().getCurrentSession();
        String hql = "from Building b where  b.buildingsPrice.agencyPrice.id = :agency_id  order by created_time desc ";
        if(status<2){
            hql = "from Building b where  b.buildingsPrice.agencyPrice.id = :agency_id  and b.status = :status order by created_time desc";
        }
        Query query = session.createQuery(hql);
        query.setParameter("agency_id", agency_id);
        if(status<2){
            query.setParameter("status", status);
        }
        query.setMaxResults(pager.getPageSize()); // 每页显示的个数
        query.setFirstResult(pager.getIndex());//当前页
        List<Building> buildings = query.list();
        pager.setResult(buildings);
        pager.setTotal(countBuildingAgencyStatus(agency_id,status));//查询某个楼盘的户型有多少个
        return pager;
    }

    @Override
    public long countBuildingAgencyStatus(String agency_id, int status) {
        Session session = getSessionFactory().getCurrentSession();
        String hql = "select count(id) from Building   b  where  b.buildingsPrice.agencyPrice.id = :agency_id ";
        if(status<2){
            hql = "select count(id) from Building   b  where  b.buildingsPrice.agencyPrice.id = :agency_id and b.status = :status";
        }
        Query query =session.createQuery(hql);
        query.setParameter("agency_id",agency_id);
        if(status<2){
            query.setParameter("status", status);
        }
        return (Long) query.uniqueResult();
    }
}
