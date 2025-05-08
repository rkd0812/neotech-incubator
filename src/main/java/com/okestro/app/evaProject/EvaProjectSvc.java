package com.okestro.app.evaProject;

import org.springframework.web.bind.annotation.ModelAttribute;

import java.util.List;

public interface EvaProjectSvc {

    // 심사 프로젝트 목록조회
    List<EvaProjectVo> retrieveEvaProjectList(EvaProjectVo evaProjectVo);
    // 심사 프로젝트 상세조회
    EvaProjectVo retrieveEvaProjectDetail(EvaProjectVo evaProjectVo);
}
