package com.ht.dao;

import com.ht.bean.BuildingsAvgprice;
import com.ht.common.Pager;

import java.util.List;

public interface BuildingsAvgpriceDAO extends  BaseDAO<String,BuildingsAvgprice>  {

    List<BuildingsAvgprice> queryAllBuildingsAvgprice(String buildings_id);

}
