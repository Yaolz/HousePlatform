package com.ht.service.impl;

import com.ht.bean.Admin;
import com.ht.bean.Ads;
import com.ht.common.Pager;
import com.ht.dao.AdsDAO;
import com.ht.service.AdsService;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by CHEN JX on 2017/8/23.
 * 广告
 */
@Transactional
public class AdsServiceImpl implements AdsService {
    private AdsDAO adsDAO;

    public void setAdsDAO(AdsDAO adsDAO) {
        this.adsDAO = adsDAO;
    }

    @Override
    public Ads queryById(String s) {
        return adsDAO.queryById(s);
    }

    @Override
    public void add(Ads ads) {
        adsDAO.add(ads);
    }

    @Override
    public void remove(Ads ads) {
        adsDAO.remove(ads);
    }

    @Override
    public void update(Ads ads) {
        adsDAO.update(ads);
    }

    @Override
    public Pager<Ads> queryPager(Pager<Ads> pager) {
        return adsDAO.queryPager(pager);
    }

    @Override
    public List<Ads> queryAll() {
        return adsDAO.queryAll();
    }

    @Override
    public int count() {
        return 0;
    }

    @Override
    public long countId() {
        return adsDAO.countId();
    }

    @Override
    public Pager<Ads> queryAllStatus(Pager<Ads> pager, int status) {
        return adsDAO.queryAllStatus(pager,status);
    }

    @Override
    public void updateStatus(String[] id, int status) {
        adsDAO.updateStatus(id,status);
    }

    @Override
    public List<Ads> queryShow(int beginNum, int endNum) {
        return adsDAO.queryShow(beginNum,endNum);
    }
}
