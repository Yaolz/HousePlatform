package com.ht.controller;

import com.ht.bean.*;
import com.ht.common.Content;
import com.ht.common.ControllerResult;
import com.ht.common.Pager;
import com.ht.price.BuildingsPrice;
import com.ht.price.UserPrice;
import com.ht.service.HistoryService;
import com.ht.service.MessageService;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.interceptor.ServletRequestAware;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * Created by CHEN JX on 2017/9/8.
 *
 * 用户留言
 */
public class MessageAction extends ActionSupport implements ServletRequestAware {

    private MessageService messageService;

    private HttpServletRequest request;

    private Message message;
    private UserPrice userPrice;
    private BuildingsPrice buildingsPrice;
    private Pager<Message> messagePager;
    private List<Message> messages;
    private String buildingsId;


    private ControllerResult result;
    private long total;
    private int totalPage;
    private int page = 1;
    private int pageSize = 5;
    private int status;
    private String buildings_id;
    private int pageNo;

    public void setPageNo(int pageNo) {
        this.pageNo = pageNo;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public void setBuildings_id(String buildings_id) {
        this.buildings_id = buildings_id;
    }

    public Pager<Message> getMessagePager() {
        return messagePager;
    }

    public void setMessageService(MessageService messageService) {
        this.messageService = messageService;
    }

    public void setUserPrice(UserPrice userPrice) {
        this.userPrice = userPrice;
    }

    public void setBuildingsPrice(BuildingsPrice buildingsPrice) {
        this.buildingsPrice = buildingsPrice;
    }

    public Message getMessage() {
        return message;
    }

    public void setMessage(Message message) {
        this.message = message;
    }

    public List<Message> getMessages() {
        return messages;
    }

    public void setMessages(List<Message> messages) {
        this.messages = messages;
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

    //添加留言
    public String addMessage(){
        message.setContent(message.getContent());
        message.setUserPrice(userPrice);
        message.setBuildingsPrice(buildingsPrice);
        message.setStatus(1);
        message.setLeave_time(Calendar.getInstance().getTime());
        messageService.add(message);
        result = ControllerResult.getSuccessResult("留言成功");
        return "addMessage";
    }

    public String navMessagePage(){
        return "navMessagePage";
    }
    //前台页面分页查看留言
    public String buildingsMessage() {
        messagePager = new Pager<>();
        messagePager.setPageSize(pageSize);
        if (page < 1) {
            messagePager.setPageNo(1);
        } else {
            messagePager.setPageNo(page);
        }
        messagePager = messageService.queryAllMessageBuildings(messagePager,buildingsId,1);
        return "buildingsMessage";
    }

    //分页查看留言
    public String message(){
        HttpSession session = request.getSession();
        User loginUser = (User) session.getAttribute("user");
        Pager<Message> messagePager1 = new Pager<>();
        int count = messageService.countMessage(loginUser.getId()).intValue();
        int pageCount = count % pageSize == 0 ? count / pageSize : (count / pageSize) + 1;
        if (page <= 0) {
            page = 1;
        }
        if (page > pageCount) {
            page = pageCount;
        }
        messagePager1.setPageNo(page);//有多少页
        messagePager1.setPageSize(pageSize);//每页多少个
        messagePager1 = messageService.queryAllMessage(messagePager1, loginUser.getId());
        messages = messagePager1.getResult();
        request.setAttribute("pageCount", pageCount);
        session.setAttribute("messages", messages);
        return "message";
    }
    //修改留言
    public String updateMessage(){
        HttpSession session = request.getSession();
        String id = request.getParameter("message.id");
        String content = request.getParameter("message.content");
        messageService.updateMessageContent(content,id);
        result = ControllerResult.getSuccessResult("修改成功");
        message = messageService.queryById(id);
        session.setAttribute("message", message);
        return "updateMessage";
    }

    //激活冻结
    public String status(){
        String id = request.getParameter("id");
        String status = request.getParameter("status");
        int a= Integer.valueOf(status);
        if(a==0){
            messageService.updateMessageStatus(id, Content.ShowStatusYes);
        }else {
            messageService.updateMessageStatus(id,Content.ShowStatusNo);
        }
        return "status";
    }

    //经销商分页查询留言
    public String allmessage(){
        messagePager = new Pager<>();
        messagePager.setPageSize(10);
        HttpSession session = request.getSession();
        if(session.getAttribute("agency")!=null){
            Agency agency = (Agency) session.getAttribute("agency");
            if (pageNo < 1) {
                messagePager.setPageNo(1);
            } else {
                messagePager.setPageNo(pageNo);
            }
            if(status < 2&&!buildings_id.equals("所有楼盘")){
                messagePager =messageService .queryAllMessageBuildings(messagePager,buildings_id,status);
            }else if(buildings_id.equals("所有楼盘")){
                messagePager = messageService.queryAllMessageAgency(messagePager,agency.getId(),status);
            }
        }
        return "allmessage";
    }

    //经销商回复
    public String updateMessageAgency(){
        message.setReply_time(new Date());
        message.setStatus(1);
        messageService.updateupdateMessageBuildings(message);
        result = ControllerResult.getSuccessResult("回复成功");
        return "updateMessageAgency";
    }

    //经销商留言页面跳转
    public String allmessagePage(){
        return "allmessagePage";
    }

    @Override
    public void setServletRequest(HttpServletRequest request) {
        this.request = request;
    }
}
