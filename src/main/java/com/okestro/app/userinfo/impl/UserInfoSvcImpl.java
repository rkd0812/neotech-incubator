package com.okestro.app.userinfo.impl;

import com.okestro.app.cmmn.dao.CmmnAbstractDao;
import com.okestro.app.userinfo.UserInfoSvc;
import com.okestro.app.userinfo.UserInfoVo;
import org.egovframe.rte.fdl.access.service.impl.EgovAccessServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service("userinfoSvc")
public class UserInfoSvcImpl extends EgovAccessServiceImpl implements UserInfoSvc {

    @Resource(name="cmmnDao")
    CmmnAbstractDao dao;

    @Override
    public List<UserInfoVo> retrieveUserInfoList(UserInfoVo userinfoVo) {
        return dao.selectList("userinfo.retrieveUserInfoList", userinfoVo);
    }

    @Override
    public void insertUserInfo(UserInfoVo userInfoVo) {
        if(userInfoVo.getRoleCd() == null || userInfoVo.getRoleCd().isEmpty()) {
            userInfoVo.setRoleCd("A");
        }
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

    @Override
    public UserInfoVo userLogin(String userEmail, String userPassword) {

        UserInfoVo loginVo = new UserInfoVo();
        loginVo.setUserEmail(userEmail);
        loginVo.setUserPassword(userPassword);

        // SQL 실행하여 사용자 정보 조회
        UserInfoVo userInfo = (UserInfoVo) dao.selectOne("userinfo.userLogin", loginVo);


        return userInfo;
        }
}