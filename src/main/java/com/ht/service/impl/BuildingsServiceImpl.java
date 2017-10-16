package com.ht.service.impl;

import com.ht.bean.Buildings;
import com.ht.common.Pager;
import com.ht.dao.AbstractBaseDAO;
import com.ht.dao.BuildingsDAO;
import com.ht.price.BuildingsPrice;
import com.ht.service.BuildingsService;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by CHEN JX on 2017/8/23.
 */
@Transactional
public class BuildingsServiceImpl implements BuildingsService {


    private BuildingsDAO buildingsDAO;

    public void setBuildingsDAO(BuildingsDAO buildingsDAO) {
        this.buildingsDAO = buildingsDAO;
    }

    @Override
    public Buildings queryById(String s) {
        return buildingsDAO.queryById(s);
    }

    @Override
    public void add(Buildings buildings) {
        buildingsDAO.add(buildings);
    }

    @Override
    public void remove(Buildings buildings) {
        buildingsDAO.remove(buildings);
    }

    @Override
    public void update(Buildings buildings) {
        buildingsDAO.update(buildings);
    }

    @Override
    public Pager<Buildings> queryPager(Pager<Buildings> pager) {
        return buildingsDAO.queryPager(pager);
    }

    @Override
    public List<Buildings> queryAll() {
        return buildingsDAO.queryAll();
    }

    @Override
    public int count() {
        return buildingsDAO.count();
    }

    @Override
    public Pager<Buildings> queryStatusAll(Pager<Buildings> pager, int status,String name) {
        return buildingsDAO.queryStatusAll(pager,status,name);
    }

    @Override
    public void updateBuildings(Buildings buildings) {
        buildingsDAO.updateBuildings(buildings);
    }

    @Override
    public void updateStatus(String[] id, int status) {
        buildingsDAO.updateStatus(id,status);
    }

    @Override
    public Pager<Buildings> queryAllBuildings(Pager<Buildings> pager, String agency_id,int status) {
        return buildingsDAO.queryAllBuildings(pager,agency_id,status);
    }

    @Override
    public long countBuildings(String agency_id,int status) {
        return buildingsDAO.countBuildings(agency_id,status);
    }

    @Override
    public Pager<BuildingsPrice> queryAllBuildingsPrice(Pager<BuildingsPrice> pager, String agency_id, int status) {
        return buildingsDAO.queryAllBuildingsPrice(pager,agency_id,status);
    }

    @Override
    public long count(String name) {
        return buildingsDAO.count(name);
    }

    @Override
    public Pager<Buildings> queryAllindex(Pager<Buildings> pager,String area, double avg_price, double avg_price1, String house_type,String like) {
        pager.setTotal(buildingsDAO.countAllindex(area,avg_price,avg_price1,house_type,like));
        return buildingsDAO.queryAllindex(pager,area,avg_price,avg_price1,house_type,like);
    }

    @Override
    public long countAllindex(String area, double avg_price, double avg_price1, String house_type,String like) {
        return buildingsDAO.countAllindex(area,avg_price,avg_price1,house_type,like);
    }
}
