package com.ht.dao;

import com.ht.bean.BuildingsAvgprice;
import com.ht.bean.Sale;
import com.ht.common.Pager;

import java.util.Date;
import java.util.List;

/**
 * Created by CHEN JX on 2017/8/24.
 * 销售记录
 */
public interface SaleDAO extends BaseDAO<String,Sale> {

    Pager<Sale> queryPager(Pager<Sale> pager,String emp_id);//分页查询

    List<Sale> queryAllSale(String emp_id); //房屋销售图表查看

    void updateStatus(String[] id,int status);//批量冻结或激活

    //更新sale的数据
    void updateSale(Sale sale);

    long countSale(String emp_id);//查询员工添加的销售记录有多少个

    Sale queryByRoom(String room_id);//根据房号表的id查询销售记录表的信息
}
