package com.ht.service.impl;

import com.ht.price.AgencyPrice;
import com.ht.common.Pager;
import com.ht.dao.AgencyPriceDAO;
import com.ht.service.AgencyPriceService;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
/**
 * Created by CHEN JX on 2017/8/21.
 * 经销商的值对象
 */
@Transactional
public class AgencyPriceServiceImpl implements AgencyPriceService {

    private AgencyPriceDAO agencyPriceDAO;

    public void setAgencyPriceDAO(AgencyPriceDAO agencyPriceDAO) {
        this.agencyPriceDAO = agencyPriceDAO;
    }

    @Override
    public AgencyPrice queryById(String s) {
        return agencyPriceDAO.queryById(s);
    }

    @Override
    public void add(AgencyPrice agencyPrice) {

    }

    @Override
    public void remove(AgencyPrice agencyPrice) {

    }

    @Override
    public void update(AgencyPrice agencyPrice) {

    }

    @Override
    public Pager<AgencyPrice> queryPager(Pager<AgencyPrice> pager) {
        return null;
    }

    @Override
    public List<AgencyPrice> queryAll() {
        return null;
    }

    @Override
    public int count() {
        return 0;
    }
}
