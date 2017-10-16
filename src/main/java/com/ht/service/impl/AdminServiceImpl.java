package com.ht.service.impl;

import com.ht.bean.Admin;
import com.ht.bean.Agency;
import com.ht.common.Pager;
import com.ht.dao.AdminDAO;
import com.ht.service.AdminService;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by yao on 2017/8/26.
 */
@Transactional
public class AdminServiceImpl implements AdminService {

    private AdminDAO adminDAO;

    public void setAdminDAO(AdminDAO adminDAO) {
        this.adminDAO = adminDAO;
    }


    @Override
    public Admin queryById(String s) {
        return adminDAO.queryById(s);
    }

    @Override
    public void add(Admin admin) {
        adminDAO.add(admin);
    }

    @Override
    public void remove(Admin admin) {
        adminDAO.remove(admin);
    }

    @Override
    public void update(Admin admin) {
        adminDAO.update(admin);
    }

    @Override
    public Pager<Admin> queryPager(Pager<Admin> pager) {
        return adminDAO.queryPager(pager);
    }

    @Override
    public List<Admin> queryAll() {
        return adminDAO.queryAll();
    }

    @Override
    public int count() {
        return adminDAO.count();
    }

    @Override
    public Admin queryByEmailPwd(String email) {
        return adminDAO.queryByEmailPwd(email);
    }

    @Override
    public Admin queryPwd(String pwd) {
        return adminDAO.queryPwd(pwd);
    }

    @Override
    public void updatePwd(Admin admin) {
        adminDAO.updatePwd(admin);
    }

}
