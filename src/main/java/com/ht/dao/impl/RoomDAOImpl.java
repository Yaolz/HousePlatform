package com.ht.dao.impl;

import com.ht.bean.Message;
import com.ht.bean.Role;
import com.ht.bean.Room;
import com.ht.common.Pager;
import com.ht.dao.AbstractBaseDAO;
import com.ht.dao.RoomDAO;
import org.hibernate.Session;
import org.hibernate.query.Query;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by CHEN JX on 2017/8/24.
 * 房号
 */
public class RoomDAOImpl extends AbstractBaseDAO implements RoomDAO{
    @Override
    public Room queryById(String s) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Room  where id = :id ");
        query.setParameter("id",s);
        Object obj = query.uniqueResult(); // 返回单个结果
        return obj != null ? (Room) obj : null;
    }

    @Override
    public void add(Room room) {
        getSessionFactory().getCurrentSession().save(room);
    }

    @Override
    public void remove(Room room) {
        getSessionFactory().getCurrentSession().remove(room);
    }

    @Override
    public void update(Room room) {
        getSessionFactory().getCurrentSession().update(room);
    }

    @Override
    public Pager<Room> queryPager(Pager<Room> pager) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Room order by name asc");
        query.setFirstResult(pager.getIndex());
        query.setMaxResults(pager.getPageSize());
        pager.setResult(query.list());
        return pager;
    }

    @Override
    public List<Room> queryAll() {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Room order by name asc");
        List<Room> list = query.list();
        return list;
    }

    @Override
    public int count() {
        return 0;
    }

    @Override
    public Pager<Room> queryPagers(Pager<Room> pager, String building_id) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Room where building.id = :building_id order by name asc");
        query.setParameter("building_id",building_id);
        query.setFirstResult(pager.getIndex());
        query.setMaxResults(pager.getPageSize());
        pager.setResult(query.list());
        pager.setTotal(countRoom(building_id));
        return pager;
    }

    @Override
    public Pager<Room> queryRoomPagers(Pager<Room> pager, String id) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Room where id = :id order by name asc");
        query.setParameter("id",id);
        query.setFirstResult(pager.getIndex());
        query.setMaxResults(pager.getPageSize());
        pager.setResult(query.list());
        pager.setTotal(countRoom(id));
        return pager;
    }

    @Override
    public long countRoom(String building_id) {
        Session session = getSessionFactory().getCurrentSession();
        Query query=session.createQuery ("select count(id) from Room a where  a.building.id = :building_id");
        query.setParameter("building_id",building_id);
        long count = (Long) query.uniqueResult();
        return count;
    }

    @Override//查询某个楼栋用的户型有哪些
    public List<String> queryHouseId(String building_id) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createNativeQuery("select house_id from t_room where building_id = :building_id group by house_id");
        query.setParameter("building_id",building_id);
        List<Object> objects = query.list(); // 此对象存储每一行记录查询出的字段object[0] name， object[1] price
        List<String> list = new ArrayList<>();
        for (Object objArray : objects) {
            list.add((String) objArray);
        }
        return list;
    }

    @Override
    public void deleteBuilding(String building_id) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("delete from Room where building.id = :building_id");
        query.setParameter("building_id",building_id);
        query.executeUpdate();
    }

    @Override//分页查询经销商下的所有房间
    public Pager<Room> AllAgencyRoom(Pager<Room> pager, String agency_id, int sale_status) {
        Session session = getSessionFactory().getCurrentSession();
        String hql = "from Room where building.buildingsPrice.agencyPrice.id = :agency_id  order by name asc";
        if(sale_status<5){
           hql ="from Room where building.buildingsPrice.agencyPrice.id = :agency_id  and  sale_status = :sale_status  order by name desc";
        }
        Query query = session.createQuery(hql);
        query.setParameter("agency_id",agency_id);
        if(sale_status<5){
            query.setParameter("sale_status",sale_status+"");
        }
        query.setFirstResult(pager.getIndex());
        query.setMaxResults(pager.getPageSize());
        List<Room> rooms = query.list();
        for (Room room :rooms){
            room.setCount(room.getSale().size());
        }
        pager.setResult(rooms);
        return pager;
    }

    @Override//查询经销商下的房间有多少个
    public long countAgencyRoom(String agency_id, int sale_status) {
        Session session = getSessionFactory().getCurrentSession();
        String hql = "select count(id) from Room   where  building.buildingsPrice.agencyPrice.id = :agency_id";
        if(sale_status<5){
            hql = "select count(id) from Room   where  building.buildingsPrice.agencyPrice.id = :agency_id and sale_status = :sale_status ";
        }
        Query query=session.createQuery (hql);
        query.setParameter("agency_id",agency_id);
        if(sale_status<5){
            query.setParameter("sale_status",sale_status+"");
        }
        long count = (Long) query.uniqueResult();
        return count;
    }

    @Override//分页查询某个楼盘下的房间有多少
    public Pager<Room> AllBuildingsRoom(Pager<Room> pager, String buildings_id, int sale_status) {
        Session session = getSessionFactory().getCurrentSession();
        String hql = "from Room where building.buildingsPrice.id = :buildings_id  order by name asc";
        if(sale_status<5){
            hql ="from Room where building.buildingsPrice.id = :buildings_id  and  sale_status = :sale_status  order by name desc";
        }
        Query query = session.createQuery(hql);
        query.setParameter("buildings_id",buildings_id);
        if(sale_status<5){
            query.setParameter("sale_status",sale_status+"");
        }
        query.setFirstResult(pager.getIndex());
        query.setMaxResults(pager.getPageSize());
        List<Room> rooms = query.list();
        for (Room room :rooms){
            room.setCount(room.getSale().size());
        }
        pager.setResult(rooms);
        return pager;
    }

    @Override//查询楼盘下的房间有多少个
    public long countBuildingsRoom(String buildings_id, int sale_status) {
        Session session = getSessionFactory().getCurrentSession();
        String hql = "select count(id) from Room   where  building.buildingsPrice.id = :buildings_id";
        if(sale_status<5){
            hql = "select count(id) from Room   where  building.buildingsPrice.id = :buildings_id and sale_status = :sale_status ";
        }
        Query query=session.createQuery (hql);
        query.setParameter("buildings_id",buildings_id);
        if(sale_status<5){
            query.setParameter("sale_status",sale_status+"");
        }
        long count = (Long) query.uniqueResult();
        return count;
    }

    @Override//分页查询楼栋下的房间有多少
    public Pager<Room> AllBuildingRoom(Pager<Room> pager, String building_id, int sale_status) {
        Session session = getSessionFactory().getCurrentSession();
        String hql = "from Room where building.id = :building_id  order by name asc";
        if(sale_status<5){
            hql ="from Room where building.id = :building_id  and  sale_status = :sale_status  order by name desc";
        }
        Query query = session.createQuery(hql);
        query.setParameter("building_id",building_id);
        if(sale_status<5){
            query.setParameter("sale_status",sale_status+"");
        }
        query.setFirstResult(pager.getIndex());
        query.setMaxResults(pager.getPageSize());
        List<Room> rooms = query.list();
        for (Room room :rooms){
            room.setCount(room.getSale().size());
        }
        pager.setResult(rooms);
        return pager;
    }

    @Override//查询楼栋下的房间有多少个
    public long countBuildingRoom(String building_id, int sale_status) {
        Session session = getSessionFactory().getCurrentSession();
        String hql = "select count(id) from Room   where  building.id = :building_id";
        if(sale_status<5){
            hql = "select count(id) from Room   where  building.id = :building_id and sale_status = :sale_status ";
        }
        Query query=session.createQuery (hql);
        query.setParameter("building_id",building_id);
        if(sale_status<5){
            query.setParameter("sale_status",sale_status+"");
        }
        long count = (Long) query.uniqueResult();
        return count;
    }

    @Override//批量修改房屋状态
    public void updateSaleStatus(String[] id, int sale_status) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("update Room set sale_status = :sale_status  where   id  in  (:id)");
        query.setParameter("sale_status", sale_status+"");
        query.setParameterList("id", id);
        query.executeUpdate();
    }
}
