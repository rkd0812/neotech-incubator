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
//    public ProjectVo retrieveProjectDetail(String projectId) {
//        if (projectId == null || projectId.trim().isEmpty()) {
//            throw new IllegalArgumentException("프로젝트 ID는 필수입니다.");
//        }
//        return dao.selectOne("project.retrieveProjectDetail", projectId);
//    }
    // 프로젝트 등록 시 사용
    @Override
    public void insertUserProject(ProjectVo projectVo, MultipartFile attachmentFile) {
        if (projectVo.getProjectName() == null || projectVo.getProjectName().trim().isEmpty()) {
            throw new IllegalArgumentException("프로젝트명은 필수 입력 항목입니다.");
        }

        if (projectVo.getProjectName().trim().length() > 100) {
            throw new IllegalArgumentException("프로젝트명은 100자 이내로 입력해주세요.");
        }

        if (projectVo.getProjectDetail() != null && projectVo.getProjectDetail().length() > 1000) {
            throw new IllegalArgumentException("프로젝트 설명은 1000자 이내로 입력해주세요.");
        }

        String evaStatus = "00"; // 등록
        if ("submit".equals(projectVo.getActionType())) {
            evaStatus = "01"; // 심사요청
        }

        projectVo.setProjectName(projectVo.getProjectName().trim());
        projectVo.setEvaCd(evaStatus);

        // 설명이 null인 경우 빈 문자열로 설정
        if (projectVo.getProjectDetail() == null) {
            projectVo.setProjectDetail("");
        }

        // URL이 null인 경우 빈 문자열로 설정
        if (projectVo.getUrl() == null) {
            projectVo.setUrl("");
        }

        dao.insert("project.insertUserProject", projectVo);

        // 첨부파일이 있을 시 저장
        if (attachmentFile != null && !attachmentFile.isEmpty()) {
            try {
                String uuid = UUID.randomUUID().toString();   // 파일 저장용 이름
                String uploadpath = "/upload/" + uuid;  //실제 저장 경로

                File file = new File(uploadpath);
                attachmentFile.transferTo(file);

                projectVo.setAttachmentId("ATT" + System.currentTimeMillis());
                projectVo.setAttachmentName(attachmentFile.getOriginalFilename());
                // 첨부파일 정보 저장
                dao.insert("project.insertAttachment", projectVo);
            } catch (IOException e) {
                throw new RuntimeException("파일 저장 실패", e);
            }
        }
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
