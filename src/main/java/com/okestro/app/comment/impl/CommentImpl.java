package com.okestro.app.comment.impl;

import com.okestro.app.cmmn.dao.CmmnAbstractDao;
import com.okestro.app.comment.CommentSvc;
import com.okestro.app.comment.CommentVo;
import org.egovframe.rte.fdl.access.service.impl.EgovAccessServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("commentSvc")
public class CommentImpl extends EgovAccessServiceImpl implements CommentSvc {

    @Resource(name="cmmnDao")
    CmmnAbstractDao dao;

    @Override
    public List<CommentVo> retrieveCommentList(String projectId) {
        return dao.selectList("comment.retrieveCommentList", projectId);
    }
}
