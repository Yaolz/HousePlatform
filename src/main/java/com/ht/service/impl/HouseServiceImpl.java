package com.ht.service.impl;

import com.ht.bean.House;
import com.ht.common.Pager;
import com.ht.dao.HouseDAO;
import com.ht.service.HouseService;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by CHEN JX on 2017/8/24.
 * 户型
 */
@Transactional
public class HouseServiceImpl implements HouseService {
    private HouseDAO houseDAO;

    public void setHouseDAO(HouseDAO houseDAO) {
        this.houseDAO = houseDAO;
    }

    @Override
    public House queryById(String s) {
        return houseDAO.queryById(s);
    }

    @Override
    public void add(House house) {
        houseDAO.add(house);
    }

    @Override
    public void remove(House house) {
        houseDAO.remove(house);
    }

    @Override
    public void update(House house) {
        houseDAO.update(house);
    }

    @Override
    public Pager<House> queryPager(Pager<House> pager) {
        return houseDAO.queryPager(pager);
    }

    @Override
    public List<House> queryAll() {
        return houseDAO.queryAll();
    }

    @Override
    public int count() {
        return 0;
    }

    @Override
    public void updateHouse(House house) {
        houseDAO.updateHouse(house);
    }

    @Override
    public Pager<House> queryAllHouse(Pager<House> pager, String buildings_id) {
        return houseDAO.queryAllHouse(pager,buildings_id);
    }

    @Override
    public long countHouse(String buildings_id) {
        return houseDAO.countHouse(buildings_id);
    }

    @Override
    public Pager<House> queryAllHouseStatus(Pager<House> pager, String buildings_id, int status) {
        return houseDAO.queryAllHouseStatus(pager,buildings_id,status);
    }

    @Override
    public long countHouseStatus(String buildings_id, int status) {
        return houseDAO.countHouseStatus(buildings_id,status);
    }

    @Override
    public void updateStatus(String[] id,int status) {
        houseDAO.updateStatus(id,status);
    }

    @Override
    public long countId() {
        return houseDAO.countId();
    }

    @Override
    public List<House> queryByHouse(List<String> list) {
        return houseDAO.queryByHouse(list);
    }

    @Override
    public Pager<House> queryAllindex(Pager<House> pager, double unit_price, double unit_price1, double area, double area1, String like) {
        pager.setTotal(houseDAO.countAllindex(unit_price,unit_price1,area,area1,like));
        return houseDAO.queryAllindex(pager,unit_price,unit_price1,area,area1,like);
    }
    @Override
    public Pager<House> queryAllHouseAgencyStatus(Pager<House> pager, String agency_id, int status) {
        return houseDAO.queryAllHouseAgencyStatus(pager,agency_id,status);
    }

    @Override
    public long countHouseAgencyStatus(String agency_id, int status) {
        return houseDAO.countHouseAgencyStatus(agency_id,status);
    }

}
