package com.okestro.app.project.impl;


import com.okestro.app.cmmn.dao.CmmnAbstractDao;
import com.okestro.app.project.ProjectSvc;
import com.okestro.app.project.ProjectVo;
import org.egovframe.rte.fdl.access.service.impl.EgovAccessServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.transaction.Transactional;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import java.util.UUID;

@Service("projectSvc")
public class ProjectScvImpl extends EgovAccessServiceImpl implements ProjectSvc {

    @Resource(name = "cmmnDao")
    CmmnAbstractDao dao;

    // 파일 저장 경로
    private static final String UPLOAD_PATH = "C:\\Users\\admin\\Desktop\\test_attachment\\";

    // 전체 프로젝트 개수 조회 시 사용 (페이징)
    @Override
    public int countProjectList(ProjectVo projectVo) {
        return dao.selectOne("project.countProjectList", projectVo);
    }

    // 로그인한 사용자의 프로젝트 조회 시 사용
    @Override
    public List<ProjectVo> retrieveProjectList(ProjectVo projectVo) {
        return dao.selectList("project.retrieveProjectList", projectVo);
    }

    // 프로젝트 데이터 유효성 검증
    private void validateAndSetData(ProjectVo projectVo) {
        // 필수값 검증
        if (projectVo.getProjectName() == null || projectVo.getProjectName().trim().isEmpty()) {
            throw new IllegalArgumentException("프로젝트명은 필수 입력 항목입니다.");
        }

        // 길이 검증 및 데이터 정리
        String projectName = projectVo.getProjectName().trim();
        if (projectName.length() > 100) {
            throw new IllegalArgumentException("프로젝트명은 100자 이내로 입력해주세요.");
        }
        projectVo.setProjectName(projectName);  // 공백 제거된 이름으로 설정

        // 프로젝트 설명 검증 및 기본값 설정
        if (projectVo.getProjectDetail() != null && projectVo.getProjectDetail().length() > 1000) {
            throw new IllegalArgumentException("프로젝트 설명은 1000자 이내로 입력해주세요.");
        }
        if (projectVo.getProjectDetail() == null) {
            projectVo.setProjectDetail("");  // null이면 빈 문자열로 설정
        }

        // URL 기본값 설정
        if (projectVo.getUrl() == null) {
            projectVo.setUrl("");  // null이면 빈 문자열로 설정
        }
    }

    // 프로젝트 등록 시 사용
    @Override
    public void insertUserProject(ProjectVo projectVo) {
        // 기본 데이터 검증
        validateAndSetData(projectVo);

        handleFileUpload(projectVo);
        dao.insert("project.insertUserProject", projectVo);


        String projectId = projectVo.getProjectId();
        String userGroupId = projectId.replace("PRJ", "UGRP");
        projectVo.setUserGroupId(userGroupId);

        // 팀원 정보 저장
        saveTeamMembers(projectVo);
    }

    // 팀원 정보 저장
    @Override
    public void insertTeamMember(ProjectVo projectVo) {
        dao.insert("project.insertTeamMember", projectVo);
    }

    // 프로젝트 모든 팀원 삭제
    @Override
    public void deleteTeamMember(ProjectVo projectVo) {dao.update("project.deleteTeamMember", projectVo);
    }

    // 프로젝트 팀원 목록 조회
    @Override
    public List<ProjectVo> selectProjectTeamMembers(String projectId) {
        return dao.selectList("project.selectProjectTeamMembers", projectId);
    }

    // 삭제된 팀원 조회
    @Override
    public ProjectVo selectDeletedTeamMember(ProjectVo projectVo) {return dao.selectOne("project.selectDeletedTeamMember", projectVo);}

    // 삭제 되었던 팀원 복구
    @Override
    public void restoreTeamMember(ProjectVo projectVo) {dao.update("project.restoreTeamMember", projectVo);}

    @Override
    public void saveTeamMembers(ProjectVo projectVo) {
        String groupId = projectVo.getProjectId().replace("PRJ", "UGRP");

        // 로그인한 사용자 저장
        saveOneTeamMember(projectVo.getProjectId(), groupId,
                projectVo.getUserEmail(), projectVo.getUserName(),
                projectVo.getLastChngId());

        // 선택된 팀원들 저장
        if (projectVo.getTeamMemberEmails() != null && !projectVo.getTeamMemberEmails().trim().isEmpty()) {
            String[] emails = projectVo.getTeamMemberEmails().split(",");
            String[] names = projectVo.getTeamMemberNames().split(",");

            for (int i = 0; i < emails.length; i++) {
                String email = emails[i].trim();
                String name = names[i].trim();

                if (!email.equals(projectVo.getUserEmail())) {
                    saveOneTeamMember(projectVo.getProjectId(), groupId,
                            email, name, projectVo.getLastChngId());
                }
            }
        }
    }

    private void saveOneTeamMember(String projectId, String groupId, String email, String name, String lastChngId) {
        // 기존 팀원 선택
        List<ProjectVo> currentMembers = selectProjectTeamMembers(projectId);
        boolean existsActive = currentMembers.stream()
                .anyMatch(member -> member.getTeamMemberEmail().equals(email));

        // 팀원이였다가 삭제된 팀원 확인
        ProjectVo checkParam = new ProjectVo();
        checkParam.setProjectId(projectId);
        checkParam.setTeamMemberEmail(email);

        ProjectVo deletedMember = selectDeletedTeamMember(checkParam);

        if (deletedMember != null) {
            // 기본 팀원이였던 사람 복구
            ProjectVo restoreParam = new ProjectVo();
            restoreParam.setProjectId(projectId);
            restoreParam.setTeamMemberEmail(email);
            restoreParam.setTeamMemberName(name);
            restoreParam.setLastChngId(lastChngId);

            restoreTeamMember(restoreParam);
        } else {
            // 새로운 팀원 추가
            ProjectVo teamMember = new ProjectVo();
            teamMember.setProjectId(projectId);
            teamMember.setGroupId(groupId);
            teamMember.setTeamMemberEmail(email);
            teamMember.setTeamMemberName(name);
            teamMember.setLastChngId(lastChngId);

            insertTeamMember(teamMember);
        }
    }

    // 팀원 정보 업데이트
    @Override
    public void updateTeamMembers(ProjectVo projectVo) {
        String groupId = projectVo.getProjectId().replace("PRJ", "UGRP");

        // 현재 활성 팀원 목록 조회
        List<ProjectVo> currentMembers = selectProjectTeamMembers(projectVo.getProjectId());

        // 새로운 팀원 목록 (로그인 사용자 + 선택된 팀원들)
        List<String> newEmails = new ArrayList<>();
        newEmails.add(projectVo.getUserEmail()); // 로그인 사용자

        if (projectVo.getTeamMemberEmails() != null && !projectVo.getTeamMemberEmails().trim().isEmpty()) {
            String[] emails = projectVo.getTeamMemberEmails().split(",");
            for (String email : emails) {
                String trimmedEmail = email.trim();
                if (!trimmedEmail.equals(projectVo.getUserEmail())) {
                    newEmails.add(trimmedEmail);
                }
            }
        }

        // 기존 팀원 중 새 목록에 없는 사람들 삭제
        for (ProjectVo currentMember : currentMembers) {
            if (!newEmails.contains(currentMember.getTeamMemberEmail())) {
                ProjectVo deleteParam = new ProjectVo();
                deleteParam.setProjectId(projectVo.getProjectId());
                deleteParam.setTeamMemberEmail(currentMember.getTeamMemberEmail());
                deleteParam.setLastChngId(projectVo.getLastChngId());
                deleteTeamMember(deleteParam);
            }
        }

        // 새로운 팀원들 추가/복구
        String[] names = projectVo.getTeamMemberNames() != null ?
                projectVo.getTeamMemberNames().split(",") : new String[0];

        // 로그인 사용자 추가/복구
        saveOneTeamMember(projectVo.getProjectId(), groupId,
                projectVo.getUserEmail(), projectVo.getUserName(),
                projectVo.getLastChngId());

        // 선택된 팀원들 추가/복구
        if (projectVo.getTeamMemberEmails() != null && !projectVo.getTeamMemberEmails().trim().isEmpty()) {
            String[] emails = projectVo.getTeamMemberEmails().split(",");

            for (int i = 0; i < emails.length; i++) {
                String email = emails[i].trim();
                String name = i < names.length ? names[i].trim() : "";

                if (!email.equals(projectVo.getUserEmail())) {
                    saveOneTeamMember(projectVo.getProjectId(), groupId,
                            email, name, projectVo.getLastChngId());
                }
            }
        }
    }


    // 프로젝트 심사요청 상태로 등록
    @Override
    public void evaRequestProject(ProjectVo projectVo) {
        // 기본 데이터 검증
        validateAndSetData(projectVo);
        handleFileUpload(projectVo);
        // 데이터베이스에 프로젝트 정보 저장 (심사요청 상태로)
        dao.insert("project.evaRequestProject", projectVo);

        saveTeamMembers(projectVo);
    }

    // 프로젝트 상세 조회
    @Override
    public ProjectVo retrieveProjectDetail(String projectId) {
        if (projectId == null || projectId.trim().isEmpty()) {
            throw new IllegalArgumentException("프로젝트 ID는 필수입니다.");
        }
        return dao.selectOne("project.retrieveProjectDetail", projectId);
    }

    // 프로젝트 수정 시 사용
    @Override
    public void updateProject(ProjectVo projectVo) {
        // 기본 데이터 검증
        validateAndSetData(projectVo);

        // 프로젝트명 검증
        if (projectVo.getProjectName() == null || projectVo.getProjectName().trim().isEmpty()) {
            throw new IllegalArgumentException("프로젝트명은 필수입니다.");
        } else if (projectVo.getProjectName().trim().length() > 100) {
            throw new IllegalArgumentException("프로젝트명 100자 이내 입니다.");
        }

        // 프로젝트 설명 검증
        if (projectVo.getProjectDetail() == null || projectVo.getProjectDetail().trim().isEmpty()) {
            throw new IllegalArgumentException("프로젝트 설명은 필수입니다.");
        } else if (projectVo.getProjectDetail().trim().length() > 1001) {
            throw new IllegalArgumentException("프로젝트 설명은 1000자 까지 입니다.");
        }


        // URL 검증
        if (projectVo.getUrl() != null && !projectVo.getUrl().trim().isEmpty()) {
            if (projectVo.getUrl().startsWith("http://") || projectVo.getUrl().startsWith("https://")) {
            } else {
                throw new IllegalArgumentException("URL은 http:// 또는 https//로 시작해야 합니다.");
            }
        }

        dao.update("project.updateProject", projectVo);
    }

    @Transactional
    @Override
    public void updateProjectAndTeamMember(ProjectVo projectVo) {
        // 프로젝트 기본 정보 수정
        updateProject(projectVo);

        // 팀원 정보 수정
        updateTeamMembers(projectVo);
    }


    @Override
    public void requestEvaluation(ProjectVo projectVo) {
        // 프로젝트 ID 체크
        if (projectVo.getProjectId() == null || projectVo.getProjectId().trim().isEmpty()) {
            throw new IllegalArgumentException("프로젝트 ID는 필수입니다.");
        }
        dao.update("project.requestEvaluation", projectVo);
    }

    // 프로젝트 삭제 시 사용
    @Override
    public void deleteProject(ProjectVo projectVo) {
        dao.update("project.deleteProject", projectVo);
    }

    // 첨부파일 저장
    @Override
    public String saveFileAndGetPath(String fileData, String fileName) {
        try {
            // Base64 디코딩
            byte[] decodedBytes = Base64.getDecoder().decode(fileData);

            // 업로드 폴더가 없으면 생성
            File uploadDir = new File(UPLOAD_PATH);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // 파일명 중복 방지를 위해 시간스탬프 추가
            String newFileName = System.currentTimeMillis() + "_" + fileName;
            File targetFile = new File(UPLOAD_PATH + newFileName);

            // 파일 저장
            try (FileOutputStream fos = new FileOutputStream(targetFile)) {
                fos.write(decodedBytes);
            }

            return UPLOAD_PATH + newFileName;

        } catch (Exception e) {
            throw new RuntimeException("파일 저장 실패: " + e.getMessage());
        }
    }



    // 파일 업로드 부분 검증
    private void handleFileUpload(ProjectVo projectVo) {
        String fileData = projectVo.getFileData();
        String fileName = projectVo.getFileName();

        // 파일 데이터가 있으면 저장 처리
        if (fileData != null && !fileData.trim().isEmpty() && fileName != null && !fileName.trim().isEmpty()) {
            try {
                // 파일 저장하고 경로 받기
                String filePath = saveFileAndGetPath(fileData, fileName);

                // VO에 파일 정보 설정
                projectVo.setFilePath(filePath);
            } catch (Exception e) {
                throw e;
            }
        }
    }


//    // 첨부파일 정보 업데이트
//    private void updateAttachmentInfo(ProjectVo projectVo) {
//        // 기존 첨부파일 정보가 있는지 확인
//        ProjectVo existingProject = dao.selectOne("project.retrieveProjectDetail", projectVo.getProjectId());
//
//        if (existingProject != null && existingProject.getAttachmentId() != null) {
//            // 기존 첨부파일 정보 업데이트
//            dao.update("project.updateAttachment", projectVo);
//        } else {
//            // 첨부파일이 처음 추가되는 경우
//            insertAttachmentInfo(projectVo);
//        }
//    }

//    // 첨부파일 정보 삭제
//    private void deleteAttachmentInfo(ProjectVo projectVo) {
//        dao.update("project.deleteAttachment", projectVo);
//    }

    // 팝업에서 팀원 목록 조회
    @Override
    public List<ProjectVo> retrieveUserList(String userEmail) {
        return dao.selectList("project.retrieveUserList", userEmail);
    }
}