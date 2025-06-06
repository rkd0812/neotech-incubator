package com.okestro.app.userinfo.impl;

import com.okestro.app.cmmn.dao.CmmnAbstractDao;
import com.okestro.app.userinfo.LoginUserInfoVo;
import com.okestro.app.userinfo.UserInfoSvc;
import com.okestro.app.userinfo.UserInfoVo;
import org.egovframe.rte.fdl.access.service.impl.EgovAccessServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service("userinfoSvc")
public class UserInfoSvcImpl extends EgovAccessServiceImpl implements UserInfoSvc {

    @Resource(name = "cmmnDao")
    CmmnAbstractDao dao;

    @Override
    public UserInfoVo retrieveUserInfoForLogin(UserInfoVo userInfoVo) {
        return dao.selectOne("userinfo.retrieveUserInfoForLogin", userInfoVo);
    }

    @Override
    public UserInfoVo retrieveUserInfoForLogin(LoginUserInfoVo loginUserInfoVo) {
        UserInfoVo userInfoVo = new UserInfoVo();
        userInfoVo.setUserEmail(loginUserInfoVo.getUserEmail());
        userInfoVo.setUserPassword(loginUserInfoVo.getUserPassword());
        return retrieveUserInfoForLogin(loginUserInfoVo);
    }

    // 사용자를 DB에 등록 시 어떻게 할지 (회원가입시 권한은 기본적으로 'A'로 하게끔)
    @Override
    public void insertUserInfo(UserInfoVo userInfoVo) {
        if (userInfoVo.getRoleCd() == null || userInfoVo.getRoleCd().isEmpty()) {
            userInfoVo.setRoleCd("A");
        }
        dao.insert("userinfo.insertUserInfo", userInfoVo);
    }

    // DB에서 유저 중복인지 체크
    @Override
    public boolean checkUserDuplicate(String userEmail) {
        int count = (int) dao.selectOne("userinfo.checkUserDuplicate", userEmail);
        return count > 0;
    }

    // DB에서 유저 한 사람의 데이터 확인 (userEmail로 확인
    @Override
    public UserInfoVo userDetail(String userEmail) {
        return (UserInfoVo) dao.selectOne("userinfo.userDetail", userEmail);
    }


    // DB에 유저 정보를 업데이트 시 사용 (권한코드 대문자로)
    @Override
    public void updateUserInfo(UserInfoVo userInfoVo) {
        if (userInfoVo.getRoleCd() != null && !userInfoVo.getRoleCd().isEmpty()) {
            userInfoVo.setRoleCd(userInfoVo.getRoleCd().toUpperCase());
        }
        dao.update("userinfo.updateUserInfo", userInfoVo);
    }

    // DB 데이터 삭제
    @Override
    public void deleteUserInfo(String userEmail) {
        dao.update(("userinfo.deleteUserInfo"), userEmail);
    }

}