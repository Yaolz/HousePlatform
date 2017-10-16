package com.ht.service;

import com.ht.dao.BaseDAO;
import com.ht.price.BuildingPrice;

import java.util.List;

public interface BuildingPriceService extends BaseService<String,BuildingPrice> {

    List<BuildingPrice> queryAllBuildingPrice(String buildings_id);//查询所有某个楼盘的楼栋信息，主要用于下拉框值
}