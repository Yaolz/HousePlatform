package com.ht.controller;

import com.ht.bean.Building;
import com.ht.bean.Buildings;
import com.ht.bean.History;
import com.ht.bean.User;
import com.ht.common.ControllerResult;
import com.ht.common.Pager;
import com.ht.price.BuildingsPrice;
import com.ht.price.UserPrice;
import com.ht.service.BuildingService;
import com.ht.service.BuildingsService;
import com.ht.service.HistoryService;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.interceptor.ServletRequestAware;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Calendar;
import java.util.List;

/**
 * Created by CHEN JX on 2017/9/8.
 * 用户历史记录
 */
public class HistoryAction extends ActionSupport implements ServletRequestAware {

    private HistoryService historyService;

    private BuildingsService buildingsService;
    private UserPrice userPrice;
    private BuildingsPrice buildingsPrice;


    private HttpServletRequest request;

    private History history;
    private String buildingsId;
    private String userId;

    private List<History> histories;


    private ControllerResult result;
    private long total;
    private int totalPage;
    private int pageNo = 1;
    private int pageSize = 5;

    private HttpSession session;


    public void setHistoryService(HistoryService historyService) {
        this.historyService = historyService;
    }

    public void setBuildingsService(BuildingsService buildingsService) {
        this.buildingsService = buildingsService;
    }

    public void setUserPrice(UserPrice userPrice) {
        this.userPrice = userPrice;
    }

    public void setBuildingsPrice(BuildingsPrice buildingsPrice) {
        this.buildingsPrice = buildingsPrice;
    }

    public History getHistory() {
        return history;
    }

    public void setHistory(History history) {
        this.history = history;
    }

    public List<History> getHistories() {
        return histories;
    }

    public void setHistories(List<History> histories) {
        this.histories = histories;
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

    public int getPageNo() {
        return pageNo;
    }

    public void setPageNo(int pageNo) {
        this.pageNo = pageNo;
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

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String history() {
        session = request.getSession();
        User loginUser = (User) session.getAttribute("user");
        Pager<History> like = new Pager<>();
        int count = historyService.countHistory(loginUser.getId()).intValue();
        int pageCount = count % pageSize == 0 ? count / pageSize : (count / pageSize) + 1;
        if (pageNo <= 0) {
            pageNo = 1;
        }
        if (pageNo > pageCount) {
            pageNo = pageCount;
        }
        like.setPageNo(pageNo);//有多少页
        like.setPageSize(pageSize);//每页多少个
        like = historyService.queryAllHistory(like, loginUser.getId());
        histories = like.getResult();
        request.setAttribute("pageCount", pageCount);
        session.setAttribute("histories", histories);
        return "history";
    }


    public String deleteHistory() {

        String id = request.getParameter("id");
        history.setId(id);
        historyService.remove(history);

        return "deleteHistory";
    }


    //添加历史纪录
    public String addHistory() {
        System.out.println("user:" + userId);
        if(userId!=null&&!userId.equals("")) {
            History history1 = historyService.queryById(userId, buildingsId);
            if (history1 == null) {
                userPrice.setId(userId);
                buildingsPrice.setId(buildingsId);
                history.setUserPrice(userPrice);
                history.setBuildingsPrice(buildingsPrice);
                history.setCreated_time(Calendar.getInstance().getTime());
                historyService.add(history);
                result = ControllerResult.getSuccessResult("添加成功");
            } else if (history1 != null) {
                history.setId(history1.getId());
                history.setCreated_time(Calendar.getInstance().getTime());
                historyService.update(history);
                result = ControllerResult.getSuccessResult("修改成功");
            }
        } else if(userId.equals("")){

        }
        return "addHistory";
    }

    @Override
    public void setServletRequest(HttpServletRequest request) {
        this.request = request;
    }
}
