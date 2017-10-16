package com.ht.dao;

import com.ht.bean.Buildings;
import com.ht.common.Pager;
import com.ht.price.BuildingsPrice;

/**
 * Created by CHEN JX on 2017/8/23.
 * 楼盘
 */
public interface BuildingsDAO extends BaseDAO<String, Buildings> {

    Pager<Buildings> queryStatusAll(Pager<Buildings> pager, int status,String name);// 查询所有以激活的楼盘

    void updateBuildings(Buildings buildings);//修改楼盘信息

    void updateStatus(String[] id, int status);//冻结或激活楼盘

    Pager<Buildings> queryAllBuildings(Pager<Buildings> pager, String agency_id,int status);//分页查看某个经销商的楼盘

    long countBuildings(String agency_id,int status);//查看某个经销商的楼盘有多少个

    Pager<BuildingsPrice> queryAllBuildingsPrice(Pager<BuildingsPrice> pager, String agency_id,int status);//查询经销商下的所有楼盘主要用于下拉框

    long count(String name);//模糊搜索楼盘有多少个

    //按条件查询某个区域的某个价钱的某个房源类型
    Pager<Buildings> queryAllindex(Pager<Buildings> pager,String area,double avg_price,double avg_price1,String house_type,String like);

    long countAllindex(String area,double avg_price,double avg_price1,String house_type,String like);
}
