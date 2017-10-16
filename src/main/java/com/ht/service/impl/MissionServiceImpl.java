package com.ht.service.impl;

import com.ht.bean.Mission;
import com.ht.common.Pager;
import com.ht.dao.MissionDAO;
import com.ht.price.MissionBean;
import com.ht.service.MissionService;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by CHEN JX on 2017/8/24.
 * 绩效表
 */
@Transactional
public class MissionServiceImpl implements MissionService {

    private MissionDAO missionDAO;

    public void setMissionDAO(MissionDAO missionDAO) {
        this.missionDAO = missionDAO;
    }

    @Override
    public Mission queryById(String id) {
        return missionDAO.queryById(id);
    }

    @Override
    public void add(Mission mission) {
        missionDAO.add(mission);
    }

    @Override
    public void remove(Mission mission) {

    }

    @Override
    public void update(Mission mission) {

    }

    @Override
    public Pager<Mission> queryPager(Pager<Mission> pager) {
        return null;
    }

    @Override
    public List<Mission> queryAll() {
        return null;
    }

    @Override
    public int count() {
        return 0;
    }

    @Override
    public void updateMissionBonusPercent(String[] id, Double bonus_percent) {
        missionDAO.updateMissionBonusPercent(id,bonus_percent);
    }

    @Override
    public void updateMissionQuantity(String[] id, int quantity) {
        missionDAO.updateMissionQuantity(id,quantity);
    }

    @Override
    public void updateMissionBonusPercent(String id, Double bonus_percent) {
        missionDAO.updateMissionBonusPercent(id,bonus_percent);
    }

    @Override
    public void updateMissionQuantity(String id, int quantity) {
        missionDAO.updateMissionQuantity(id,quantity);
    }

    @Override
    public Pager<Mission> queryPager(Pager<Mission> pager, String emp_id) {
        return missionDAO.queryPager(pager,emp_id);
    }

    @Override
    public long countMission(String emp_id) {
        return missionDAO.countMission(emp_id);
    }

    @Override
    public MissionBean queryByMissionMaxEnd(String emp_id) {
        return missionDAO.queryByMissionMaxEnd(emp_id);
    }

    @Override
    public Pager<MissionBean> queryAllMissionBeanAgency(Pager<MissionBean> pager, String agency_id, int status) {
        pager.setTotal(missionDAO.countMissionBeanAgency(agency_id,status));//查询经销商所有绩效表有多少个
        return missionDAO.queryAllMissionBeanAgency(pager,agency_id,status);
    }

    @Override
    public long countMissionBeanAgency(String agency_id, int status) {
        return missionDAO.countMissionBeanAgency(agency_id,status);
    }

    @Override
    public Pager<MissionBean> queryAllMissionBeanAgencyHistory(Pager<MissionBean> pager, String agency_id, int status) {
        pager.setTotal(missionDAO.counMissionBeanAgencyHistory(agency_id,status));//查询经销商所有绩效表有多少个
        return missionDAO.queryAllMissionBeanAgencyHistory(pager,agency_id,status);
    }

    @Override
    public long counMissionBeanAgencyHistory(String agency_id, int status) {
        return missionDAO.counMissionBeanAgencyHistory(agency_id,status);
    }

    @Override
    public Pager<MissionBean> queryAllMissionBeanAgencyNewest(Pager<MissionBean> pager, String agency_id, int status) {
        pager.setTotal(missionDAO.counMissionBeanAgencyNewest(agency_id,status));//查询经销商所有绩效表有多少个
        return missionDAO.queryAllMissionBeanAgencyNewest(pager,agency_id,status);
    }

    @Override
    public long counMissionBeanAgencyNewest(String agency_id, int status) {
        return missionDAO.counMissionBeanAgencyNewest(agency_id,status);
    }

    @Override
    public Pager<MissionBean> queryAllMissionBeanEmployee(Pager<MissionBean> pager, String emp_id, int status) {
        pager.setTotal(missionDAO.counMissionBeanEmployee(emp_id,status));//查询经销商所有绩效表有多少个
        return missionDAO.queryAllMissionBeanEmployee(pager,emp_id,status);
    }

    @Override
    public long counMissionBeanEmployee(String emp_id, int status) {
        return missionDAO.counMissionBeanEmployee(emp_id,status);
    }

    @Override
    public void updateStatus(String[] id, int status) {
        missionDAO.updateStatus(id,status);
    }

    @Override
    public Object countSale(String id) {
        return missionDAO.countSale(id);
    }
}
