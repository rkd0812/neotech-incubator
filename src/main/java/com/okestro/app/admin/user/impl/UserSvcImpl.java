package com.okestro.app.admin.user.impl;

import com.okestro.app.admin.user.UserVo;
import com.okestro.app.admin.user.UserSvc;
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
    public int retrieveUserListCnt(UserVo userVo) {
        return dao.selectOne("user.retrieveUserListCnt", userVo);
    }

    @Override
    public List<UserVo> retrieveUserList(UserVo userVo) {
        return dao.selectList("user.retrieveUserList", userVo);
    }

    @Override
    public UserVo retrieveUserDetail(UserVo userVo) {
        return dao.selectOne("user.retrieveUserDetail", userVo);
    }

    @Override
    public int updateUser(UserVo userVo) {
        return dao.update("user.updateUser", userVo);
    }

    @Override
    public int registUser(UserVo userVo) {
        return dao.insert("user.registUser", userVo);
    }

    @Override
    public int deleteUser(String userEmail) {
        return dao.delete("user.deleteUser", userEmail);
    }

}
