package com.ht.service;

import com.ht.bean.Comment;
import com.ht.common.Pager;

/**
 * Created by CHEN JX on 2017/8/23.
 * 评价
 */
public interface CommentService extends BaseService<String,Comment> {

    Pager<Comment> queryAllComment(Pager<Comment> pager,String user_id);//分页查询某个用户下的评价记录

    Long countComment(String user_id);//查询某个用户下的评价有多少个

    Pager<Comment> queryAllCommentBuildings(Pager<Comment> pager,String buildings_id,int status);//分页查询某个楼盘下的评价记录

    Long countCommentBuildings(String buildings_id, int status);//查询某个楼盘下的评价有多少个

    Pager<Comment> queryAllCommentAgency(Pager<Comment> pager,String agency_id, int status);//分页查询某个经销商下所有楼盘的评价记录

    Long countCommentAgency(String agency_id, int status);//查询某个经销商下所有楼盘的评价记录有多少个

    void updateCommentContext(String content ,String id);//根据id来修改评论内容

    void updateCommentStatus(String id,int status);//根据id来修改评论状态
    void deleteComment(String[] id);
}
