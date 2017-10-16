package com.ht.dao;

import com.ht.common.Pager;
import com.ht.price.BuildingPrice;

import java.util.List;
/**
 * Created by CHEN JX on 2017/8/30.
 *
 * 楼栋表的下拉框值对象,用于房屋查询
 */
public interface BuildingPriceDAO extends  BaseDAO<String,BuildingPrice> {

    List<BuildingPrice> queryAllBuildingPrice(String buildings_id);//查询所有某个楼盘的楼栋信息，主要用于下拉框值
}
