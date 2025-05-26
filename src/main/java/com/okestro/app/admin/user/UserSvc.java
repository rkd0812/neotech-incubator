package com.okestro.app.admin.user;

import java.util.List;

public interface UserSvc {
    // 사용자 목록 개수 조회
    int retrieveUserListCnt(UserVo userVo);
    // 사용자 목록조회
    List<UserVo> retrieveUserList(UserVo userVo);
    // 사용자 상세조회
    UserVo retrieveUserDetail(UserVo userVo);
    // 사용자 수정
    int updateUser(UserVo userVo);
    // 사용자 등록
    int registUser(UserVo userVo);
    // 사용자 삭제
    int deleteUser(String userEmail);
}
