package com.ht.dao;

import com.ht.bean.Activity;
import com.ht.bean.Agency;
import com.ht.common.Pager;

import java.util.List;

/**
 * Created by CHEN JX on 2017/8/23.
 * 活动
 */
public interface ActivityDAO extends BaseDAO<String, Activity>{
    long countId();
    Pager<Activity> queryPagers(Pager<Activity> pager, String agency_id);//通过经销商id，pager分页
    void updateStatusById(String[] id,int status);//通过判断活动id,状态 激活或冻结活动
    Pager<Activity> queryPagerByStatus(Pager<Activity>pager,String agency_id,int status);//经销商活动分页
    long countActivityStatus(String agency_id,int status);//查询某个经销商下被冻结或激活的活动有多少个

    Pager<Activity> queryPagerByBuildings(Pager<Activity>pager,String buildings_id,int status);//分页查询某个楼盘下的活动
    long countActivityBuildings(String buildings_id,int status);//查询某个楼盘下的活动有多少个

    void updateActivity(Activity activity);
    Activity queryByBuildingsId(String id);
}
