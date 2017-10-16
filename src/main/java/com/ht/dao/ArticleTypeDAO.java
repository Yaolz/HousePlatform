package com.ht.dao;

import com.ht.bean.ArticleType;
import com.ht.common.Pager;

/**
 * Created by CHEN JX on 2017/8/23.
 * 文章类型
 */
public interface ArticleTypeDAO extends BaseDAO<String ,ArticleType> {
    public long countId();
    void updateStatusById(String[] id,int status);
}
