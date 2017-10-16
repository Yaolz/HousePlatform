package com.ht.service;

import com.ht.bean.BuildingsAvgprice;
import com.ht.dao.BaseDAO;

import java.util.List;

public interface BuildingsAvgpriceService extends  BaseService<String,BuildingsAvgprice>  {

    List<BuildingsAvgprice> queryAllBuildingsAvgprice(String buildings_id);

}
