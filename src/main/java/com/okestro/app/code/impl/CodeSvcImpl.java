package com.okestro.app.code.impl;

import com.okestro.app.cmmn.dao.CmmnAbstractDao;
import com.okestro.app.code.CodeSvc;
import com.okestro.app.code.CodeVo;
import org.egovframe.rte.fdl.access.service.impl.EgovAccessServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("codeSvc")
public class CodeSvcImpl extends EgovAccessServiceImpl implements CodeSvc {

    @Resource(name="cmmnDao")
    CmmnAbstractDao dao;

    @Override
    public List<CodeVo> retrieveCodeList(CodeVo codeVo) {
        return dao.selectList("code.retrieveCodeList", codeVo);
    }

}
