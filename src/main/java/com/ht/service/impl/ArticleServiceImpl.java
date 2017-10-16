package com.ht.service.impl;

import com.ht.bean.Article;
import com.ht.common.Pager;
import com.ht.dao.ArticleDAO;
import com.ht.service.ArticleService;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by CHEN JX on 2017/8/23.
 * 文章
 */
@Transactional
public class ArticleServiceImpl implements ArticleService{

    private ArticleDAO articleDAO;

    public void setArticleDAO(ArticleDAO articleDAO) {
        this.articleDAO = articleDAO;
    }

    @Override
    public Article queryById(String s) {
        return articleDAO.queryById(s);
    }

    @Override
    public void add(Article article) {
        articleDAO.add(article);
    }

    @Override
    public void remove(Article article) {
        articleDAO.remove(article);
    }

    @Override
    public void update(Article article) {
        articleDAO.update(article);
    }

    @Override
    public Pager<Article> queryPager(Pager<Article> pager) {
        return articleDAO.queryPager(pager);
    }

    @Override
    public List<Article> queryAll() {
        return articleDAO.queryAll();
    }

    @Override
    public int count() {
        return 0;
    }

    @Override
    public long countId() {
        return articleDAO.countId();
    }

    @Override
    public void updateStatusById(String[] id,int status) {
        articleDAO.updateStatusById(id,status);
    }

    @Override
    public Pager<Article> queryPager(Pager<Article> pager, int status) {
        return articleDAO.queryPager(pager,status);
    }

    @Override
    public Pager<Article> queryAllindex(Pager<Article> pager, String type, String like) {
        pager.setTotal(articleDAO.countAllindex(type,like));
        return articleDAO.queryAllindex(pager,type,like);
    }

}
