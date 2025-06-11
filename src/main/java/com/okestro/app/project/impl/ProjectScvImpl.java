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

    // 전체 프로젝트 개수 조회 시 사용 (페이징)
    @Override
    public int countProjectList(ProjectVo projectVo) {
        return  dao.selectOne("project.countProjectList", projectVo);
    }
    // 로그인한 사용자의 프로젝트 조회 시 사용
    @Override
    public List<ProjectVo> retrieveProjectList(ProjectVo projectVo) {
        return  dao.selectList("project.retrieveProjectList", projectVo);
    }

//    // 프로젝트 상세 조회
//    @Override
//    public ProjectVo retrieveProjectDetail(String projectVo) {
//        return dao.selectOne("project.retrieveProjectDetail", projectVo);
//    }

    // 프로젝트 등록 시 사용
    @Override
    public void insertUserProject(ProjectVo projectVo) {
        dao.insert("project.insertUserProject", projectVo);
    }
    
    // 프로젝트 수정 시 사용
    @Override
    public void updateProject(ProjectVo projectVo) {
        dao.update("project.updateProject", projectVo);
    }

    // 프로젝트 삭제 시 사용
    @Override
    public void deleteProject(ProjectVo projectVo) {
        dao.update("project.deleteProject", projectVo);
    }
}
