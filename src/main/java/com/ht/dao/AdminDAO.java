package com.ht.dao;

import com.ht.bean.Admin;
import com.ht.bean.Agency;

/**
 * Created by yao on 2017/8/26.
 */
public interface AdminDAO extends BaseDAO<String,Admin> {
    Admin queryByEmailPwd(String email);
    Admin queryPwd(String pwd);
    void updatePwd(Admin admin);
}
