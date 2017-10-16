package com.ht.service.impl;

import com.ht.bean.History;
import com.ht.common.Pager;
import com.ht.dao.HistoryDAO;
import com.ht.service.HistoryService;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by CHEN JX on 2017/8/23.
 * 历史纪录
 */
@Transactional
public class HistoryServiceImpl implements HistoryService{

    private HistoryDAO historyDAO;

    public void setHistoryDAO(HistoryDAO historyDAO) {
        this.historyDAO = historyDAO;
    }

    @Override
    public History queryById(String s) {
        return historyDAO.queryById(s);
    }

    @Override
    public void add(History history) {
        historyDAO.add(history);
    }

    @Override
    public void remove(History history) {
        historyDAO.remove(history);
    }

    @Override
    public void update(History history) {
        historyDAO.update(history);
    }

    @Override
    public Pager<History> queryPager(Pager<History> pager) {
       return historyDAO.queryPager(pager);
    }

    @Override
    public List<History> queryAll() {
        return historyDAO.queryAll();
    }

    @Override
    public int count() {
        return historyDAO.count();
    }

    @Override
    public Pager<History> queryAllHistory(Pager<History> pager, String user_id) {
        return historyDAO.queryAllHistory(pager,user_id);
    }

    @Override
    public Long countHistory(String user_id) {
        return historyDAO.countHistory(user_id);
    }

    @Override
    public History queryById(String user_id, String buildings_id) {
        return historyDAO.queryById(user_id,buildings_id);
    }

}
