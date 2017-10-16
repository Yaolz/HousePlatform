package com.ht.dao.impl;

import com.ht.bean.BuildingsAvgprice;
import com.ht.bean.Employee;
import com.ht.common.Pager;
import com.ht.dao.AbstractBaseDAO;
import com.ht.dao.BuildingsAvgpriceDAO;
import org.hibernate.Session;
import org.hibernate.query.Query;

import java.util.List;

public class BuildingsAvgpriceDAOImpl extends AbstractBaseDAO implements BuildingsAvgpriceDAO{
    @Override
    public List<BuildingsAvgprice> queryAllBuildingsAvgprice(String buildings_id) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from BuildingsAvgprice where buildings.id = :buildings_id  order by recording_time asc");
        query.setParameter("buildings_id",buildings_id);
        List<BuildingsAvgprice> list = query.list();
        return list;
    }

    @Override
    public BuildingsAvgprice queryById(String id) {
        return null;
    }

    @Override
    public void add(BuildingsAvgprice buildingsAvgprice) {
        getSessionFactory().getCurrentSession().save(buildingsAvgprice);
    }

    @Override
    public void remove(BuildingsAvgprice buildingsAvgprice) {

    }

    @Override
    public void update(BuildingsAvgprice buildingsAvgprice) {

    }

    @Override
    public Pager<BuildingsAvgprice> queryPager(Pager<BuildingsAvgprice> pager) {
        return null;
    }

    @Override
    public List<BuildingsAvgprice> queryAll() {
        return null;
    }

    @Override
    public int count() {
        return 0;
    }
}
