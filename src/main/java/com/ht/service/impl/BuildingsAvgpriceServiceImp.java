package com.ht.service.impl;

import com.ht.bean.BuildingsAvgprice;
import com.ht.common.Pager;
import com.ht.dao.BuildingsAvgpriceDAO;
import com.ht.service.BuildingsAvgpriceService;

import java.util.List;

public class BuildingsAvgpriceServiceImp implements BuildingsAvgpriceService{

    private BuildingsAvgpriceDAO buildingsAvgpriceDAO;

    public void setBuildingsAvgpriceDAO(BuildingsAvgpriceDAO buildingsAvgpriceDAO) {
        this.buildingsAvgpriceDAO = buildingsAvgpriceDAO;
    }

    @Override
    public List<BuildingsAvgprice> queryAllBuildingsAvgprice(String buildings_id) {
        return buildingsAvgpriceDAO.queryAllBuildingsAvgprice(buildings_id);
    }

    @Override
    public BuildingsAvgprice queryById(String id) {
        return null;
    }

    @Override
    public void add(BuildingsAvgprice buildingsAvgprice) {
        buildingsAvgpriceDAO.add(buildingsAvgprice);
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
