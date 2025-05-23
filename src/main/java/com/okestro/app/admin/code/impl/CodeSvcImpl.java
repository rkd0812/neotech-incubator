package com.okestro.app.admin.code.impl;

import com.okestro.app.cmmn.dao.CmmnAbstractDao;
import com.okestro.app.admin.code.CodeSvc;
import com.okestro.app.admin.code.CodeVo;
import org.egovframe.rte.fdl.access.service.impl.EgovAccessServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("codeSvc")
public class CodeSvcImpl extends EgovAccessServiceImpl implements CodeSvc {

    @Resource(name="cmmnDao")
    CmmnAbstractDao dao;

    @Override
    public int registerCode(CodeVo codeVo) {
        return dao.insert("code.registCode", codeVo);
    }

    @Override
    public List<CodeVo> retrieveCodeList(CodeVo codeVo) {
        return dao.selectList("code.retrieveCodeList", codeVo);
    }

    @Override
    public int retrieveCodeListCnt(CodeVo codeVo) {
        return dao.selectOne("code.retrieveCodeListCnt", codeVo);
    }

    @Override
    public CodeVo retrieveCodeDetail(CodeVo codeVo) {
        return dao.selectOne("code.retrieveCodeDetail", codeVo);
    }

    @Override
    public int updateCode(CodeVo codeVo) {
        return dao.update("code.updateCode", codeVo);
    }

    @Override
    public int deleteCode(CodeVo codeVo) {
        return dao.delete("code.deleteCode", codeVo);
    }

    @Override
    public List<CodeVo> retrieveCodeGroupList(CodeVo codeVo) {
        return dao.selectList("code.retrieveCodeGroupList", codeVo);
    }

}
