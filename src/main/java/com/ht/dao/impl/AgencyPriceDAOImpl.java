package com.ht.dao.impl;

import com.ht.price.AgencyPrice;
import com.ht.common.Pager;
import com.ht.dao.AbstractBaseDAO;
import com.ht.dao.AgencyPriceDAO;
import org.hibernate.Session;
import org.hibernate.query.Query;

import java.util.List;
/**
 * Created by CHEN JX on 2017/8/21.
 * 经销商的值对象
 */
public class AgencyPriceDAOImpl extends AbstractBaseDAO implements AgencyPriceDAO {
    @Override
    public AgencyPrice queryById(String s) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from AgencyPrice  where id = :id ");
        query.setParameter("id",s);
        Object obj = query.uniqueResult(); // 返回单个结果
        return obj != null ? (AgencyPrice) obj : null;
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
