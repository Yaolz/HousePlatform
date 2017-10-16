package com.ht.dao;

import com.ht.bean.House;
import com.ht.common.Pager;

import java.util.List;

/**
 * Created by CHEN JX on 2017/8/24.
 * 户型
 */
public interface HouseDAO extends BaseDAO<String,House> {

    void updateHouse(House house);//修改户型的方法

    Pager<House> queryAllHouse(Pager<House> pager, String buildings_id);//分页查询某个楼盘的户型

    long countHouse(String buildings_id);//查询某个楼盘的户型有多少个

    Pager<House> queryAllHouseStatus(Pager<House> pager, String buildings_id, int status);//分页查询某个楼盘被冻结或激活的户型

    long countHouseStatus(String buildings_id, int status);//查询某个楼盘被冻结或激活的户型有多少个

    void updateStatus(String[] id, int status);//批量冻结或激活的方法

    long countId();

    List<House> queryByHouse(List<String> list);//查询楼栋所用的户型

    Pager<House> queryAllHouseAgencyStatus(Pager<House> pager, String agency_id, int status);//分页查询经销商下所有被冻结或激活的户型

    long countHouseAgencyStatus(String agency_id, int status);//查询经销商下所有被冻结或激活的户型有多少个

    Pager<House> queryAllindex(Pager<House> pager, double unit_price, double unit_price1, double area, double area1, String like);

    long countAllindex(double unit_price, double unit_price1, double area, double area1, String like);
}
