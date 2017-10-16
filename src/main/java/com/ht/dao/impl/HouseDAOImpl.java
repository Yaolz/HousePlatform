package com.ht.dao.impl;
import com.ht.bean.House;
import com.ht.common.Pager;
import com.ht.dao.AbstractBaseDAO;
import com.ht.dao.HouseDAO;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.query.Query;

import java.util.List;

/**
 * Created by CHEN JX on 2017/8/24.
 * 户型
 */
public class HouseDAOImpl extends AbstractBaseDAO implements HouseDAO{
    @Override
    public House queryById(String s) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from House  where id = :id ");
        query.setParameter("id",s);
        Object obj = query.uniqueResult(); // 返回单个结果
        return obj != null ? (House) obj : null;
    }

    @Override
    public void add(House house) {
        getSessionFactory().getCurrentSession().save(house);
    }

    @Override
    public void remove(House house) {
        getSessionFactory().getCurrentSession().remove(house);
    }

    @Override
    public void update(House house) {
        getSessionFactory().getCurrentSession().update(house);
    }

    @Override
    public Pager<House> queryPager(Pager<House> pager) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from House where status=1 order by created_time desc");
        query.setFirstResult(pager.getIndex());
        query.setMaxResults(pager.getPageSize());
        pager.setResult(query.list());
        pager.setTotal(countId());
        return pager;
    }

    @Override
    public List<House> queryAll() {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from House order by created_time desc");
        List<House> list = query.list();
        return list;
    }

    @Override
    public int count() {
        return 0;
    }

    @Override//修改户型的方法
    public void updateHouse(House house) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("update House set name = :name,logo = :logo," +
                "intro = :intro,area = :area,unit_price = :unit_price  where  id = :id");
        query.setParameter("name", house.getName());
        query.setParameter("logo", house.getLogo());
        query.setParameter("intro", house.getIntro());
        query.setParameter("area", house.getArea());
        query.setParameter("unit_price", house.getUnit_price());
        query.setParameter("id", house.getId());
        query.executeUpdate();
    }

    @Override//分页查询某个楼盘的户型
    public Pager<House> queryAllHouse(Pager<House> pager, String buildings_id) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from House b where  b.buildingsPrice.id = :buildings_id order by created_time desc ");
        query.setParameter("buildings_id", buildings_id);
        query.setMaxResults(pager.getPageSize()); // 每页显示的个数
        query.setFirstResult(pager.getIndex());//当前页
        List<House> houses =null;
        if(query.list() !=null){
            houses = query.list();
        }
        pager.setResult(houses);
        pager.setTotal(countHouse(buildings_id));//查询某个楼盘的户型有多少个
        return pager;
    }

    @Override//查询某个楼盘的户型有多少个
    public long countHouse(String buildings_id) {
        Session session = getSessionFactory().getCurrentSession();
        Query query =session.createQuery
                ("select count(id) from House   b  where  b.buildingsPrice.id = :buildings_id");
        query.setParameter("buildings_id",buildings_id);
        return (Long) query.uniqueResult();
    }

    @Override//分页查询某个楼盘被冻结或激活的户型
    public Pager<House> queryAllHouseStatus(Pager<House> pager, String buildings_id, int status) {
        Session session = getSessionFactory().getCurrentSession();
        String hql = "from House b where  b.buildingsPrice.id = :buildings_id  order by created_time desc";
        if(status<2){
            hql = "from House b where  b.buildingsPrice.id = :buildings_id  and b.status = :status order by created_time desc";
        }
        Query query = session.createQuery(hql);
        query.setParameter("buildings_id", buildings_id);
        if(status<2){
            query.setParameter("status", status);
        }
        query.setMaxResults(pager.getPageSize()); // 每页显示的个数
        query.setFirstResult(pager.getIndex());//当前页
        List<House> houses = query.list();
        pager.setResult(houses);
        pager.setTotal(countHouse(buildings_id));//查询某个楼盘的户型有多少个
        return pager;
    }

    @Override//查询某个楼盘被冻结或激活的户型有多少个
    public long countHouseStatus(String buildings_id, int status) {
        Session session = getSessionFactory().getCurrentSession();
        String hql = "select count(id) from House   b  where  b.buildingsPrice.id = :buildings_id";
        if(status<2){
            hql = "select count(id) from House   b  where  b.buildingsPrice.id = :buildings_id and b.status = :status";
        }
        Query query =session.createQuery(hql);
        query.setParameter("buildings_id",buildings_id);
        if(status<2){
            query.setParameter("status", status);
        }
        return (Long) query.uniqueResult();
    }

    @Override
    public void updateStatus(String[] id, int status) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("update House set status = :status  where   id  in  (:id)");
        query.setParameter("status", status);
        query.setParameterList("id", id);
        query.executeUpdate();
    }

    @Override
    public long countId() {
        Session session=getSessionFactory().openSession();
        long count = (Long) session.createQuery("select count(id) from House").uniqueResult();
        return count;
    }

    @Override
    public List<House> queryByHouse(List<String> list) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from House  where id in (:id) ");
        query.setParameterList("id",list);
        List<House> houses = query.list();
        return houses;
    }

    @Override//分页查询经销商下所有被冻结或激活的户型
    public Pager<House> queryAllHouseAgencyStatus(Pager<House> pager, String agency_id, int status) {
        Session session = getSessionFactory().getCurrentSession();
        String hql = "from House b where  b.buildingsPrice.agencyPrice.id = :agency_id  order by created_time desc";
        if(status<2){
            hql = "from House b where  b.buildingsPrice.agencyPrice.id = :agency_id  and b.status = :status order by created_time desc";
        }
        Query query = session.createQuery(hql);
        query.setParameter("agency_id", agency_id);
        if(status<2){
            query.setParameter("status", status);
        }
        query.setMaxResults(pager.getPageSize()); // 每页显示的个数
        query.setFirstResult(pager.getIndex());//当前页
        List<House> houses = query.list();
        pager.setResult(houses);
        pager.setTotal(countHouseAgencyStatus(agency_id,status));//查询某个楼盘的户型有多少个
        return pager;
    }

    @Override//查询经销商下所有被冻结或激活的户型有多少个
    public long countHouseAgencyStatus(String agency_id, int status) {
        Session session = getSessionFactory().getCurrentSession();
        String hql = "select count(id) from House   b  where  b.buildingsPrice.agencyPrice.id = :agency_id";
        if(status<2){
            hql = "select count(id) from House   b  where  b.buildingsPrice.agencyPrice.id = :agency_id and b.status = :status";
        }
        Query query =session.createQuery(hql);
        query.setParameter("agency_id",agency_id);
        if(status<2){
            query.setParameter("status", status);
        }
        return (Long) query.uniqueResult();
    }

    @Override
    public Pager<House> queryAllindex(Pager<House> pager, double unit_price, double unit_price1, double area, double area1, String like) {
        Session session = getSessionFactory().getCurrentSession();
        Criteria criteria = session.createCriteria(House.class); // 基于对象的条件查询
        criteria.add(Restrictions.eq("status",1));
        if(unit_price!=0&&unit_price1!=0){
            if(unit_price>=30000){
                criteria.add(Restrictions.ge("unit_price",new Double(unit_price)));
            }else {
                criteria.add(Restrictions.between("unit_price",new Double(unit_price),new Double(unit_price1)));
            }
        }
        if(area!=0&&area1!=0){
            if(area>=300){
                criteria.add(Restrictions.ge("area",new Double(area)));
            }else {
                criteria.add(Restrictions.between("area",new Double(area),new Double(area1)));
            }
        }
        if(like!=null&&!like.equals("")&&!like.equals("undefined")&&!like.contains(" ")){
            criteria.add(Restrictions.like("name", "%"+like+"%"));
        }
        criteria.setMaxResults(pager.getPageSize()); // 每页显示的个数
        criteria.setFirstResult(pager.getIndex());//当前页
        criteria.addOrder(Order.desc("created_time"));//根据名字升序排列
        List<House> houses = criteria.list();
        pager.setResult(houses);
        return pager;
    }

    @Override
    public long countAllindex(double unit_price, double unit_price1, double area, double area1, String like) {
        Session session = getSessionFactory().getCurrentSession();
        Criteria criteria = session.createCriteria(House.class); // 基于对象的条件查询
        criteria.add(Restrictions.eq("status",1));
        if(unit_price!=0&&unit_price1!=0){
            if(unit_price>=30000){
                criteria.add(Restrictions.ge("unit_price",new Double(unit_price)));
            }else {
                criteria.add(Restrictions.between("unit_price",new Double(unit_price),new Double(unit_price1)));
            }
        }
        if(area!=0&&area1!=0){
            if(area>=300){
                criteria.add(Restrictions.ge("area",new Double(area)));
            }else {
                criteria.add(Restrictions.between("area",new Double(area),new Double(area1)));
            }
        }
        if(like!=null&&!like.equals("")&&!like.equals("undefined")&&!like.contains(" ")){
            criteria.add(Restrictions.like("name", "%"+like+"%"));
        }
        criteria.setProjection(Projections.rowCount());
        long count =   Long.parseLong(criteria.uniqueResult().toString());
        return count;
    }
}
