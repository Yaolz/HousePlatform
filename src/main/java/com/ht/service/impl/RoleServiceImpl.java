package com.ht.service.impl;

import com.ht.bean.Role;
import com.ht.common.Pager;
import com.ht.dao.RoleDAO;
import com.ht.service.RoleService;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by CHEN JX on 2017/8/24.
 * 角色
 */
@Transactional
public class RoleServiceImpl implements RoleService {

    private RoleDAO roleDAO;

    public void setRoleDAO(RoleDAO roleDAO) {
        this.roleDAO = roleDAO;
    }

    @Override
    public Role queryById(String s) {
        return roleDAO.queryById(s);
    }

    @Override
    public void add(Role role) {
       roleDAO.add(role);
    }

    @Override
    public void remove(Role role) {
        roleDAO.remove(role);
    }

    @Override
    public void update(Role role) {
        roleDAO.update(role);
    }

    @Override
    public Pager<Role> queryPager(Pager<Role> pager) {
        return roleDAO.queryPager(pager);
    }

    @Override
    public List<Role> queryAll() {
        return roleDAO.queryAll();
    }

    @Override
    public int count() {
        return 0;
    }
}
