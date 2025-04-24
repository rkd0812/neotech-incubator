package com.okestro.app.code;

import java.util.List;

public interface CodeSvc {
    // 코드 조회
    List<CodeVo> retrieveCodeList(CodeVo codeVo);
}
