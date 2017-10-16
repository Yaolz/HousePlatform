package com.ht.service.impl;

import com.ht.bean.Agency;
import com.ht.common.Pager;
import com.ht.dao.AgencyDAO;
import com.ht.service.AgencyService;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by CHEN JX on 2017/8/23.
 * 经销商
 */
@Transactional
public class AgencyServiceImpl implements AgencyService {

    private AgencyDAO agencyDAO;

    public void setAgencyDAO(AgencyDAO agencyDAO) {
        this.agencyDAO = agencyDAO;
    }

    @Override
    public Agency queryById(String s) {
        return agencyDAO.queryById(s);
    }

    @Override
    public void add(Agency agency) {
        agencyDAO.add(agency);
    }

    @Override
    public void remove(Agency agency) {
        agencyDAO.remove(agency);
    }

    @Override
    public void update(Agency agency) {
        agencyDAO.update(agency);
    }

    @Override
    public Pager<Agency> queryPager(Pager<Agency> pager) {
        return agencyDAO.queryPager(pager);
    }

    @Override
    public List<Agency> queryAll() {
      return agencyDAO.queryAll();
    }

    @Override
    public int count() {
        return 0;
    }

    @Override
    public Pager<Agency> queryAllChecked(Pager<Agency> pager, int checked_status) {
        return agencyDAO.queryAllChecked(pager,checked_status);
    }

    @Override
    public long countChecked(int checked_status) {
        return agencyDAO.countChecked(checked_status);
    }

    @Override
    public long countStatus(int status) {
        return agencyDAO.countStatus(status);
    }

    @Override
    public void updateChecked(String[] id, int checked_status) {
        agencyDAO.updateChecked(id,checked_status);
    }

    @Override
    public void updateStatus(String[] id, int status) {
        agencyDAO.updateStatus(id,status);
    }

    @Override
    public long countAll(int checked_status, int status) {
        return agencyDAO.countAll(checked_status,status);
    }

    @Override
    public Pager<Agency> queryAllRight(Pager<Agency> pager, int checked_status, int status) {
        return agencyDAO.queryAllRight(pager,checked_status,status);
    }

    @Override
    public void updateAgency(Agency agency) {
        agencyDAO.updateAgency(agency);
    }

    @Override
    public void updateEmailPwd(String email, String pwd) {
        agencyDAO.updateEmailPwd(email,pwd);
    }

    @Override
    public Pager<Agency> queryAllStatus(Pager<Agency> pager, int status) {
        return agencyDAO.queryAllStatus(pager,status);
    }
    @Override
    public Agency queryEmailPwd(String email) {
        return agencyDAO.queryEmailPwd(email);
    }

    @Override
    public Agency queryByPhone(String phone) {
        return agencyDAO.queryByPhone(phone);
    }

    @Override
    public Agency queryByName(String name) {
        return agencyDAO.queryByName(name);
    }
}
