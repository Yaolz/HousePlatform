package com.ht.dao.impl;

import com.ht.bean.BuildingsAvgprice;
import com.ht.bean.Room;
import com.ht.bean.Sale;
import com.ht.common.Pager;
import com.ht.dao.AbstractBaseDAO;
import com.ht.dao.SaleDAO;
import org.hibernate.Session;
import org.hibernate.query.Query;

import javax.xml.bind.SchemaOutputResolver;
import java.util.Date;
import java.util.List;

/**
 * Created by CHEN JX on 2017/8/24.
 * 销售记录
 */
public class SaleDAOImpl extends AbstractBaseDAO implements SaleDAO{

    @Override
    public Sale queryByRoom(String room_id) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Sale  where room.id = :room_id ");
        query.setParameter("room_id",room_id);
        Object obj = query.uniqueResult(); // 返回单个结果
        return obj != null ? (Sale) obj : null;
    }

    @Override
    public Sale queryById(String s) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Sale  where id = :id ");
        query.setParameter("id",s);
        Object obj = query.uniqueResult(); // 返回单个结果
        return obj != null ? (Sale) obj : null;
    }

    @Override
    public void add(Sale sale) {
        getSessionFactory().getCurrentSession().save(sale);
    }

    @Override
    public void remove(Sale sale) {
        getSessionFactory().getCurrentSession().remove(sale);
    }

    @Override
    public void update(Sale sale) {
        getSessionFactory().getCurrentSession().update(sale);
    }

    @Override
    public Pager<Sale> queryPager(Pager<Sale> pager) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Sale order by created_time desc");
        query.setFirstResult(pager.getIndex());
        query.setMaxResults(pager.getPageSize());
        pager.setResult(query.list());
        return pager;
    }

    //分页查询某个员工下的销售记录
    @Override
    public Pager<Sale> queryPager(Pager<Sale> pager, String emp_id) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Sale where employee.id = :emp_id");
        query.setParameter("emp_id",emp_id);
        query.setFirstResult(pager.getIndex());
        query.setMaxResults(pager.getPageSize());
        List<Sale> sales = query.list();
        pager.setResult(sales);
        pager.setTotal(countSale(emp_id));
        return pager;
    }

    //房屋销售图表查看
    @Override
    public List<Sale> queryAllSale(String emp_id) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Sale where emp_id = :emp_id  order by sale_time asc");
        query.setParameter("emp_id",emp_id);
        List<Sale> list = query.list();
        return list;
    }

    //批量冻结或激活
    @Override
    public void updateStatus(String[] id, int status) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("update Sale set status = :status  where   id  in  (:id)");
        query.setParameter("status", status);
        query.setParameterList("id", id);
        query.executeUpdate();
    }

    @Override//更新sale的数据
    public void updateSale(Sale sale) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("update Sale set unit_price = :unit_price," +
                "discount = :discount,total_cost =:total_cost," +
                "sale_time =:sale_time  where   id  = :id");
        query.setParameter("unit_price", sale.getUnit_price());
        query.setParameter("discount", sale.getDiscount());
        query.setParameter("total_cost", sale.getTotal_cost());
        query.setParameter("sale_time", sale.getSale_time());
        query.setParameter("id", sale.getId());
        query.executeUpdate();
    }

    //查询员工添加的销售记录有多少个
    @Override
    public long countSale(String emp_id) {
        Session session = getSessionFactory().getCurrentSession();
        Query query =session.createQuery
                ("select count(id) from Sale s where s.employee.id = :emp_id");
        query.setParameter("emp_id",emp_id);
        return (Long) query.uniqueResult();
    }


    @Override
    public List<Sale> queryAll() {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Sale order by created_time desc");
        List<Sale> list = query.list();
        return list;
    }

    @Override
    public int count() {
        Session session = getSessionFactory().getCurrentSession();
        Long longStr = (Long) session.createQuery("select count(id) from Sale").uniqueResult();
        int count = longStr.intValue();
        return count;
    }

}
