package com.ht.service.impl;

import com.ht.bean.Activity;
import com.ht.common.Pager;
import com.ht.dao.ActivityDAO;
import com.ht.service.ActivityService;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by CHEN JX on 2017/8/23.
 * 活动
 */
@Transactional
public class ActivityServiceImpl implements ActivityService {

    private ActivityDAO activityDAO;

    public void setActivityDAO(ActivityDAO activityDAO) {
        this.activityDAO = activityDAO;
    }

    @Override
    public Activity queryById(String s) {
        return activityDAO.queryById(s);
    }

    @Override
    public void add(Activity activity) {
        activityDAO.add(activity);
    }

    @Override
    public void remove(Activity activity) {
        activityDAO.remove(activity);
    }

    @Override
    public void update(Activity activity) {
        activityDAO.update(activity);
    }

    @Override
    public Pager<Activity> queryPager(Pager<Activity> pager) {
        return activityDAO.queryPager(pager);
    }

    @Override
    public List<Activity> queryAll() {
        return activityDAO.queryAll();
    }

    @Override
    public int count() {
        return 0;
    }

    @Override
    public long countId() {
        return activityDAO.countId();
    }

    @Override
    public Pager<Activity> queryPagers(Pager<Activity> pager, String agency_id) {
        return activityDAO.queryPagers(pager,agency_id);
    }

    @Override
    public void updateStatusById(String[] id, int status) {
        activityDAO.updateStatusById(id,status);
    }

    @Override
    public Pager<Activity> queryPagerByStatus(Pager<Activity> pager, String agency_id, int status) {
        return activityDAO.queryPagerByStatus(pager,agency_id,status);
    }

    @Override
    public long countActivityStatus(String agency_id, int status) {
        return activityDAO.countActivityStatus(agency_id,status);
    }

    @Override
    public Pager<Activity> queryPagerByBuildings(Pager<Activity> pager, String buildings_id, int status) {
        return activityDAO.queryPagerByBuildings(pager,buildings_id,status);
    }

    @Override
    public long countActivityBuildings(String buildings_id, int status) {
        return activityDAO.countActivityBuildings(buildings_id,status);
    }

    @Override
    public void updateActivity(Activity activity) {
        activityDAO.updateActivity(activity);
    }

    @Override
    public Activity queryByBuildingsId(String id) {
        return activityDAO.queryByBuildingsId(id);
    }
}
