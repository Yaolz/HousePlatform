package com.ht.service.impl;

import com.ht.bean.Like;
import com.ht.common.Pager;
import com.ht.dao.LikeDAO;
import com.ht.service.LikeService;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by CHEN JX on 2017/8/24.
 * 点赞
 */
@Transactional
public class LikeServiceImpl implements LikeService{

    private LikeDAO likeDAO;

    public void setLikeDAO(LikeDAO likeDAO) {
        this.likeDAO = likeDAO;
    }

    @Override
    public Like queryById(String s) {
        return likeDAO.queryById(s);
    }

    @Override
    public void add(Like like) {
        likeDAO.add(like);
    }

    @Override
    public void remove(Like like) {
        likeDAO.remove(like);
    }

    @Override
    public void update(Like like) {
        likeDAO.update(like);
    }

    @Override
    public Pager<Like> queryPager(Pager<Like> pager) {
        return likeDAO.queryPager(pager);
    }

    @Override
    public List<Like> queryAll() {
        return likeDAO.queryAll();
    }

    @Override
    public int count() {
        return likeDAO.count();
    }

    @Override
    public Pager<Like> queryAllLike(Pager<Like> pager, String user_id) {
        return likeDAO.queryAllLike(pager,user_id);
    }

    @Override
    public long countLike(String user_id) {
        return likeDAO.countLike(user_id);
    }

    @Override
    public Like queryByid(String user_id, String buildings_id) {
        return likeDAO.queryByid(user_id,buildings_id);
    }
}
