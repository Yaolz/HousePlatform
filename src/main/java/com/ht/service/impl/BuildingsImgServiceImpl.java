package com.ht.service.impl;

import com.ht.bean.BuildingsImg;
import com.ht.common.Pager;
import com.ht.dao.BuildingsImgDAO;
import com.ht.service.BuildingsImgService;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by CHEN JX on 2017/8/23.
 * 楼盘图片
 */
@Transactional
public class BuildingsImgServiceImpl implements BuildingsImgService {

    private BuildingsImgDAO buildingsImgDAO;

    public void setBuildingsImgDAO(BuildingsImgDAO buildingsImgDAO) {
        this.buildingsImgDAO = buildingsImgDAO;
    }

    @Override
    public BuildingsImg queryById(String s) {
        return buildingsImgDAO.queryById(s);
    }

    @Override
    public void add(BuildingsImg buildingsImg) {
        buildingsImgDAO.add(buildingsImg);
    }

    @Override
    public void remove(BuildingsImg buildingsImg) {
        buildingsImgDAO.remove(buildingsImg);
    }

    @Override
    public void update(BuildingsImg buildingsImg) {
        buildingsImgDAO.update(buildingsImg);
    }

    @Override
    public Pager<BuildingsImg> queryPager(Pager<BuildingsImg> pager) {
       return buildingsImgDAO.queryPager(pager);
    }

    @Override
    public List<BuildingsImg> queryAll() {
        return buildingsImgDAO.queryAll();
    }

    @Override
    public int count() {
        return 0;
    }

    @Override
    public Pager<BuildingsImg> queryAllBuildingsImg(Pager<BuildingsImg> pager, String buildings_id) {
        return buildingsImgDAO.queryAllBuildingsImg(pager,buildings_id);
    }

    @Override
    public long countBuildingsImg(String buildings_id) {
        return buildingsImgDAO.countBuildingsImg(buildings_id);
    }
}
