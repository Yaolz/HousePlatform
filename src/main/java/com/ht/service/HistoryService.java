package com.ht.service;

import com.ht.bean.History;
import com.ht.common.Pager;

/**
 * Created by CHEN JX on 2017/8/23.
 * 历史纪录
 */
public interface HistoryService  extends BaseService<String,History>{

    Pager<History> queryAllHistory(Pager<History> pager, String user_id);//分页查看某个用户下的历史记录

    Long countHistory(String user_id);//查看某个用户下的历史纪录有多少个

    History queryById(String user_id,String buildings_id);//根据用户与楼盘的id来查看历史纪录

}
