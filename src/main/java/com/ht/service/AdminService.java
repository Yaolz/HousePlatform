package com.ht.service;

import com.ht.bean.Admin;
import com.ht.bean.Agency;

/**
 * Created by yao on 2017/8/26.
 */
public interface AdminService extends BaseService<String,Admin> {
    Admin queryByEmailPwd(String email);
    void updatePwd(Admin admin);
    Admin queryPwd(String pwd);
}
