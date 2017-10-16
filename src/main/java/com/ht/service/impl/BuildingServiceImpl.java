package com.ht.service.impl;

import com.ht.bean.Building;
import com.ht.common.Pager;
import com.ht.dao.BuildingDAO;
import com.ht.service.BuildingService;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by CHEN JX on 2017/8/23.
 * 楼栋
 */
@Transactional
public class BuildingServiceImpl implements BuildingService {
    private BuildingDAO buildingDAO;

    public void setBuildingDAO(BuildingDAO buildingDAO) {
        this.buildingDAO = buildingDAO;
    }

    @Override
    public Building queryById(String s) {
        return buildingDAO.queryById(s);
    }

    @Override
    public void add(Building building) {
        buildingDAO.add(building);
    }

    @Override
    public void remove(Building building) {
        buildingDAO.remove(building);
    }

    @Override
    public void update(Building building) {
        buildingDAO.update(building);
    }

    @Override
    public Pager<Building> queryPager(Pager<Building> pager) {
        return buildingDAO.queryPager(pager);
    }

    @Override
    public List<Building> queryAll() {
        return buildingDAO.queryAll();
    }

    @Override
    public int count() {
        return buildingDAO.count();
    }

    @Override
    public void updateBuilding(Building building) {
        buildingDAO.updateBuilding(building);
    }

    @Override
    public Pager<Building> queryAllBuilding(Pager<Building> pager, String buildings_id) {
        return buildingDAO.queryAllBuilding(pager,buildings_id);
    }

    @Override
    public long countBuilding(String buildings_id) {
        return buildingDAO.countBuilding(buildings_id);
    }

    @Override
    public Pager<Building> queryAllBuildingStatus(Pager<Building> pager, String buildings_id, int status) {
        return buildingDAO.queryAllBuildingStatus(pager,buildings_id,status);
    }

    @Override
    public long countBuildingStatus(String buildings_id, int status) {
        return buildingDAO.countBuildingStatus(buildings_id,status);
    }

    @Override
    public void updateBuildingStatus(String[] id, int status) {
        buildingDAO.updateBuildingStatus(id,status);
    }

    @Override
    public Pager<Building> queryAllBuildingAgencyStatus(Pager<Building> pager, String agency_id, int status) {
        return buildingDAO.queryAllBuildingAgencyStatus(pager,agency_id,status);
    }

    @Override
    public long countBuildingAgencyStatus(String agency_id, int status) {
        return buildingDAO.countBuildingAgencyStatus(agency_id,status);
    }
}
