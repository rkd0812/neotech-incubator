package com.okestro.app.projdectdetail.impl;


import com.okestro.app.cmmn.dao.CmmnAbstractDao;
import com.okestro.app.projdectdetail.ProjectDetailSvc;
import com.okestro.app.projdectdetail.ProjectDetailVo;
import org.egovframe.rte.fdl.access.service.impl.EgovAccessServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("projectdetailSvc")
public class ProjectDetailImpl extends EgovAccessServiceImpl implements ProjectDetailSvc {

    @Resource(name="cmmnDao")
    CmmnAbstractDao dao;

    @Override
    public List<ProjectDetailVo> retrieveProjectDetail() {
        return dao.selectList("projectdetail.retrieveProjectDetail");
    }
}
