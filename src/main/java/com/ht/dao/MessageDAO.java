package com.ht.dao;

import com.ht.bean.Message;
import com.ht.common.Pager;

/**
 * Created by CHEN JX on 2017/8/24.
 * 留言
 */
public interface MessageDAO extends BaseDAO<String,Message>{

    Pager<Message> queryAllMessage(Pager<Message> pager,String user_id);//分页查询某个用户自己的留言

    Long countMessage(String user_id);//查询用户自己的留言有多少个

    Pager<Message> queryAllMessage(Pager<Message> pager,String user_id,int status);//分页查询某个用户下被冻结或激活的留言有多少个

    long countMessage(String user_id,int status);//查询某个用户下被冻结或激活的留言有多少个

    Pager<Message> queryAllMessageBuildings(Pager<Message> pager,String buildings_id,int status);//分页查询某个楼盘下被冻结或激活的留言有多少个

    long countMessageBuildings(String buildings_id,int status);//某个楼盘下被冻结或激活的留言有多少个

    Pager<Message> queryAllMessageAgency(Pager<Message> pager,String agency_id,int status);//分页查询经销商下的所有楼盘下被冻结或激活的留言有多少个

    long countMessageAgency(String agency_id,int status);//查询经销商下的所有楼盘下被冻结或激活的留言有多少个

    void updateMessageStatus(String[]  id,int status);//批量冻结留言

    void updateupdateMessageUser(Message message);//用户修改留言信息

    void updateupdateMessageBuildings(Message message);//楼盘回复留言内容


    void updateMessageContent(String content ,String id);//根据id来修改留言内容


    void updateMessageStatus(String id,int status);//根据id来修改留言状态
}
