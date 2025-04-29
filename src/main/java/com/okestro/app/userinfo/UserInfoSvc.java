package com.okestro.app.userinfo;

import java.util.List;

public interface UserInfoSvc {

    List<UserInfoVo> retrieveUserInfoList(UserInfoVo userinfoVo);

    void insertUserInfo(UserInfoVo userInfoVo);

    boolean checkUserDuplicate(String userEmail);

    UserInfoVo userDetail(String userEmail);

    void updateUserInfo(UserInfoVo userInfoVo);

    void deleteUserInfo(String userEmail);
}