package com.ht.service;

import com.ht.bean.Ads;
import com.ht.common.Pager;

import java.util.List;

/**
 * Created by CHEN JX on 2017/8/23.
 * 广告
 */
public interface AdsService extends BaseService<String,Ads> {
    long  countId();//获取广告的总数
    Pager<Ads> queryAllStatus(Pager<Ads> pager, int status); // 查询出冻结或激活的广告
    void updateStatus(String[] id,int status);//批量激活和冻结广告
    List<Ads> queryShow(int beginNum, int endNum); // 页面指定显示哪些广告
}
