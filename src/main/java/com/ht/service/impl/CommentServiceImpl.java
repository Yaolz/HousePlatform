package com.ht.service.impl;

import com.ht.bean.Comment;
import com.ht.common.Pager;
import com.ht.dao.CommentDAO;
import com.ht.service.CommentService;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by CHEN JX on 2017/8/23.
 * 评价
 */
@Transactional
public class CommentServiceImpl implements CommentService {

    private CommentDAO commentDAO;

    public void setCommentDAO(CommentDAO commentDAO) {
        this.commentDAO = commentDAO;
    }

    @Override
    public Comment queryById(String s) {
        return commentDAO.queryById(s);
    }

    @Override
    public void add(Comment comment) {
        commentDAO.add(comment);
    }

    @Override
    public void remove(Comment comment) {
        commentDAO.remove(comment);
    }

    @Override
    public void update(Comment comment) {
        commentDAO.update(comment);
    }

    @Override
    public Pager<Comment> queryPager(Pager<Comment> pager) {
        return null;
    }

    @Override
    public List<Comment> queryAll() {
        return null;
    }

    @Override
    public int count() {
        return commentDAO.count();
    }

    @Override
    public Pager<Comment> queryAllComment(Pager<Comment> pager, String user_id) {
        return commentDAO.queryAllComment(pager,user_id);
    }

    @Override
    public Long countComment(String user_id) {
        return commentDAO.countComment(user_id);
    }

    @Override
    public Pager<Comment> queryAllCommentBuildings(Pager<Comment> pager, String buildings_id,int status) {
        return commentDAO.queryAllCommentBuildings(pager,buildings_id, status);
    }

    @Override
    public Long countCommentBuildings(String buildings_id,int status) {
        return commentDAO.countCommentBuildings(buildings_id, status);
    }

    @Override
    public Pager<Comment> queryAllCommentAgency(Pager<Comment> pager, String agency_id, int status) {
        pager.setTotal(commentDAO.countCommentAgency(agency_id,status));
        return commentDAO.queryAllCommentAgency(pager,agency_id,status);
    }

    @Override
    public Long countCommentAgency(String agency_id, int status) {
        return commentDAO.countCommentAgency(agency_id,status);
    }

    @Override
    public void updateCommentContext(String content, String id) {
        commentDAO.updateCommentContext(content,id);
    }

    @Override
    public void updateCommentStatus(String id, int status) {
        commentDAO.updateCommentStatus(id,status);
    }

    @Override
    public void deleteComment(String[] id) {
        commentDAO.deleteComment(id);
    }

}
