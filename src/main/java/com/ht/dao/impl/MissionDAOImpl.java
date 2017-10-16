package com.ht.dao.impl;
import com.ht.bean.Building;import com.ht.bean.Mission;
import com.ht.common.Pager;
import com.ht.common.ResultToBean;
import com.ht.dao.AbstractBaseDAO;
import com.ht.dao.MissionDAO;
import com.ht.price.MissionBean;
import org.hibernate.Session;
import org.hibernate.query.Query;
import org.hibernate.transform.Transformers;

import java.math.BigInteger;
import java.util.List;

public class MissionDAOImpl extends AbstractBaseDAO implements MissionDAO {
    @Override
    public Mission queryById(String id) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Mission  where id = :id ");
        query.setParameter("id",id);
        Object obj = query.uniqueResult(); // 返回单个结果
        return obj != null ? (Mission) obj : null;
    }

    @Override
    public void add(Mission mission) {
        getSessionFactory().getCurrentSession().save(mission);
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

    @Override//批量设置提成百分比
    public void updateMissionBonusPercent(String[] id, Double bonus_percent) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("update Mission set bonus_percent = :bonus_percent  where   id  in  (:id)");
        query.setParameter("bonus_percent", bonus_percent);
        query.setParameterList("id", id);
        query.executeUpdate();
    }

    @Override//批量设置员工任务
    public void updateMissionQuantity(String[] id, int quantity) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("update Mission set quantity = :quantity  where   id  in  (:id)");
        query.setParameter("quantity", quantity);
        query.setParameterList("id", id);
        query.executeUpdate();
    }

    @Override//单个设置提成百分比
    public void updateMissionBonusPercent(String id, Double bonus_percent) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("update Mission set bonus_percent = :bonus_percent  where   id = :id");
        query.setParameter("bonus_percent", bonus_percent);
        query.setParameter("id", id);
        query.executeUpdate();
    }

    @Override//单个设置员工任务
    public void updateMissionQuantity(String id, int quantity) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("update Mission set quantity = :quantity  where   id  =  :id");
        query.setParameter("quantity", quantity);
        query.setParameter("id", id);
        query.executeUpdate();
    }

    //分页查询某个员工下的绩效
    @Override
    public Pager<Mission> queryPager(Pager<Mission> pager, String emp_id) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("from Mission where emp_id = :emp_id ");
        query.setParameter("emp_id",emp_id);
        query.setFirstResult(pager.getIndex());
        query.setMaxResults(pager.getPageSize());
        List<Mission> mission = query.list();
        pager.setResult(mission);
        pager.setTotal(countMission(emp_id));
        return pager;
    }

    @Override//查询员工的绩效
    public long countMission(String emp_id) {
        Session session = getSessionFactory().getCurrentSession();
        Query query =session.createQuery
                ("select count(id) from Mission s where s.employeePrice.id = :emp_id");
        query.setParameter("emp_id",emp_id);
        return (Long) query.uniqueResult();
    }

    @Override//查询员工最新的绩效表
    public MissionBean queryByMissionMaxEnd(String emp_id) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createNativeQuery("select * from t_mission m where start_time = (select max(start_time) " +
                "from t_mission where emp_id = m.emp_id )   and m.emp_id = :emp_id");
        query.setParameter("emp_id",emp_id);
        Object obj = query.setResultTransformer(Transformers.aliasToBean(MissionBean.class)).uniqueResult(); // 返回单个结果
        return obj != null ? (MissionBean) obj : null;
    }

    @Override//分页查询经销商的所有绩效表
    public Pager<MissionBean> queryAllMissionBeanAgency(Pager<MissionBean> pager, String agency_id,int status) {
        Session session = getSessionFactory().getCurrentSession();
        String sql ="select  m.id 'id',m.quantity 'quantity',m.start_time 'start_time', m.end_time 'end_time',m.status 'status' " +
                ",m.bonus_percent 'bonus_percent',e.basic_salary 'basic_salary',e.id 'emp_id'," +
                "e.name 'name' from t_agency a, t_mission m, t_sale s,t_employee e  " +
                " where  a.id = e.agency_id and m.emp_id = e.id  " +
                " and a.id = :agency_id group by m.id order by m.end_time desc";
        if(status<2){
            sql = "select  m.id 'id',m.quantity 'quantity',m.start_time 'start_time', m.end_time 'end_time',m.status 'status' " +
                    ",m.bonus_percent 'bonus_percent',e.basic_salary 'basic_salary',e.id 'emp_id'," +
                    "e.name 'name' from t_agency a, t_mission m, t_sale s,t_employee e " +
                    " where  a.id = e.agency_id and m.emp_id = e.id " +
                    "and a.id = :agency_id and m.status = :status group by m.id  order by m.end_time desc";
        }
        Query query = session.createNativeQuery(sql);
        query.setParameter("agency_id", agency_id);
        if(status<2){
            query.setParameter("status", status);
        }
        query.setMaxResults(pager.getPageSize()); // 每页显示的个数
        query.setFirstResult(pager.getIndex());//当前页
        List<Object[]> objects = query.list();
        String[] strs = new String[]{"id", "quantity","start_time","end_time","status","bonus_percent","basic_salary","emp_id","name"};
        List<MissionBean> myBeans = ResultToBean.resultToBean(MissionBean.class, objects, strs);
        pager.setResult(myBeans);
        return pager;
    }

    @Override//查询经销商所有绩效表有多少个
    public long countMissionBeanAgency(String agency_id,int status) {
        Session session = getSessionFactory().getCurrentSession();
        String sql = "select count(id) from (select  m.id 'id',m.quantity 'quantity',m.start_time 'start_time', m.end_time 'end_time',m.status 'status' " +
                ",m.bonus_percent 'bonus_percent',e.basic_salary 'basic_salary',e.id 'emp_id'," +
                "e.name 'name' from t_agency a, t_mission m, t_sale s,t_employee e " +
                " where  a.id = e.agency_id and m.emp_id = e.id " +
                "and a.id = :agency_id group by m.id ) n ";
        if(status<2){
            sql = "select count(id) from (select  m.id 'id',m.quantity 'quantity',m.start_time 'start_time', m.end_time 'end_time',m.status 'status' " +
                    ",m.bonus_percent 'bonus_percent',e.basic_salary 'basic_salary',e.id 'emp_id'," +
                    "e.name 'name' from t_agency a, t_mission m, t_sale s,t_employee e " +
                    " where  a.id = e.agency_id and m.emp_id = e.id " +
                    "and a.id = :agency_id and m.status = :status group by m.id)n ";
        }
        Query query = session.createNativeQuery(sql);
        query.setParameter("agency_id",agency_id);
        if(status<2){
            query.setParameter("status", status);
        }
        Object obj = query.uniqueResult(); // 返回单个结果
        return obj != null ? ((BigInteger) obj).longValue() : null;
    }

    @Override//分页按时间查询历史布置的绩效
    public Pager<MissionBean> queryAllMissionBeanAgencyHistory(Pager<MissionBean> pager, String agency_id,int status) {
        Session session = getSessionFactory().getCurrentSession();
        String sql = "select  m.id 'id',m.quantity 'quantity',m.start_time 'start_time', m.end_time 'end_time',m.status 'status' " +
                ",m.bonus_percent 'bonus_percent',e.basic_salary 'basic_salary',e.id 'emp_id'," +
                "e.name 'name' from t_agency a, t_mission m, t_sale s,t_employee e " +
                " where  a.id = e.agency_id and m.emp_id = e.id " +
                "and m.start_time != (select max(start_time) from t_mission where emp_id = e.id) and" +
                "  a.id = :agency_id group by m.id order by m.end_time desc";
        if(status<2){
            sql = "select  m.id 'id',m.quantity 'quantity',m.start_time 'start_time', m.end_time 'end_time',m.status 'status' " +
                    ",m.bonus_percent 'bonus_percent',e.basic_salary 'basic_salary',e.id 'emp_id'," +
                    "e.name 'name' from t_agency a, t_mission m, t_sale s,t_employee e " +
                    " where  a.id = e.agency_id and m.emp_id = e.id " +
                    "and m.start_time != (select max(start_time) from t_mission where emp_id = e.id) and" +
                    "  a.id = :agency_id and m.status = :status group by m.id  order by m.end_time desc";
        }
        Query query = session.createNativeQuery(sql);
        query.setParameter("agency_id", agency_id);
        if(status<2){
            query.setParameter("status", status);
        }
        query.setMaxResults(pager.getPageSize()); // 每页显示的个数
        query.setFirstResult(pager.getIndex());//当前页
        List<Object[]> objects = query.list();
        String[] strs = new String[]{"id", "quantity","start_time","end_time","status","bonus_percent","basic_salary","emp_id","name"};
        List<MissionBean> missionBeans = ResultToBean.resultToBean(MissionBean.class, objects, strs);
        pager.setResult(missionBeans);
        return pager;
    }

    @Override//查询历史布置的绩效有多少个
    public long counMissionBeanAgencyHistory(String agency_id,int status) {
        Session session = getSessionFactory().getCurrentSession();
        String sql = "select count(id) from (select  m.id 'id',m.quantity 'quantity',m.start_time 'start_time', m.end_time 'end_time',m.status 'status' " +
                ",m.bonus_percent 'bonus_percent',e.basic_salary 'basic_salary',e.id 'emp_id'," +
                "e.name 'name' from t_agency a, t_mission m, t_sale s,t_employee e " +
                " where  a.id = e.agency_id and m.emp_id = e.id " +
                "and m.start_time != (select max(start_time) from t_mission where emp_id = e.id) and" +
                "  a.id = :agency_id group by m.id) n";
        if(status<2){
            sql =  "select count(id) from (select  m.id 'id',m.quantity 'quantity',m.start_time 'start_time', m.end_time 'end_time',m.status 'status' " +
                    ",m.bonus_percent 'bonus_percent',e.basic_salary 'basic_salary',e.id 'emp_id'," +
                    "e.name 'name' from t_agency a, t_mission m, t_sale s,t_employee e " +
                    " where  a.id = e.agency_id and m.emp_id = e.id " +
                    "and m.start_time != (select max(start_time) from t_mission where emp_id = e.id) and" +
                    "  a.id = :agency_id and m.status = :status group by m.id) n";
        }
        Query query = session.createNativeQuery(sql);
        query.setParameter("agency_id",agency_id);
        if(status<2){
            query.setParameter("status", status);
        }
        Object obj = query.uniqueResult(); // 返回单个结果
        return obj != null ? ((BigInteger) obj).longValue() : null;
    }

    @Override//分页查询最新添加的绩效
    public Pager<MissionBean> queryAllMissionBeanAgencyNewest(Pager<MissionBean> pager, String agency_id,int status) {
        Session session = getSessionFactory().getCurrentSession();
        String sql = "select  m.id 'id',m.quantity 'quantity',m.start_time 'start_time', m.end_time 'end_time',m.status 'status' " +
                ",m.bonus_percent 'bonus_percent',e.basic_salary 'basic_salary',e.id 'emp_id'," +
                "e.name 'name' from t_agency a, t_mission m, t_sale s,t_employee e " +
                " where  a.id = e.agency_id and m.emp_id = e.id " +
                "and m.start_time = (select max(start_time) from t_mission where emp_id = e.id) and" +
                "  a.id = :agency_id group by m.id  order by m.end_time desc";
        if(status<2){
            sql = "select  m.id 'id',m.quantity 'quantity',m.start_time 'start_time', m.end_time 'end_time',m.status 'status' " +
                    ",m.bonus_percent 'bonus_percent',e.basic_salary 'basic_salary',e.id 'emp_id'," +
                    "e.name 'name' from t_agency a, t_mission m, t_sale s,t_employee e " +
                    " where  a.id = e.agency_id and m.emp_id = e.id " +
                    "and m.start_time = (select max(start_time) from t_mission where emp_id = e.id) and" +
                    "  a.id = :agency_id and m.status = :status group by m.id  order by m.end_time desc";
        }
        Query query = session.createNativeQuery(sql);
        query.setParameter("agency_id", agency_id);
        if(status<2){
            query.setParameter("status", status);
        }
        query.setMaxResults(pager.getPageSize()); // 每页显示的个数
        query.setFirstResult(pager.getIndex());//当前页
        List<Object[]> objects = query.list();
        String[] strs = new String[]{"id", "quantity","start_time","end_time","status","bonus_percent","basic_salary","emp_id","name"};
        List<MissionBean> missionBeans = ResultToBean.resultToBean(MissionBean.class, objects, strs);
        pager.setResult(missionBeans);

        return pager;
    }

    @Override//查询最新添加的绩效有多少个
    public long counMissionBeanAgencyNewest(String agency_id,int status) {
        Session session = getSessionFactory().getCurrentSession();
        String sql = "select count(id) from (select  m.id 'id',m.quantity 'quantity',m.start_time 'start_time', m.end_time 'end_time',m.status 'status' " +
                ",m.bonus_percent 'bonus_percent',e.basic_salary 'basic_salary',e.id 'emp_id'," +
                "e.name 'name' from t_agency a, t_mission m, t_sale s,t_employee e " +
                " where  a.id = e.agency_id and m.emp_id = e.id " +
                "and m.start_time = (select max(start_time) from t_mission where emp_id = e.id) and" +
                "  a.id = :agency_id group by m.id) n ";
        if(status<2){
            sql = "select count(id) from (select  m.id 'id',m.quantity 'quantity',m.start_time 'start_time', m.end_time 'end_time',m.status 'status' " +
                    ",m.bonus_percent 'bonus_percent',e.basic_salary 'basic_salary',e.id 'emp_id'," +
                    "e.name 'name' from t_agency a, t_mission m, t_sale s,t_employee e " +
                    " where  a.id = e.agency_id and m.emp_id = e.id " +
                    "and m.start_time = (select max(start_time) from t_mission where emp_id = e.id) and" +
                    "  a.id = :agency_id and m.status = :status group by m.id) n";
        }
        Query query = session.createNativeQuery(sql);
        query.setParameter("agency_id",agency_id);
        if(status<2){
            query.setParameter("status", status);
        }
        Object obj = query.uniqueResult(); // 返回单个结果
        return obj != null ? ((BigInteger) obj).longValue() : null;
    }

    @Override//分页查询一个员工的所有绩效
    public Pager<MissionBean> queryAllMissionBeanEmployee(Pager<MissionBean> pager, String emp_id, int status) {
        Session session = getSessionFactory().getCurrentSession();
        String sql = "select  m.id 'id',m.quantity 'quantity',m.start_time 'start_time', m.end_time 'end_time',m.status 'status' " +
                ",m.bonus_percent 'bonus_percent',e.basic_salary 'basic_salary',e.id 'emp_id'," +
                "e.name 'name' from t_agency a, t_mission m, t_sale s,t_employee e " +
                " where  a.id = e.agency_id and m.emp_id = e.id " +
                "and e.id = :emp_id group by m.id  order by m.end_time desc";
        if(status<2){
            sql = "select  m.id 'id',m.quantity 'quantity',m.start_time 'start_time', m.end_time 'end_time',m.status 'status' " +
                    ",m.bonus_percent 'bonus_percent',e.basic_salary 'basic_salary',e.id 'emp_id'," +
                    "e.name 'name' from t_agency a, t_mission m, t_sale s,t_employee e " +
                    " where  a.id = e.agency_id and m.emp_id = e.id " +
                    "and e.id = :emp_id and m.status = :status group by m.id  order by m.end_time desc";
        }
        Query query = session.createNativeQuery(sql);
        query.setParameter("emp_id", emp_id);
        if(status<2){
            query.setParameter("status", status);
        }
        query.setMaxResults(pager.getPageSize()); // 每页显示的个数
        query.setFirstResult(pager.getIndex());//当前页
        List<Object[]> objects = query.list();
        String[] strs = new String[]{"id", "quantity","start_time","end_time","status","bonus_percent","basic_salary","emp_id","name"};
        List<MissionBean> myBeans = ResultToBean.resultToBean(MissionBean.class, objects, strs);
        pager.setResult(myBeans);
        return pager;
    }

    @Override//查询一个员工的绩效一共有多少个
    public long counMissionBeanEmployee(String emp_id, int status) {
        Session session = getSessionFactory().getCurrentSession();
        String sql = "select count(id) from (select  m.id 'id',m.quantity 'quantity',m.start_time 'start_time', m.end_time 'end_time'," +
                "m.status 'status' ,m.bonus_percent 'bonus_percent',e.basic_salary 'basic_salary'," +
                "e.id 'emp_id',e.name 'name', count(s.emp_id) 'coun' from t_agency a, t_mission m," +
                " t_sale s,t_employee e  where  a.id = e.agency_id and m.emp_id = e.id " +
                "and s.sale_time >= m.start_time and s.sale_time <= m.end_time and s.emp_id = e.id and e.id = :emp_id " +
                " group by m.id,m.start_time) n ";
        if(status<2){
            sql = "select count(id) from (select  m.id 'id',m.quantity 'quantity',m.start_time 'start_time', m.end_time 'end_time'," +
                    "m.status 'status' ,m.bonus_percent 'bonus_percent',e.basic_salary 'basic_salary'," +
                    "e.id 'emp_id',e.name 'name', count(s.emp_id) 'coun' from t_agency a, t_mission m," +
                    " t_sale s,t_employee e  where  a.id = e.agency_id and m.emp_id = e.id " +
                    "and s.sale_time >= m.start_time and s.sale_time <= m.end_time and s.emp_id = e.id and e.id = :emp_id " +
                    "and m.status = :status  group by m.id,m.start_time) n ";
        }
        Query query = session.createNativeQuery(sql);
        query.setParameter("emp_id",emp_id);
        if(status<2){
            query.setParameter("status", status);
        }
        Object obj = query.uniqueResult(); // 返回单个结果
        return obj != null ? ((BigInteger) obj).longValue() : null;
    }

    @Override
    public void updateStatus(String[] id, int status) {
        Session session = getSessionFactory().getCurrentSession();
        Query query = session.createQuery("update Mission set status = :status  where   id  in  (:id)");
        query.setParameter("status", status);
        query.setParameterList("id", id);
        query.executeUpdate();
    }

    @Override
    public Object countSale(String id) {
        Session session = getSessionFactory().getCurrentSession();
        String sql = "select  count(s.emp_id) 'coun' from t_mission m,t_sale s,t_employee e  where  m.emp_id = e.id "
                + "and s.sale_time >= m.start_time and s.sale_time <= m.end_time and s.emp_id = e.id "
                + "and m.id = :id group by m.id,m.start_time ";
        Query query = session.createNativeQuery(sql);
        query.setParameter("id",id);
        Object obj = query.uniqueResult(); // 返回单个结果
        return obj ;
    }
}
