package com.ht.service;

import com.ht.common.Pager;

import java.util.List;

/**
 * Created by CHEN JX on 2017/8/23.
 */
public interface BaseService<PK,T> {

     T  queryById(PK id);
     void add(T t);
     void remove(T t);
     void update(T t);
     Pager<T> queryPager(Pager<T> pager);
     List<T> queryAll();
     int count();
}
