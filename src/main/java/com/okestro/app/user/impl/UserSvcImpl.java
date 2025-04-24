package com.okestro.app.user.impl;

import com.okestro.app.user.UserVo;
import com.okestro.app.user.UserSvc;
import com.okestro.app.cmmn.dao.CmmnAbstractDao;
import org.egovframe.rte.fdl.access.service.impl.EgovAccessServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("userSvc")
public class UserSvcImpl extends EgovAccessServiceImpl implements UserSvc {

    @Resource(name="cmmnDao")
    CmmnAbstractDao dao;

    @Override
    public List<UserVo> retrieveUserList(UserVo userVo) {
        return dao.selectList("user.retrieveUserList", userVo);
    }

    @Override
    public UserVo retrieveUserDetail(UserVo userVo) {
        return dao.selectOne("user.retrieveUserDetail", userVo);
    }
}
