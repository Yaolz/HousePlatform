package com.ht.dao;

import org.hibernate.SessionFactory;

/**
 * Created by CHEN JX on 2017/8/23.
 */
public class AbstractBaseDAO {

    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    public SessionFactory getSessionFactory(){
        return sessionFactory;
    }
}
