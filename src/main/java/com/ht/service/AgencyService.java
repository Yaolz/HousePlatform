package com.ht.service;

import com.ht.bean.Agency;
import com.ht.common.Pager;

/**
 * Created by CHEN JX on 2017/8/23.
 * 房产经销商
 */
public interface AgencyService extends BaseService<String,Agency> {

    Pager<Agency> queryAllChecked(Pager<Agency> pager, int checked_status);//分页查询未审核或已审核的经销商

    long  countChecked(int checked_status);//获取未审核或已审核的经销商一共有多少个

    void updateChecked(String[] id,int checked_status);//批量审核未审核的经销商

    long  countStatus(int status);//获取冻结或激活的经销商一共有多少个

    void updateStatus(String[] id,int status);//批量激活和冻结经销商

    long  countAll(int checked_status,int status);//获取已审核并且以激活的经销商一共有多少个

    Pager<Agency> queryAllRight(Pager<Agency> pager,int checked_status,int status); // 分页查询以审核并且以激活的经销商

    void updateAgency(Agency agency);//更新经销商的信息，手机的信息不能更改，后续在添加验证短信修改手机号

    void updateEmailPwd(String email,String pwd);//根据邮箱修改密码

    Pager<Agency> queryAllStatus(Pager<Agency> pager,int status);//分页查询冻结或激活的经销商

    Agency queryEmailPwd(String email);//查询邮箱密码

    Agency queryByPhone(String phone);//根据手机查询账户是否存在

    Agency queryByName(String name);//根据名称查询账户是否存在
}
