package com.okestro.app.project.impl;


import com.okestro.app.cmmn.dao.CmmnAbstractDao;
import com.okestro.app.project.ProjectSvc;
import com.okestro.app.project.ProjectVo;
import org.egovframe.rte.fdl.access.service.impl.EgovAccessServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("projectSvc")
public class ProjectScvImpl extends EgovAccessServiceImpl implements ProjectSvc {

    @Resource(name="cmmnDao")
    CmmnAbstractDao dao;

    @Override
    public List<ProjectVo> retrieveProjcetList() {
        return dao.selectList("project.retrieveProjcetList");

    }
}
