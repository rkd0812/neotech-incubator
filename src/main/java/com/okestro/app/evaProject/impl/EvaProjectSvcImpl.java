package com.okestro.app.evaProject.impl;

import com.okestro.app.cmmn.dao.CmmnAbstractDao;
import com.okestro.app.evaProject.EvaProjectSvc;
import com.okestro.app.evaProject.EvaProjectVo;
import org.egovframe.rte.fdl.access.service.impl.EgovAccessServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("evaProjectSvc")
public class EvaProjectSvcImpl extends EgovAccessServiceImpl implements EvaProjectSvc {

    @Resource(name="cmmnDao")
    CmmnAbstractDao dao;

    @Override
    public List<EvaProjectVo> retrieveEvaProjectList(EvaProjectVo evaProjectVo) {
        return dao.selectList("evaProject.retrieveEvaProjectList", evaProjectVo);
    }

    @Override
    public EvaProjectVo retrieveEvaProjectDetail(EvaProjectVo evaProjectVo) {
        return dao.selectOne("evaProject.retrieveEvaProjectDetail", evaProjectVo);
    }

}
