package com.ht.dao.impl;

import com.ht.common.Pager;
import com.ht.dao.AbstractBaseDAO;
import com.ht.dao.BuildingPriceDAO;
import com.ht.price.BuildingPrice;
import org.hibernate.Session;
import org.hibernate.query.Query;

import java.util.List;
/**
 * Created by CHEN JX on 2017/8/30.
 *
 * 楼栋表的下拉框值对象,用于房屋查询
 */
public class BuildingPriceDAOImpl extends AbstractBaseDAO implements BuildingPriceDAO{

    @Override//查询所有某个楼盘的楼栋信息，主要用于下拉框值
    public List<BuildingPrice> queryAllBuildingPrice(String buildings_id) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from BuildingPrice  b where  b.buildingsPrice.id =:buildings_id");
        query.setParameter("buildings_id",buildings_id);
        List<BuildingPrice> buildingPrices = query.list();
        return buildingPrices;
    }

    @Override
    public BuildingPrice queryById(String id) {
        return null;
    }

    @Override
    public void add(BuildingPrice buildingPrice) {

    }

    @Override
    public void remove(BuildingPrice buildingPrice) {

    }

    @Override
    public void update(BuildingPrice buildingPrice) {

    }

    @Override
    public Pager<BuildingPrice> queryPager(Pager<BuildingPrice> pager) {
        return null;
    }

    @Override
    public List<BuildingPrice> queryAll() {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from BuildingPrice");
        List<BuildingPrice> list = query.list();
        return list;
    }

    @Override
    public int count() {
        return 0;
    }
}
