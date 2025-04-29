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

    @Override
    public ProjectVo retrieveProjectDetail(ProjectVo projectVo) {
        return dao.selectOne("projectdetail.retrieveProjectDetail", projectVo);
    }

    @Override
    public int updateProjectDetail(ProjectVo projectVo) {
        return dao.update("projectdetail.updateProjectDetail", projectVo);
    }

//    @Override
//    public int deleteProjectDetail(ProjectVo projectVo) {
//        return dao.delete("projectdetail.deleteProjectDetail", projectVo);
//    }

    @Override
    public int delYnConfirmProjectDetail(ProjectVo projectVo) {
        return dao.update("projectdetail.delYnConfirmProjectDetail", projectVo);
    }
}
