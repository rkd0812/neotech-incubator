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
import java.util.List;
import java.util.UUID;

@Service("projectSvc")
public class ProjectScvImpl extends EgovAccessServiceImpl implements ProjectSvc {

    @Resource(name="cmmnDao")
    CmmnAbstractDao dao;

    // 파일 저장 경로
    private static final String UPLOAD_PATH = "C:\\\\Users\\\\admin\\\\Desktop\\\\test_attachment\\\\";

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


    // 프로젝트 등록 시 사용
    @Override
    public void insertUserProject(ProjectVo projectVo) {
        // 기본 데이터 검증
        validateAndSetData(projectVo);

        // 파일이 있으면 파일 저장 처리
//        handleFileUpload(projectVo);

        // 데이터베이스에 프로젝트 정보 저장
        dao.insert("project.insertUserProject", projectVo);

//        // 첨부파일 정보가 있으면 첨부파일 테이블에도 저장
//        if (projectVo.getAttachmentName() != null && !projectVo.getAttachmentName().isEmpty()) {
//            insertAttachmentInfo(projectVo);
//        }
    }

    // 프로젝트 심사요청 상태로 등록
    @Override
    public void evaRequestProject(ProjectVo projectVo) {
        // 기본 데이터 검증
        validateAndSetData(projectVo);

        // 파일이 있으면 파일 저장 처리
//        handleFileUpload(projectVo);

        // 데이터베이스에 프로젝트 정보 저장 (심사요청 상태로)
        dao.insert("project.evaRequestProject", projectVo);

//        // 첨부파일 정보가 있으면 첨부파일 테이블에도 저장
//        if (projectVo.getAttachmentName() != null && !projectVo.getAttachmentName().isEmpty()) {
//            insertAttachmentInfo(projectVo);
//        }
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

//    private void insertAttachmentInfo(ProjectVo projectVo) {
//        // 첨부파일 ID 생성 (간단하게 현재시간 사용)
//        String attachmentId = "ATT" + System.currentTimeMillis();
//        projectVo.setAttachmentId(attachmentId);
//
//        // attachment 테이블에 파일 정보 저장
//        dao.insert("project.insertAttachment", projectVo);
//    }
}
