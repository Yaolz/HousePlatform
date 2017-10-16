package com.ht.dao;

import com.ht.common.Pager;

import java.util.List;

/**
 * Created by CHEN JX on 2017/8/23.
 */
public interface BaseDAO<PK,T> {
    public T  queryById(PK id);
    public void add(T t);
    public void remove(T t);
    public void update(T t);
    public Pager<T> queryPager(Pager<T> pager);
    public List<T> queryAll();
    public int count();
}
