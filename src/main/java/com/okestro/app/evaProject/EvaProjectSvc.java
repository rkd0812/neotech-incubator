package com.okestro.app.evaProject;

import java.util.List;

public interface EvaProjectSvc {

    // 심사 프로잭트 목록 개수 조회
    int retrieveEvaProjectListCnt(EvaProjectVo evaProjectVo);
    // 심사 프로젝트 목록조회
    List<EvaProjectVo> retrieveEvaProjectList(EvaProjectVo evaProjectVo);
    // 심사 프로젝트 상세조회
    EvaProjectVo retrieveEvaProjectDetail(EvaProjectVo evaProjectVo);
}
