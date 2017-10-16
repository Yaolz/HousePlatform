package com.ht.service;

import com.ht.bean.Article;
import com.ht.bean.ArticleType;

/**
 * Created by CHEN JX on 2017/8/23.
 * 文章
 */
public interface ArticleTypeService extends BaseService<String,ArticleType> {
    public long countId();
    void updateStatusById(String[] id,int status);
}
