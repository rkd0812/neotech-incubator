package com.okestro.app.project.impl;


import com.okestro.app.cmmn.dao.CmmnAbstractDao;
import com.okestro.app.project.ProjectSvc;
import com.okestro.app.project.ProjectVo;
import org.egovframe.rte.fdl.access.service.impl.EgovAccessServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Service("projectSvc")
public class ProjectScvImpl extends EgovAccessServiceImpl implements ProjectSvc {

    @Resource(name = "cmmnDao")
    CmmnAbstractDao dao;

    // 파일 저장 경로
//    private static final String UPLOAD_PATH = "C:\\\\Users\\\\admin\\\\Desktop\\\\test_attachment\\\\";

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


    // 프로젝트 등록 시 사용
    @Override
    public void insertUserProject(ProjectVo projectVo) {
        // 기본 데이터 검증
        validateAndSetData(projectVo);
        dao.insert("project.insertUserProject", projectVo);
//        // 파일이 있으면 파일 저장 처리
//        handleFileUpload(projectVo);
        String projectId = projectVo.getProjectId();
        String userGroupId = projectId.replace("PRJ", "UGRP");
        projectVo.setUserGroupId(userGroupId);

        // 첨부파일 정보가 있으면 첨부파일 테이블에도 저장
        if (projectVo.getAttachmentName() != null && !projectVo.getAttachmentName().isEmpty()) {
            insertAttachmentInfo(projectVo);
        }

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
    public void deleteAllTeamMembers(String projectId) {
        dao.update("project.deleteAllTeamMembers", projectId);
    }

    // 프로젝트 팀원 목록 조회
    @Override
    public List<ProjectVo> selectProjectTeamMembers(String projectId) {
        return dao.selectList("project.selectProjectTeamMembers", projectId);
    }

//    @Override
//    public void saveTeamMembers(ProjectVo projectVo) {
//        String groupId = projectVo.getProjectId().replace("PRJ", "UGRP");
//
//        // 로그인한 사용자 저장
//        saveOneTeamMember(projectVo.getProjectId(), groupId,
//                projectVo.getUserEmail(), projectVo.getUserName(),
//                projectVo.getLastChngId());
//
//        // 선택된 팀원들 저장
//        if (projectVo.getTeamMemberEmails() != null && !projectVo.getTeamMemberEmails().trim().isEmpty()) {
//            String[] emails = projectVo.getTeamMemberEmails().split(",");
//            String[] names = projectVo.getTeamMemberNames().split(",");
//
//            for (int i = 0; i < emails.length; i++) {
//                String email = emails[i].trim();
//                String name = names[i].trim();
//
//                // 로그인 사용자와 중복 아니면 저장
//                if (!email.equals(projectVo.getUserEmail())) {
//                    saveOneTeamMember(projectVo.getProjectId(), groupId,
//                            email, name, projectVo.getLastChngId());
//                }
//            }
//        }
//    }


    @Override
    public void saveTeamMembers(ProjectVo projectVo) {
        String groupId = projectVo.getProjectId().replace("PRJ", "UGRP");

        // 로그인한 사용자 저장
        saveOneTeamMember(projectVo.getProjectId(), groupId,
                projectVo.getUserEmail(), projectVo.getUserName(),
                projectVo.getLastChngId());

        // 선택된 팀원들 저장
        if (projectVo.getTeamMemberEmails() != null && !projectVo.getTeamMemberEmails().trim().isEmpty()) {
            System.out.println("팀원 데이터 처리 시작");
            String[] emails = projectVo.getTeamMemberEmails().split(",");
            String[] names = projectVo.getTeamMemberNames().split(",");


            for (int i = 0; i < emails.length; i++) {
                String email = emails[i].trim();
                String name = names[i].trim();

                System.out.println("처리 중인 팀원: " + name + " (" + email + ")");

                // 로그인 사용자와 중복 아니면 저장
                if (!email.equals(projectVo.getUserEmail())) {
                    saveOneTeamMember(projectVo.getProjectId(), groupId,
                            email, name, projectVo.getLastChngId());
                    System.out.println("팀원 저장 완료: " + name);
                } else {
                    System.out.println("중복 제외: " + name);
                }
            }
        } else {
            System.out.println("선택된 팀원이 없음");
        }
        System.out.println("=== saveTeamMembers 완료 ===");
    }

    // 팀원 한 명 저장
    private void saveOneTeamMember(String projectId, String groupId, String email, String name, String lastChngId) {
        ProjectVo teamMember = new ProjectVo();
        teamMember.setProjectId(projectId);
        teamMember.setGroupId(groupId);
        teamMember.setTeamMemberEmail(email);
        teamMember.setTeamMemberName(name);
        teamMember.setLastChngId(lastChngId);

        insertTeamMember(teamMember);
    }

    // 팀원 정보 업데이트 (그대로 유지)
    @Override
    public void updateTeamMembers(ProjectVo projectVo) {
        deleteAllTeamMembers(projectVo.getProjectId());
        saveTeamMembers(projectVo);
    }


    // 프로젝트 심사요청 상태로 등록
    @Override
    public void evaRequestProject(ProjectVo projectVo) {
        // 기본 데이터 검증
        validateAndSetData(projectVo);

//        // 파일이 있으면 파일 저장 처리
//        handleFileUpload(projectVo);

        // 데이터베이스에 프로젝트 정보 저장 (심사요청 상태로)
        dao.insert("project.evaRequestProject", projectVo);

        // 첨부파일 정보가 있으면 첨부파일 테이블에도 저장
        if (projectVo.getAttachmentName() != null && !projectVo.getAttachmentName().isEmpty()) {
            insertAttachmentInfo(projectVo);
        }

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

//        // 새로운 파일 업로되 되었는지 확인
//        if (projectVo.getUploadFile() != null && !projectVo.getUploadFile().isEmpty()) {
//            // 기존 첨부파일 있다면 삭제
//            deleteExistingFile(projectVo.getProjectId());
//
//            // 새 파일 저장
//            handleFileUpload(projectVo);
//
//            // 첨부파일 정보 업데이트
//            updateAttachmentInfo(projectVo);
//        }
        dao.update("project.updateProject", projectVo);
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

//    // 첨부파일 저장
//    @Override
//    public String saveFileAndGetPath(MultipartFile uploadFile) {
//        try {
//            // 업로드 폴더가 없으면 생성
//            File uploadDir = new File(UPLOAD_PATH);
//            if (!uploadDir.exists()) {
//                uploadDir.mkdirs();
//            }
//            // 파일명 만들기
//            String fileName = System.currentTimeMillis() + "_" + uploadFile.getOriginalFilename();
//
//            // 파일 저장
//            File saveFile = new File(UPLOAD_PATH + fileName);
//            uploadFile.transferTo(saveFile);
//
//            // 저장된 경로 반환
//            return UPLOAD_PATH + fileName;
//
//        } catch (IOException e) {
//            throw new RuntimeException("파일 저장 실패", e);
//        }
//    }

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

//        // 파일 크기 검증 (50MB 제한)
//        MultipartFile uploadFile = projectVo.getUploadFile();
//        if (uploadFile != null && !uploadFile.isEmpty()) {
//            long maxSize = 50 * 1024 * 1024; // 50MB
//            if (uploadFile.getSize() > maxSize) {
//                throw new IllegalArgumentException("파일 크기는 50MB 이하만 업로드 가능합니다.");
//            }
//
//            // 파일 확장자 검증
//            String fileName = uploadFile.getOriginalFilename();
//            if (fileName != null) {
//                String extension = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
//                String[] allowedExtensions = {"pdf", "jpg", "jpeg", "png", "doc", "docx", "zip", "txt"};
//                boolean isAllowed = false;
//                for (String ext : allowedExtensions) {
//                    if (ext.equals(extension)) {
//                        isAllowed = true;
//                        break;
//                    }
//                }
//                if (!isAllowed) {
//                    throw new IllegalArgumentException("허용되지 않는 파일 형식입니다. (pdf, jpg, jpeg, png, doc, docx, zip, txt만 가능)");
//                }
//            }
//        }
    }

//    // 파일 업로드 부분 검증
//    private void handleFileUpload(ProjectVo projectVo) {
//        MultipartFile uploadFile = projectVo.getUploadFile();
//
//        // 파일이 있으면 저장 처리
//        if (uploadFile != null && !uploadFile.isEmpty()) {
//            // 파일 저장하고 경로 받기
//            String filePath = saveFileAndGetPath(uploadFile);
//
//            // VO에 파일 정보 설정
//            projectVo.setFilePath(filePath);
//            projectVo.setAttachmentName(uploadFile.getOriginalFilename());
//        }
//    }

    // 첨부파일 정보 저장
    private void insertAttachmentInfo(ProjectVo projectVo) {
        // 첨부파일 ID 생성
        String attachmentId = "ATT" + System.currentTimeMillis();
        projectVo.setAttachmentId(attachmentId);

        // attachment 테이블에 파일 정보 저장
        dao.insert("project.insertAttachment", projectVo);
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

//    // 기존 파일 삭제 (물리적 삭제)
//    private void deleteExistingFile(String projectId) {
//        try {
//            // 기존 프로젝트 정보 조회
//            ProjectVo existingProject = dao.selectOne("project.retrieveProjectDetail", projectId);
//
//            if (existingProject != null && existingProject.getFilePath() != null && !existingProject.getFilePath().isEmpty()) {
//                File existingFile = new File(existingProject.getFilePath());
//                if (existingFile.exists()) {
//                    existingFile.delete();
//                }
//            }
//        } catch (Exception e) {
//            // 파일 삭제 실패 시 로그만 남기고 계속 진행
//            System.err.println("기존 파일 삭제 실패: " + e.getMessage());
//        }
//    }

    @Override
    public List<ProjectVo> retrieveUserList(String userEmail) {
        return dao.selectList("project.retrieveUserList", userEmail);
    }




}