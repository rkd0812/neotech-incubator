package com.okestro.app.project;


import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface ProjectSvc {
    // 전체 프로젝트 개수 조회 (페이징)
    int countProjectList(ProjectVo projectVo);

    //  프로젝트 목록 조회 (검색과 페이징 둘 다)
    List<ProjectVo> retrieveProjectList(ProjectVo projectVo);

    // 프로젝트 등록 (등록만)
    void insertUserProject(ProjectVo projectVo);

    // 프로젝트 심사요청으로 등록
    void evaRequestProject(ProjectVo projectVo);

    //    // 프로젝트 상세 조회
    ProjectVo retrieveProjectDetail(String projectId);

    // 프로젝트 수정
    void updateProject(ProjectVo projectVo);

    // 프로젝트 심사요청 상태로 변경
    void requestEvaluation(ProjectVo projectVo);

    // 프로젝트 삭제
    void deleteProject(ProjectVo projectVo);

//    // 파일을 서버에 저장하고 경로 반환
//    String saveFileAndGetPath(MultipartFile uploadFile);
}
