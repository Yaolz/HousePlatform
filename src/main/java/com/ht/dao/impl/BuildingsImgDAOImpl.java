package com.ht.dao.impl;

import com.ht.bean.Building;
import com.ht.bean.Buildings;
import com.ht.bean.BuildingsImg;
import com.ht.common.Pager;
import com.ht.dao.AbstractBaseDAO;
import com.ht.dao.BuildingsImgDAO;
import org.hibernate.Session;
import org.hibernate.query.Query;

import java.util.List;

/**
 * Created by CHEN JX on 2017/8/23.
 * 楼盘图片
 */
public class BuildingsImgDAOImpl extends AbstractBaseDAO implements BuildingsImgDAO {
    @Override
    public BuildingsImg queryById(String s) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from BuildingsImg  where id = :id ");
        query.setParameter("id",s);
        Object obj = query.uniqueResult(); // 返回单个结果
        return obj != null ? (BuildingsImg) obj : null;
    }

    @Override
    public void add(BuildingsImg buildingsImg) {
        getSessionFactory().getCurrentSession().save(buildingsImg);
    }

    @Override
    public void remove(BuildingsImg buildingsImg) {
        getSessionFactory().getCurrentSession().remove(buildingsImg);
    }

    @Override
    public void update(BuildingsImg buildingsImg) {
        getSessionFactory().getCurrentSession().update(buildingsImg);
    }

    @Override
    public Pager<BuildingsImg> queryPager(Pager<BuildingsImg> pager) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from BuildingsImg order by created_time desc");
        query.setFirstResult(pager.getIndex());
        query.setMaxResults(pager.getPageSize());
        pager.setResult(query.list());
        return pager;
    }

    @Override
    public List<BuildingsImg> queryAll() {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from BuildingsImg order by created_time desc");
        List<BuildingsImg> list = query.list();
        return list;

    }

    @Override
    public Pager<BuildingsImg> queryAllBuildingsImg(Pager<BuildingsImg> pager, String buildings_id) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from BuildingsImg b where  b.buildings.id = :buildings_id order by created_time desc ");
        query.setParameter("buildings_id", buildings_id);
        query.setMaxResults(pager.getPageSize()); // 每页显示的个数
        query.setFirstResult(pager.getIndex());//当前页
        List<BuildingsImg> buildingsImgs = query.list();
        pager.setResult(buildingsImgs);
        pager.setTotal(countBuildingsImg(buildings_id));
        return pager;
    }

    @Override
    public long countBuildingsImg(String buildings_id) {
        Session session = getSessionFactory().getCurrentSession();
        long count = (Long) session.createQuery
                ("select count(id) from BuildingsImg   b  where  b.buildings.id = '" +buildings_id+ "'").uniqueResult();
        return count;
    }

    @Override
    public int count() {
        return 0;
    }
}
