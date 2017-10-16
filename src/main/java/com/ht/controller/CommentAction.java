package com.ht.controller;

import com.ht.bean.*;
import com.ht.common.Content;
import com.ht.common.ControllerResult;
import com.ht.common.Pager;
import com.ht.price.BuildingsPrice;
import com.ht.price.UserPrice;
import com.ht.service.CommentService;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.interceptor.ServletRequestAware;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

/**
 * Created by CHEN JX on 2017/9/8.
 * 用户评价
 */
public class CommentAction extends ActionSupport implements ServletRequestAware {

    private CommentService commentService;
    private HttpServletRequest request;
    private Comment comment;
    private UserPrice userPrice;
    private BuildingsPrice buildingsPrice;
    private Buildings buildings;

    private Pager<Comment> commentPager;
    private List<Comment> comments;

    private ControllerResult result;
    private long total;
    private int totalPage;
    private int page = 1;
    private int pageSize = 10;
    private String buildingsId;
    private String[] checkedIds;
    private ControllerResult controllerResult;

    public String getBuildingsId() {
        return buildingsId;
    }

    public void setBuildingsId(String buildingsId) {
        this.buildingsId = buildingsId;
    }

    public Comment getComment() {
        return comment;
    }

    public void setComment(Comment comment) {
        this.comment = comment;
    }

    public void setCommentService(CommentService commentService) {
        this.commentService = commentService;
    }

    public UserPrice getUserPrice() {
        return userPrice;
    }

    public void setUserPrice(UserPrice userPrice) {
        this.userPrice = userPrice;
    }

    public List<Comment> getComments() {
        return comments;
    }

    public void setComments(List<Comment> comments) {
        this.comments = comments;
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

    public BuildingsPrice getBuildingsPrice() {
        return buildingsPrice;
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

    public Pager<Comment> getCommentPager() {
        return commentPager;
    }

    public void setCommentPager(Pager<Comment> commentPager) {
        this.commentPager = commentPager;
    }

    public String[] getCheckedIds() {
        return checkedIds;
    }

    public void setCheckedIds(String[] checkedIds) {
        this.checkedIds = checkedIds;
    }

    public ControllerResult getControllerResult() {
        return controllerResult;
    }

    public void setControllerResult(ControllerResult controllerResult) {
        this.controllerResult = controllerResult;
    }

    // 添加评论
    public String addComments() {
        comment.setComment_time(new Date());
        comment.setStatus(1);
        comment.setUserPrice(userPrice);
        comment.setBuildingsPrice(buildingsPrice);
        commentService.add(comment);
        result = ControllerResult.getSuccessResult("发表成功");
        return "addComments";
    }

    //后台分页查看评价
    public String comments() {
        HttpSession session = request.getSession();
        User loginUser = (User) session.getAttribute("user");
        Pager<Comment> commentPager = new Pager<>();
        int count = commentService.countComment(loginUser.getId()).intValue();
        int pageCount = count % pageSize == 0 ? count / pageSize : (count / pageSize) + 1;
        if (page <= 0) {
            page = 1;
        }
        if (page > pageCount) {
            page = pageCount;
        }
        commentPager.setPageNo(page);//有多少页
        commentPager.setPageSize(pageSize);//每页多少个
        commentPager = commentService.queryAllComment(commentPager, loginUser.getId());
        comments = commentPager.getResult();
        request.setAttribute("pageCount", pageCount);
        session.setAttribute("comments", comments);
        return "comments";
    }


    public String updateComment() {//修改评论
        HttpSession session = request.getSession();
        String id = request.getParameter("comment.id");
        String content = request.getParameter("comment.content");
        commentService.updateCommentContext(content, id);
        result = ControllerResult.getSuccessResult("修改成功");
        comment = commentService.queryById(id);
        session.setAttribute("comment", comment);
        return "updateComment";

    }
    //激活冻结评论
    public String status() {
        if (comment.getStatus() == 0) {
            commentService.updateCommentStatus(comment.getId(), Content.ShowStatusYes);
        } else {
            commentService.updateCommentStatus(comment.getId(), Content.ShowStatusNo);
        }
        return "status";
    }

    public String buildingsCommentPage() {
        return "buildingsCommentPage";
    }

    //前台页面分页查看评论
    public String buildingsComment() {
        commentPager = new Pager<>();
        commentPager.setPageSize(pageSize);
        if (page < 1) {
            commentPager.setPageNo(1);
        } else {
            commentPager.setPageNo(page);
        }
        commentPager = commentService.queryAllCommentBuildings(commentPager,buildingsId,1);
        return "buildingsComment";
    }
    //经销商查看楼盘下的评价·
    public String pagerByBuildings(){
        HttpSession session = request.getSession();
        commentPager = new Pager<>();
        commentPager.setPageSize(pageSize);
        if (page < 1) {
            commentPager.setPageNo(1);
        } else {
            commentPager.setPageNo(page);
        }
        if (session.getAttribute("agency") != null) {
            Agency agency = (Agency) session.getAttribute("agency");
            if(buildingsId.equals("所有楼盘")){
                commentPager=commentService.queryAllCommentAgency(commentPager,agency.getId(),1);
            }else {
                commentPager=commentService.queryAllCommentBuildings(commentPager,buildingsId,1);
            }
        }
        return "pagerByBuildings";
    }
    public String pagerByBuildingsPage(){
        return "pagerByBuildingsPage";
    }
    //管理员删除评论
    public String deleteComment(){
        String checkedId[] =checkedIds;
        for (int i=0; i<checkedId.length; i++){
            System.out.println(checkedId[i]);
        }
        commentService.deleteComment(checkedId);
        return "deleteComment";
    }
    @Override
    public void setServletRequest(HttpServletRequest request) {
        this.request = request;
    }
}
