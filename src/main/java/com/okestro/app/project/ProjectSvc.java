package com.okestro.app.project;


import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface ProjectSvc {
    // 전체 프로젝트 개수 조회 (페이징)
    int countProjectList(ProjectVo projectVo);

    //  프로젝트 목록 조회 (검색과 페이징 둘 다)
    List<ProjectVo> retrieveProjectList(ProjectVo projectVo);

    // 프로젝트 등록
    void insertUserProject(ProjectVo projectVo, MultipartFile attachmentFile);

    //    // 프로젝트 상세 조회
//    ProjectVo retrieveProjectDetail(String projectId);

    // 프로젝트 수정
    void updateProject(ProjectVo projectVo);

    // 프로젝트 삭제
    void deleteProject(ProjectVo projectVo);


}
