package com.ht.service.impl;

import com.ht.bean.Message;
import com.ht.common.Pager;
import com.ht.dao.AbstractBaseDAO;
import com.ht.dao.MessageDAO;
import com.ht.service.MessageService;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by CHEN JX on 2017/8/24.
 * 留言
 */
@Transactional
public class MessageServiceImpl extends AbstractBaseDAO implements MessageService {

    private MessageDAO messageDAO;

    public void setMessageDAO(MessageDAO messageDAO) {
        this.messageDAO = messageDAO;
    }

    @Override
    public Message queryById(String s) {
        return messageDAO.queryById(s);
    }

    @Override
    public void add(Message message) {
       messageDAO.add(message);
    }

    @Override
    public void remove(Message message) {
        messageDAO.remove(message);
    }

    @Override
    public void update(Message message) {
        messageDAO.update(message);
    }

    @Override
    public Pager<Message> queryPager(Pager<Message> pager) {
        return messageDAO.queryPager(pager);
    }

    @Override
    public List<Message> queryAll() {
        return messageDAO.queryAll();
    }

    @Override
    public int count() {
        return messageDAO.count();
    }

    @Override
    public Pager<Message> queryAllMessage(Pager<Message> pager, String user_id) {
        return messageDAO.queryAllMessage(pager,user_id);
    }

    @Override
    public Long countMessage(String user_id) {
        return messageDAO.countMessage(user_id);
    }

    @Override
    public Pager<Message> queryAllMessage(Pager<Message> pager, String user_id, int status) {
        return messageDAO.queryAllMessage(pager,user_id,status);
    }

    @Override
    public long countMessage(String user_id, int status) {
        return messageDAO.countMessage(user_id,status);
    }

    @Override
    public Pager<Message> queryAllMessageBuildings(Pager<Message> pager, String buildings_id, int status) {
        pager.setTotal(messageDAO.countMessageBuildings(buildings_id,status));
        return messageDAO.queryAllMessageBuildings(pager,buildings_id,status);
    }

    @Override
    public long countMessageBuildings(String buildings_id, int status) {
        return messageDAO.countMessageBuildings(buildings_id,status);
    }

    @Override
    public Pager<Message> queryAllMessageAgency(Pager<Message> pager, String agency_id, int status) {
        pager.setTotal(messageDAO.countMessageAgency(agency_id, status));
        return messageDAO.queryAllMessageAgency(pager,agency_id,status);
    }

    @Override
    public long countMessageAgency(String agency_id, int status) {
        return messageDAO.countMessageAgency(agency_id,status);
    }

    @Override
    public void updateMessageStatus(String[] id, int status) {
        messageDAO.updateMessageStatus(id,status);
    }

    @Override
    public void updateupdateMessageUser(Message message) {
        messageDAO.updateupdateMessageUser(message);
    }

    @Override
    public void updateupdateMessageBuildings(Message message) {
        messageDAO.updateupdateMessageBuildings(message);
    }

    @Override
    public void updateMessageContent(String content, String id) {
        messageDAO.updateMessageContent(content,id);
    }

    @Override
    public void updateMessageStatus(String id, int status) {
        messageDAO.updateMessageStatus(id,status);
    }
}
