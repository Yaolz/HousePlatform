package com.ht.service;

import com.ht.bean.Like;
import com.ht.common.Pager;

import java.util.List;

/**
 * Created by CHEN JX on 2017/8/24.
 * 点赞
 */
public interface LikeService extends BaseService<String,Like> {

    Pager<Like> queryAllLike(Pager<Like> pager, String user_id);//分页查询某个用户下的点赞记录

    long countLike(String user_id);//查询某个用户下的点赞记录有多少个

    Like queryByid(String user_id, String buildings_id);//根据用户与楼盘id来查询点赞
}
