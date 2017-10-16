package com.ht.service.impl;

import com.ht.common.Pager;
import com.ht.dao.BuildingPriceDAO;
import com.ht.price.BuildingPrice;
import com.ht.service.BuildingPriceService;

import java.util.List;

public class BuildingPriceServiceImpl implements BuildingPriceService {

    private BuildingPriceDAO buildingPriceDAO;

    public void setBuildingPriceDAO(BuildingPriceDAO buildingPriceDAO) {
        this.buildingPriceDAO = buildingPriceDAO;
    }

    @Override
    public List<BuildingPrice> queryAllBuildingPrice(String buildings_id) {
        return buildingPriceDAO.queryAllBuildingPrice(buildings_id);
    }

    @Override
    public BuildingPrice queryById(String id) {
        return null;
    }

    @Override
    public void add(BuildingPrice buildingPrice) {
        buildingPriceDAO.add(buildingPrice);
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
        return buildingPriceDAO.queryAll();
    }

    @Override
    public int count() {
        return 0;
    }
}
