package com.ht.service;

import com.ht.bean.BuildingsImg;
import com.ht.common.Pager;

/**
 * Created by CHEN JX on 2017/8/23.
 * 楼盘图片
 */
public interface BuildingsImgService extends BaseService<String,BuildingsImg> {

    Pager<BuildingsImg> queryAllBuildingsImg(Pager<BuildingsImg> pager , String buildings_id);//分页查询某个楼盘的图片

    long countBuildingsImg(String buildings_id);//查询某个楼盘的图片有多少张
}
