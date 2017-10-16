package com.ht.dao;

import com.ht.bean.Article;
import com.ht.common.Pager;

/**
 * Created by CHEN JX on 2017/8/23.
 * 文章
 */
public interface ArticleDAO extends BaseDAO<String , Article>{
     long countId();
     void updateStatusById(String[] id,int status);
     Pager<Article> queryPager(Pager<Article> pager,int status);

     Pager<Article> queryAllindex(Pager<Article> pager, String type, String like); // 根据条件查询文章

     long countAllindex(String type,String like); // 查出文章的数量
}
