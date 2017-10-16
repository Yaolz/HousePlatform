package com.ht.controller;

import com.ht.bean.Article;
import com.ht.bean.ArticleType;
import com.ht.bean.User;
import com.ht.common.Content;
import com.ht.common.ControllerResult;
import com.ht.common.Pager;
import com.ht.service.ArticleService;
import com.ht.service.ArticleTypeService;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.interceptor.ServletRequestAware;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by yao on 2017/8/29.
 */
public class ArticleTypeAction extends ActionSupport implements ServletRequestAware {
    private ArticleTypeService articleTypeService;
    private ArticleType articleType;
    private Pager<ArticleType> articleTypePager;
    List<ArticleType> articleTypes;

    private HttpServletRequest request;

    private ControllerResult controllerResult;
    private int pageNo = 1;
    private int pageSize = 10;

    public ArticleType getArticleType() {
        return articleType;
    }

    public void setArticleType(ArticleType articleType) {
        this.articleType = articleType;
    }

    public Pager<ArticleType> getArticleTypePager() {
        return articleTypePager;
    }

    public void setArticleTypePager(Pager<ArticleType> articleTypePager) {
        this.articleTypePager = articleTypePager;
    }

    public void setArticleTypeService(ArticleTypeService articleTypeService) {
        this.articleTypeService = articleTypeService;
    }

    public ControllerResult getControllerResult() {
        return controllerResult;
    }

    public String ArticleType() {
        return "ArticleType";
    }

    public int getPageNo() {
        return pageNo;
    }

    public void setPageNo(int pageNo) {
        this.pageNo = pageNo;
    }

    public int getPageSize() {
        return pageSize;
    }

    public List<ArticleType> getArticleTypes() {
        return articleTypes;
    }

    public String articleType(){
        return "articleType";
    }

    //添加文章类别
    public String addArticleType() {
        articleType.setStatus(1);
        articleTypeService.add(articleType);
        controllerResult = ControllerResult.getSuccessResult("添加成功！");
        return "addArticleType";
    }


    //文章类别分页
    public String articleTypejson(){
        articleTypePager = new Pager<>();
        articleTypePager.setPageSize(pageSize);
        if (pageNo < 1) {
            articleTypePager.setPageNo(1);
        } else {
            articleTypePager.setPageNo(pageNo);
        }
        articleTypePager = articleTypeService.queryPager(articleTypePager);
        return "articleTypejson";
    }
    //修改文章类别
    public String changeArticleType(){
        articleTypeService.update(articleType);
        controllerResult=ControllerResult.getSuccessResult("修改成功！");
        return "changeArticleType";
    }
    //修改文章状态
    public String status(){
        String id = request.getParameter("checkedIds");    //获取前台隐藏域存着的选中的复选框的value
        String checkedIds[] = id.split(",");
        if(articleType.getStatus()== Content.StatusYes){
            articleTypeService.updateStatusById(checkedIds,Content.CheckNo);
        }else{
            articleTypeService.updateStatusById(checkedIds,Content.CheckYes);
        }
        return "status";
    }
    public String addType(){
        return "addType";
    }

    // 在前台页面显示已激活的文章类别
    public String showType() {
        articleTypes = articleTypeService.queryAll();
        return "showType";
    }

    @Override
    public void setServletRequest(HttpServletRequest httpServletRequest) {
        this.request = httpServletRequest;
    }
}
