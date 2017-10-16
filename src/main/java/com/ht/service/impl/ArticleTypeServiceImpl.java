package com.ht.service.impl;

import com.ht.bean.Article;
import com.ht.bean.ArticleType;
import com.ht.common.Pager;
import com.ht.dao.ArticleDAO;
import com.ht.dao.ArticleTypeDAO;
import com.ht.service.ArticleService;
import com.ht.service.ArticleTypeService;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by CHEN JX on 2017/8/23.
 * 文章
 */
@Transactional
public class ArticleTypeServiceImpl implements ArticleTypeService{

    private ArticleTypeDAO articleTypeDAO;

    public void setArticleTypeDAO(ArticleTypeDAO articleTypeDAO) {
        this.articleTypeDAO = articleTypeDAO;
    }

    @Override
    public ArticleType queryById(String s) {
        return articleTypeDAO.queryById(s);
    }

    @Override
    public void add(ArticleType articleType) {
        articleTypeDAO.add(articleType);
    }

    @Override
    public void remove(ArticleType articleType) {
        articleTypeDAO.remove(articleType);
    }

    @Override
    public void update(ArticleType articleType) {
        articleTypeDAO.update(articleType);
    }

    @Override
    public Pager<ArticleType> queryPager(Pager<ArticleType> pager) {
        return articleTypeDAO.queryPager(pager);
    }

    @Override
    public List<ArticleType> queryAll() {
        return articleTypeDAO.queryAll();
    }

    @Override
    public int count() {
        return articleTypeDAO.count();
    }

    @Override
    public long countId() {
        return articleTypeDAO.countId();
    }

    @Override
    public void updateStatusById(String[] id, int status) {
        articleTypeDAO.updateStatusById(id,status);
    }
}
