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

    // 프로젝트 상세 조회
    ProjectVo retrieveProjectDetail(String projectId);

    // 프로젝트 수정
    void updateProject(ProjectVo projectVo);

    // 프로젝트 심사요청 상태로 변경
    void requestEvaluation(ProjectVo projectVo);

    // 프로젝트 삭제
    void deleteProject(ProjectVo projectVo);
    
    // 팀원 선택을 위한 사용자 목록 조회
    List<ProjectVo> retrieveUserList(String userEmail);

    // 팀원 한 명 저장
    void insertTeamMember(ProjectVo projectVo);

    // 프로젝트 팀원 목록 조회
    List<ProjectVo> selectProjectTeamMembers(String projectId);

    // 팀원 정보 일괄 저장 (여러 명을 한번에 처리)
    void saveTeamMembers(ProjectVo projectVo);

    // 팀원 정보 일괄 업데이트 (수정시 사용)
    void updateTeamMembers(ProjectVo projectVo);

    // 팀원 삭제
    void deleteTeamMember(ProjectVo projectVo);

    // 프로젝트와 팀원 삭제 동시 작업
    void updateProjectAndTeamMember(ProjectVo projectVo);

    // 삭제된 팀원 조회
    ProjectVo selectDeletedTeamMember(ProjectVo projectVo);

    // 삭제 되었던 팀원 복구
    void restoreTeamMember(ProjectVo projectVo);
}
