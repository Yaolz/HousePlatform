package com.ht.service.impl;

import com.ht.bean.User;
import com.ht.common.Pager;
import com.ht.dao.UserDAO;
import com.ht.service.UserService;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by CHEN JX on 2017/8/24.
 * 用户
 */
@Transactional
public class UserServiceImpl implements UserService {

    private UserDAO userDAO;

    public void setUserDAO(UserDAO userDAO) {
        this.userDAO = userDAO;
    }

    @Override
    public User queryById(String s) {
        return userDAO.queryById(s);
    }

    @Override
    public void add(User user) {
       userDAO.add(user);
    }

    @Override
    public void remove(User user) {
        userDAO.remove(user);
    }

    @Override
    public void update(User user) {
        userDAO.update(user);
    }

    @Override
    public Pager<User> queryPager(Pager<User> pager) {
        return userDAO.queryPager(pager);
    }

    @Override
    public List<User> queryAll() {
        return userDAO.queryAll();
    }

    @Override
    public int count() {
        return userDAO.count();
    }

    @Override
    public long countId() {
        return userDAO.countId();
    }

    @Override
    public User queryEmailPwd(String email) {
        return userDAO.queryEmailPwd(email);
    }

    @Override
    public void updateStatusById(String[] id, int status) {
        userDAO.updateStatusById(id,status);
    }

    @Override
    public Pager<User> queryPagerStatus(Pager<User> pager, int status) {
        return userDAO.queryPagerStatus(pager,status);
    }

    @Override
    public User queryByPhone(String phone) {
        return userDAO.queryByPhone(phone);
    }

    @Override
    public User queryByNickname(String nickname) {
        return userDAO.queryByNickname(nickname);
    }

    @Override
    public void updatePwd(String pwd,String user_id) {
        userDAO.updatePwd(pwd,user_id);
    }

    @Override
    public void updateUser(User user) {
        userDAO.updateUser(user);
    }
}
