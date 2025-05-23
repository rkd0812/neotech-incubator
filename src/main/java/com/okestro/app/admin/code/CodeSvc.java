package com.okestro.app.admin.code;

import java.util.List;

public interface CodeSvc {
    // 코드 등록
    int registerCode(CodeVo codeVo);
    // 코드 목록 조회
    List<CodeVo> retrieveCodeList(CodeVo codeVo);
    // 코드 목록 개수 조회
    int retrieveCodeListCnt(CodeVo codeVo);
    // 코드 상세조회
    CodeVo retrieveCodeDetail(CodeVo codeVo);
    // 코드 수정
    int updateCode(CodeVo codeVo);
    // 코드 삭제
    int deleteCode(CodeVo codeVo);
    // 코드 분류 조회
    List<CodeVo> retrieveCodeGroupList(CodeVo codeVo);
}
