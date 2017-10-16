package com.ht.dao;

import com.ht.bean.Building;
import com.ht.common.Pager;

/**
 * Created by CHEN JX on 2017/8/23.
 * 楼栋
 */
public interface BuildingDAO extends BaseDAO<String,Building>{

    void updateBuilding(Building building);//修改楼栋信息

    Pager<Building> queryAllBuilding(Pager<Building> pager, String buildings_id);//分页查询某个楼盘的楼栋

    long countBuilding(String buildings_id);//查询某个楼盘的楼栋有多少个

    Pager<Building> queryAllBuildingStatus(Pager<Building> pager, String buildings_id, int status);//分页查询某个楼盘下被冻结或激活的楼栋

    long countBuildingStatus(String buildings_id, int status);//查询某个楼盘下被冻结或激活的楼栋有多少个

    void updateBuildingStatus(String[] id, int status);//批量冻结或激活

    Pager<Building> queryAllBuildingAgencyStatus(Pager<Building> pager, String agency_id, int status);//分页查询经销商下被冻结或激活的楼栋

    long countBuildingAgencyStatus(String agency_id, int status);//查询经销商下被冻结或激活的楼栋有多少个
}
