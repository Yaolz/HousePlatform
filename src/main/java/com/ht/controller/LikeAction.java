package com.ht.controller;

import com.ht.bean.Buildings;
import com.ht.bean.Comment;
import com.ht.bean.Like;
import com.ht.bean.User;
import com.ht.common.ControllerResult;
import com.ht.common.Pager;
import com.ht.price.BuildingPrice;
import com.ht.price.BuildingsPrice;
import com.ht.price.UserPrice;
import com.ht.service.CommentService;
import com.ht.service.LikeService;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.interceptor.ServletRequestAware;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Calendar;
import java.util.List;

/**
 * Created by CHEN JX on 2017/9/8.
 * 用户点赞
 */
public class LikeAction extends ActionSupport implements ServletRequestAware {

    private LikeService likeService;

    private HttpServletRequest request;

    private Like like;
    private Buildings buildings;

    private List<Like> likes;
    private UserPrice userPrice;
    private BuildingsPrice buildingsPrice;
    private String buildingsId;

    public void setUserPrice(UserPrice userPrice) {
        this.userPrice = userPrice;
    }

    public void setBuildingsPrice(BuildingsPrice buildingsPrice) {
        this.buildingsPrice = buildingsPrice;
    }

    public Buildings getBuildings() {
        return buildings;
    }

    public void setBuildings(Buildings buildings) {
        this.buildings = buildings;
    }

    private ControllerResult result;
    private long total;
    private int totalPage;
    private int page = 1;
    private int pageSize = 5;


    public void setLikeService(LikeService likeService) {
        this.likeService = likeService;
    }

    public Like getLike() {
        return like;
    }

    public void setLike(Like like) {
        this.like = like;
    }

    public List<Like> getLikes() {
        return likes;
    }

    public void setLikes(List<Like> likes) {
        this.likes = likes;
    }

    public ControllerResult getResult() {
        return result;
    }

    public void setResult(ControllerResult result) {
        this.result = result;
    }

    public long getTotal() {
        return total;
    }

    public void setTotal(long total) {
        this.total = total;
    }

    public int getTotalPage() {
        return totalPage;
    }

    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public String getBuildingsId() {
        return buildingsId;
    }

    public void setBuildingsId(String buildingsId) {
        this.buildingsId = buildingsId;
    }

    //分页查看点赞 user/good
    public String good(){

        HttpSession session = request.getSession();
        User loginUser = (User) session.getAttribute("user");
        Pager<Like> likePager = new Pager<>();
        int count = (int) likeService.countLike(loginUser.getId());
        int pageCount = count % pageSize == 0 ? count / pageSize : (count / pageSize) + 1;
        if (page <= 0) {
            page = 1;
        }
        if (page > pageCount) {
            page = pageCount;
        }
        likePager.setPageNo(page);//有多少页
        likePager.setPageSize(pageSize);//每页多少个
        likePager = likeService.queryAllLike(likePager,loginUser.getId());
        likes = likePager.getResult();
        request.setAttribute("pageCount", pageCount);
        session.setAttribute("likes", likes);
        return "good";
    }

    //添加点赞
    public String addLike(){

        HttpSession  session = request.getSession();

        if(session.getAttribute("user")!=null){
            User u = (User) session.getAttribute("user");
            Like like1 = likeService.queryByid(u.getId(), buildingsId);
            if(like1!=null){
                likeService.remove(like1);
                result = ControllerResult.getSuccessResult("取消成功");
            }else{
                userPrice.setId(u.getId());
                buildingsPrice.setId(buildingsId);
                like.setUserPrice(userPrice);
                like.setBuildingsPrice(buildingsPrice);
                like.setCreated_time(Calendar.getInstance().getTime());
                likeService.add(like);
                result = ControllerResult.getSuccessResult("点赞成功");
            }

        }

        return "addLike";
    }



    //取消点赞

    public String updateLike(){

        like.setId(like.getId());
        likeService.remove(like);
        return "updateLike";
    }








    @Override
    public void setServletRequest(HttpServletRequest request) {
        this.request = request;
    }
}
