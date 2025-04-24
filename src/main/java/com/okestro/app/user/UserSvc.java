package com.okestro.app.user;

import java.util.List;

public interface UserSvc {
    // 사용자 목록조회
    List<UserVo> retrieveUserList(UserVo userVo);
    // 사용자 상세조회
    UserVo retrieveUserDetail(UserVo userVo);
}
