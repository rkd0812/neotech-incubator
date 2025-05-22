package com.okestro.app.project;


import java.util.List;

public interface ProjectSvc {
//    // 프로젝트 전체 리스트
//    List<ProjectVo> allProjcetList(String userEmail);

    // 프로젝트 (로그인한 사용자) 리스트
    List<ProjectVo> retrieveProjectList(String userEmail);

    // 프로젝트 상세 조회
    ProjectVo retrieveProjectDetail(String projectId);

    // 프로젝트 등록
    void insertUserProject(ProjectVo projectVo);

    // 프로젝트 수정
    void updateProject(ProjectVo projectVo);

    // 프로젝트 삭제
    void deleteProject(ProjectVo projectVo);
}
