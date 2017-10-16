package com.ht.dao;

import com.ht.bean.Mission;
import com.ht.common.Pager;
import com.ht.price.MissionBean;

/**
 * Created by CHEN JX on 2017/8/24.
 * 绩效表
 */
public interface MissionDAO extends BaseDAO<String ,Mission> {

    void updateMissionBonusPercent(String[] id,Double bonus_percent);//批量设置提成百分比

    void updateMissionQuantity(String[] id,int quantity );//批量设置员工任务

    void updateMissionBonusPercent(String id,Double bonus_percent);//单个设置提成百分比

    void updateMissionQuantity(String id,int quantity );//单个设置员工任务

    Pager<Mission> queryPager(Pager<Mission> pager,String emp_id);//分页查询某个员工下的绩效

    long countMission(String emp_id);//查询员工的绩效

    MissionBean queryByMissionMaxEnd(String emp_id);//查询员工最新的绩效表

    Pager<MissionBean> queryAllMissionBeanAgency(Pager<MissionBean> pager ,String agency_id,int status);//分页查询经销商的所有绩效表

    long countMissionBeanAgency(String agency_id,int status);//查询经销商所有绩效表有多少个

    Pager<MissionBean> queryAllMissionBeanAgencyHistory(Pager<MissionBean> pager ,String agency_id,int status);//分页按时间查询历史布置的绩效

    long counMissionBeanAgencyHistory(String agency_id,int status);//查询历史布置的绩效有多少个

    Pager<MissionBean> queryAllMissionBeanAgencyNewest (Pager<MissionBean> pager ,String agency_id,int status);//分页查询最新添加的绩效

    long counMissionBeanAgencyNewest(String agency_id,int status);//查询最新添加的绩效有多少个

    Pager<MissionBean> queryAllMissionBeanEmployee (Pager<MissionBean> pager ,String emp_id,int status);//分页查询一个员工的所有绩效

    long counMissionBeanEmployee(String emp_id,int status);//查询一个员工的绩效多少个

    void updateStatus(String[] id,int status);//进行批量激活或冻结

    Object countSale(String id);//查询每个员工绩效表内的任务完成量
}
