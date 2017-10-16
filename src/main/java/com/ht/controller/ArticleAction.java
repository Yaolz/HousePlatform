package com.ht.controller;

import com.ht.bean.Admin;
import com.ht.bean.Article;
import com.ht.bean.ArticleType;
import com.ht.common.Content;
import com.ht.common.ControllerResult;
import com.ht.common.Pager;
import com.ht.service.ArticleService;
import com.ht.service.ArticleTypeService;
import com.ht.util.FileUtil;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.commons.io.FileUtils;
import org.apache.struts2.interceptor.ServletRequestAware;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;

/**
 * Created by yao on 2017/8/31.
 */
public class ArticleAction extends ActionSupport implements ServletRequestAware {
    private HttpServletRequest request;
    private ArticleService articleService;
    private ArticleTypeService articleTypeService;

    private Article article;
    private Pager<Article> pager;
    private ArticleType articleType;
    private Admin admin;
    private List<ArticleType> articleTypes;
    private ControllerResult controllerResult;
    private int pageNo = 1;
    private int pageSize = 10;
    private String typeId;
    private String like;

    private File upload; // 与form表单中file的name一致，temp文件， ROOT/upload_cc3fa222_9f87_4066_af9b_8b7f07e77389_00000000.tmp
    private String uploadFileName; // 此变量的名称固定为file的name + "FileName"

    public ControllerResult getControllerResult() {
        return controllerResult;
    }

    public void setControllerResult(ControllerResult controllerResult) {
        this.controllerResult = controllerResult;
    }

    public Article getArticle() {
        return article;
    }

    public void setArticle(Article article) {
        this.article = article;
    }

    public Pager<Article> getPager() {
        return pager;
    }

    public void setPager(Pager<Article> pager) {
        this.pager = pager;
    }

    public ArticleType getArticleType() {
        return articleType;
    }

    public void setArticleType(ArticleType articleType) {
        this.articleType = articleType;
    }

    public Admin getAdmin() {
        return admin;
    }

    public void setAdmin(Admin admin) {
        this.admin = admin;
    }

    public void setArticleService(ArticleService articleService) {
        this.articleService = articleService;
    }

    public void setArticleTypeService(ArticleTypeService articleTypeService) {
        this.articleTypeService = articleTypeService;
    }

    public List<ArticleType> getArticleTypes() {
        return articleTypes;
    }

    public void setArticleTypes(List<ArticleType> articleTypes) {
        this.articleTypes = articleTypes;
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

    public String getTypeId() {
        return typeId;
    }

    public void setTypeId(String typeId) {
        this.typeId = typeId;
    }

    public String getLike() {
        return like;
    }

    public void setLike(String like) {
        this.like = like;
    }

    public void setUpload(File upload) {
        this.upload = upload;
    }

    public void setUploadFileName(String uploadFileName) {
        this.uploadFileName = uploadFileName;
    }

    //添加文章
    public String addArticle() {
        try {
            FileUtils.copyFile(upload, new File(FileUtil.uploadPath() + File.separator + uploadFileName));
            article.setLogo(FileUtil.UPLOADS + "/" + uploadFileName);
        } catch (IOException e) {
            e.printStackTrace();
        }
        article.setCreated_time(new Date());
        article.setStatus(1);
        article.setAdmin(admin);
        article.setArticleType(articleType);
        articleService.add(article);
        controllerResult = ControllerResult.getSuccessResult("添加成功！");
        return "addArticle";
    }

    public String addPage() {
        articleTypes = articleTypeService.queryAll();
        return "addPage";
    }

    //文章信息分页
    public String articleInfo() {
        pager = new Pager<>();
        pager.setPageSize(pageSize);
        if (pageNo < 1) {
            pager.setPageNo(1);
        } else {
            pager.setPageNo(pageNo);
        }
        pager = articleService.queryPager(pager);
        return "articleInfo";
    }

    public String articleInfoPage() {
        articleTypes = articleTypeService.queryAll();
        return "articleInfoPage";
    }

    //文章详情
    public String articleDetail() {
        article = articleService.queryById(article.getId());
        return "articleDetail";
    }

    //修改文章
    public String changeArticle(){
        try {
            FileUtils.copyFile(upload, new File(FileUtil.uploadPath() + File.separator + uploadFileName));
            article.setLogo(FileUtil.UPLOADS + "/" + uploadFileName);
        } catch (IOException e) {
            e.printStackTrace();
        }
        article.setArticleType(articleType);
        article.setAdmin(admin);
        articleService.update(article);
        article.setStatus(Content.ShowStatusYes);
        controllerResult = ControllerResult.getSuccessResult("修改成功！");
        return "changeArticle";
    }

    //激活文章状态
    public String status() {
        String id = request.getParameter("checkedIds");    //获取前台隐藏域存着的选中的复选框的value
        String checkedIds[] = id.split(",");
        if (article.getStatus() == 0) {
            articleService.updateStatusById(checkedIds, Content.CheckYes);
        } else if (article.getStatus() == 1) {
            articleService.updateStatusById(checkedIds, Content.CheckNo);
        }
        return "status";
    }

    // 前台所有已激活的文章,用于搜索
    public String articleIndex() {
        pager = new Pager<>();
        pager.setPageSize(pageSize);
        if (pageNo < 1) {
            pager.setPageNo(1);
        } else {
            pager.setPageNo(pageNo);
        }
        pager = articleService.queryAllindex(pager,typeId,like);
        return "articleIndex";
    }

    //页面显示文章
    public String articlePage(){
        pager = new Pager<>();
        pager.setPageSize(pageSize);
        if (pageNo < 1) {
            pager.setPageNo(1);
        } else {
            pager.setPageNo(pageNo);
        }
        pager = articleService.queryPager(pager,1);
        return "articlePage";
    }
    public void setServletRequest(HttpServletRequest httpServletRequest) {
        this.request = httpServletRequest;
    }
}
