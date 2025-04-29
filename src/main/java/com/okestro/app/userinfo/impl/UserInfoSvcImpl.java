package com.okestro.app.userinfo.impl;

import com.okestro.app.cmmn.dao.CmmnAbstractDao;
import com.okestro.app.userinfo.UserInfoSvc;
import com.okestro.app.userinfo.UserInfoVo;
import org.egovframe.rte.fdl.access.service.impl.EgovAccessServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("userinfoSvc")
public class UserInfoSvcImpl extends EgovAccessServiceImpl implements UserInfoSvc {

    @Resource(name="cmmnDao")
    CmmnAbstractDao dao;

    @Override
    public List<UserInfoVo> retrieveUserInfoList(UserInfoVo userinfoVo) {
        // 매개변수가 있는 메서드 구현
        return dao.selectList("userinfo.retrieveUserInfoList", userinfoVo);
    }

    @Override
    public void insertUserInfo(UserInfoVo userInfoVo) {
        if(userInfoVo.getRoleCd() == null || userInfoVo.getRoleCd().isEmpty()) {
            userInfoVo.setRoleCd("a");
        } else {
            userInfoVo.setRoleCd(userInfoVo.getRoleCd().toUpperCase());
        }
        // DAO를 통해 DB에 저장
        dao.insert("userinfo.insertUserInfo", userInfoVo);
    }

    @Override
    public boolean checkUserDuplicate(String userEmail) {
        int count = (int) dao.selectOne("userinfo.checkUserDuplicate", userEmail);
        return count > 0;
    }

    @Override
    public UserInfoVo userDetail(String userEmail) {
        return (UserInfoVo) dao.selectOne("userinfo.userDetail", userEmail);
    }

    @Override
    public void updateUserInfo(UserInfoVo userInfoVo) {
        if(userInfoVo.getRoleCd() != null && !userInfoVo.getRoleCd().isEmpty()) {
            userInfoVo.setRoleCd(userInfoVo.getRoleCd().toUpperCase());
        }
        dao.update("userinfo.updateUserInfo", userInfoVo);
    }

    @Override
    public void deleteUserInfo(String userEmail) {
        dao.delete(("userinfo.deleteUserInfo"), userEmail);
    }
}