package com.ht.service.impl;

import com.ht.bean.Sale;
import com.ht.common.Pager;
import com.ht.dao.SaleDAO;
import com.ht.service.SaleService;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

/**
 * Created by CHEN JX on 2017/8/24.
 * 销售记录
 */
@Transactional
public class SaleServiceImpl implements SaleService {

    private SaleDAO saleDAO;

    public void setSaleDAO(SaleDAO saleDAO) {
        this.saleDAO = saleDAO;
    }

    @Override
    public Sale queryById(String s) {
        return saleDAO.queryById(s);
    }

    @Override
    public void add(Sale sale) {
        saleDAO.add(sale);
    }

    @Override
    public void remove(Sale sale) {
        saleDAO.remove(sale);
    }

    @Override
    public void update(Sale sale) {
        saleDAO.update(sale);
    }

    @Override
    public Pager<Sale> queryPager(Pager<Sale> pager) {
        return saleDAO.queryPager(pager);
    }

    @Override
    public Pager<Sale> queryPager(Pager<Sale> pager, String emp_id) {
        return saleDAO.queryPager(pager,emp_id);
    }

    @Override
    public List<Sale> queryAllSale(String emp_id) {
        return saleDAO.queryAllSale(emp_id);
    }

    @Override
    public void updateStatus(String[] id, int status) {
        saleDAO.updateStatus(id,status);
    }

    @Override
    public void updateSale(Sale sale) {
        saleDAO.updateSale(sale);
    }

    @Override
    public long countSale(String emp_id) {
        return saleDAO.countSale(emp_id);
    }

    @Override
    public List<Sale> queryAll() {
        return saleDAO.queryAll();
    }

    @Override
    public int count() {
        return saleDAO.count();
    }

    @Override
    public Sale queryByRoom(String room_id) {
        return saleDAO.queryByRoom(room_id);
    }
}
