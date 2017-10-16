package com.ht.dao.impl;

import com.ht.bean.Buildings;
import com.ht.common.Pager;
import com.ht.dao.AbstractBaseDAO;
import com.ht.dao.BuildingsDAO;
import com.ht.price.BuildingsPrice;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.query.Query;

import java.util.List;

/**
 * Created by CHEN JX on 2017/8/23.
 * 楼盘
 */
public class BuildingsDAOImpl extends AbstractBaseDAO implements BuildingsDAO{
    @Override
    public Buildings queryById(String s) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Buildings  where id = :id ");
        query.setParameter("id",s);
        Object obj = query.uniqueResult(); // 返回单个结果
        return obj != null ? (Buildings) obj : null;
    }

    @Override
    public void add(Buildings buildings) {
        getSessionFactory().getCurrentSession().save(buildings);
    }

    @Override
    public void remove(Buildings buildings) {
        getSessionFactory().getCurrentSession().remove(buildings);
    }

    @Override
    public void update(Buildings buildings) {
        getSessionFactory().getCurrentSession().update(buildings);
    }

    @Override
    public Pager<Buildings> queryPager(Pager<Buildings> pager) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Buildings b order by b.created_time desc");
        query.setFirstResult(pager.getPageSize());
        query.setMaxResults(pager.getIndex());
        pager.setResult(query.list());
        return pager;
    }

    @Override
    public List<Buildings> queryAll() {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Buildings b order by b.created_time desc");
        List<Buildings> list = query.list();
        return list;
    }


    @Override
    public int count() {
        Session session = getSessionFactory().getCurrentSession();
        Object obj = session.createQuery("select count(id) from Buildings").uniqueResult();
        int count = Integer.parseInt(obj.toString());
        return count;
    }

    @Override
    public Pager<Buildings> queryStatusAll(Pager<Buildings> pager, int status,String name) {
        Session session = getSessionFactory().getCurrentSession();
        String hql = "from Buildings b where  b.status = :status order by b.created_time desc";
        if(name!=null&&!name.equals("")&&!name.equals("undefined")&&!name.contains(" ")){
            hql = "from Buildings b where  b.status = :status and b.name like :name order by b.created_time desc";
        }
        Query query = session.createQuery(hql);
        query.setParameter("status", status);
        if(name!=null&&!name.equals("")&&!name.equals("undefined")&&!name.contains(" ")){
            query.setParameter("name", name + "%");
        }
        query.setMaxResults(pager.getPageSize()); // 每页显示的个数
        query.setFirstResult(pager.getIndex());//当前页
        List<Buildings> buildings = query.list();
        pager.setResult(buildings);
        pager.setTotal(count(name));
        return pager;
    }

    @Override
    public long count(String name) {
        Session session = getSessionFactory().getCurrentSession();
        String hql = "select count(id) from Buildings";
        if(name!=null&&!name.equals("")&&!name.equals("undefined")&&!name.contains(" ")){
            hql = "select count(id) from Buildings where name like :name";
        }
        Query query = session.createQuery(hql);
        if(name!=null&&!name.equals("")&&!name.equals("undefined")&&!name.contains(" ")){
            query.setParameter("name", "%"+name + "%");
        }
        Object obj = query.uniqueResult();
        int count = Integer.parseInt(obj.toString());
        return count;
    }

    @Override
    public void updateBuildings(Buildings buildings) {//修改楼盘信息
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("update Buildings  set  name = :name," +
                " area = :area,address = :address,floor_area = :floor_area,building_area = :building_area,house_type = :house_type" +
                ",building_type = :building_type,longitude = :longitude,latitude = :latitude,avg_price = :avg_price,company = :company" +
                ",open_date = :open_date,reception_address = :reception_address,total_rooms = :total_rooms" +
                ",tel = :tel,green_ratio = :green_ratio,plot_ratio = :plot_ratio,property_company = :property_company" +
                ",property_fee = :property_fee,car_station = :car_station,traffic = :traffic,equipments = :equipments" +
                ",logo = :logo,intro = :intro,province = :province,city = :city  where  id = :id");
        query.setParameter("name", buildings.getName());//楼盘名称
        query.setParameter("area", buildings.getArea());//所属区域
        query.setParameter("address", buildings.getAddress());//地址
        query.setParameter("floor_area", buildings.getFloor_area());//占地面积
        query.setParameter("building_area", buildings.getBuilding_area());//建筑面积
        query.setParameter("house_type", buildings.getHouse_type());//房源类型，如商业，住宅
        query.setParameter("building_type", buildings.getBuilding_type());//building_type
        query.setParameter("longitude", buildings.getLongitude());//经度
        query.setParameter("latitude", buildings.getLatitude());//纬度
        query.setParameter("avg_price", buildings.getAvg_price());//楼盘均价
        query.setParameter("company", buildings.getCompany());//开发公司
        query.setParameter("open_date", buildings.getOpen_date());//开盘时间
        query.setParameter("reception_address", buildings.getReception_address());//接待地址
        query.setParameter("total_rooms", buildings.getTotal_rooms());//总套数
        query.setParameter("tel", buildings.getTel());//楼盘售楼电话
        query.setParameter("green_ratio", buildings.getGreen_ratio());//绿化率
        query.setParameter("plot_ratio", buildings.getPlot_ratio());//容积率
        query.setParameter("property_company", buildings.getProperty_company());//物业公司
        query.setParameter("property_fee", buildings.getProperty_fee());//物业费
        query.setParameter("car_station", buildings.getCar_station());//车位数
        query.setParameter("traffic", buildings.getTraffic());//交通状况
        query.setParameter("equipments", buildings.getEquipments());//周边配套
        query.setParameter("logo", buildings.getLogo());//楼盘封面
        query.setParameter("intro", buildings.getIntro());//简介
        query.setParameter("province", buildings.getProvince());//楼盘所属省
        query.setParameter("city", buildings.getCity());//楼盘所在市
        query.setParameter("id", buildings.getId());
        query.executeUpdate();
    }

    @Override
    public void updateStatus(String[] id, int status) {//冻结或激活楼盘
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("update Buildings set status = :status  where  id in (:id)");
        query.setParameter("status", status);
        query.setParameterList("id", id);
        query.executeUpdate();
    }

    @Override//分页查看某个经销商的楼盘
    public Pager<Buildings> queryAllBuildings(Pager<Buildings> pager, String agency_id,int status) {
        Session session = getSessionFactory().getCurrentSession();
        String hql = "from Buildings b where  b.agency.id = :agency_id order by b.created_time desc ";
        if(status<2){
            hql = "from Buildings b where  b.agency.id = :agency_id and b.status = :status  order by b.created_time desc ";
        }
        Query query = session.createQuery(hql);
        query.setParameter("agency_id", agency_id);
        if(status<2){
            query.setParameter("status", status);
        }
        query.setMaxResults(pager.getPageSize()); // 每页显示的个数
        query.setFirstResult(pager.getIndex());//当前页
        List<Buildings> buildings = query.list();
        pager.setResult(buildings);
        pager.setTotal(countBuildings(agency_id,status));
        return pager;
    }

    @Override//查看某个经销商的楼盘有多少个
    public long countBuildings(String agency_id,int status) {
        Session session = getSessionFactory().getCurrentSession();
        String hql = "select count(id) from Buildings   b  where  b.agency.id = :agency_id";
        if(status<2){
            hql = "select count(id) from Buildings   b  where  b.agency.id = :agency_id  and b.status = :status";
        }
        Query query =session.createQuery(hql);
        query.setParameter("agency_id",agency_id);
        if(status<2){
            query.setParameter("status", status);
        }
        return (Long) query.uniqueResult();
    }

    @Override//查询经销商下的所有楼盘主要用于下拉框
    public Pager<BuildingsPrice> queryAllBuildingsPrice(Pager<BuildingsPrice> pager, String agency_id, int status) {
        Session session = getSessionFactory().getCurrentSession();
        String hql = "from BuildingsPrice b where  b.agencyPrice.id = :agency_id ";
        if(status<2){
            hql = "from BuildingsPrice b where  b.agencyPrice.id = :agency_id  and  b.status = :status";
        }
        Query query = session.createQuery(hql);
        query.setParameter("agency_id", agency_id);
        if(status<2){
            query.setParameter("status", status);
        }
        List<BuildingsPrice> buildings = query.list();
        pager.setResult(buildings);
        return pager;
    }

    @Override  //按条件查询某个区域的某个价钱的某个房源类型
    public Pager<Buildings> queryAllindex(Pager<Buildings> pager,String area, double avg_price,double avg_price1, String house_type,String like) {
        Session session = getSessionFactory().getCurrentSession();
        Criteria criteria = session.createCriteria(Buildings.class); // 基于对象的条件查询
        criteria.add(Restrictions.eq("status",1));
        if(area!=null&&!area.equals("")&&!area.equals("undefined")&&!area.contains(" ")){
            if(area.equals("赣州市")){
                criteria.add(Restrictions.eq("city",area));
            }else {
                criteria.add(Restrictions.eq("area",area));
            }
        }
        if(avg_price!=0&&avg_price1!=0){
            if(avg_price>=30000){
                criteria.add(Restrictions.ge("avg_price",new Double(avg_price)));
            }else {
                criteria.add(Restrictions.between("avg_price",new Double(avg_price),new Double(avg_price1)));
            }
        }
        if(house_type!=null&&!house_type.equals("")&&!house_type.equals("undefined")&&!house_type.contains(" ")){
            criteria.add(Restrictions.eq("house_type",house_type));
        }
        if(like!=null&&!like.equals("")&&!like.equals("undefined")&&!like.contains(" ")){
            criteria.add(Restrictions.like("name", "%"+like+"%"));
        }
        criteria.setMaxResults(pager.getPageSize()); // 每页显示的个数
        criteria.setFirstResult(pager.getIndex());//当前页
        criteria.addOrder(Order.desc("created_time"));//根据名字升序排列
        List<Buildings> buildings = criteria.list();
        pager.setResult(buildings);
        return pager;
    }

    @Override
    public long countAllindex(String area, double avg_price,double avg_price1, String house_type,String like) {
        Session session = getSessionFactory().getCurrentSession();
        Criteria criteria = session.createCriteria(Buildings.class); // 基于对象的条件查询
        criteria.add(Restrictions.eq("status",1));
        if(area!=null&&!area.equals("")&&!area.equals("undefined")&&!area.contains(" ")){
            if(area.equals("赣州市")){
                criteria.add(Restrictions.eq("city",area));
            }else {
                criteria.add(Restrictions.eq("area",area));
            }
        }
        if(avg_price!=0&&avg_price1!=0){
            if(avg_price>=30000){
                criteria.add(Restrictions.ge("avg_price",new Double(avg_price)));
            }else {
                criteria.add(Restrictions.between("avg_price",new Double(avg_price),new Double(avg_price1)));
            }
        }
        if(house_type!=null&&!house_type.equals("")&&!house_type.equals("undefined")&&!house_type.contains(" ")){
            criteria.add(Restrictions.eq("house_type",house_type));
        }
        if(like!=null&&!like.equals("")&&!like.equals("undefined")&&!like.contains(" ")){
            criteria.add(Restrictions.like("name", "%"+like+"%"));
        }
        criteria.setProjection(Projections.rowCount());
        long count =   Long.parseLong(criteria.uniqueResult().toString());
        return count;
    }
}
