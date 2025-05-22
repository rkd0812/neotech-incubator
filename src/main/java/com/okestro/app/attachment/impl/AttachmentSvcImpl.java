package com.okestro.app.attachment.impl;

import com.okestro.app.attachment.AttachmentSvc;
import com.okestro.app.attachment.AttachmentVo;
import com.okestro.app.cmmn.dao.CmmnAbstractDao;
import com.okestro.app.evaProject.EvaProjectVo;
import org.egovframe.rte.fdl.access.service.impl.EgovAccessServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("attachmentSvc")
public class AttachmentSvcImpl extends EgovAccessServiceImpl implements AttachmentSvc {

    @Resource(name="cmmnDao")
    CmmnAbstractDao dao;

    @Override
    public List<AttachmentVo> retrieveAttachmentList(EvaProjectVo evaProjectVo) {
        return dao.selectList("attachment.retrieveAttachmentList", evaProjectVo);
    }

    @Override
    public AttachmentVo retrieveAttachment(String attachmentId) {
        return dao.selectOne("attachment.retrieveAttachment", attachmentId);
    }
}
