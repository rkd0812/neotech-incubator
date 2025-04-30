package com.okestro.app.admin.user;

import java.util.List;

public interface UserSvc {
    // 사용자 목록조회
    public List<UserVo> retrieveUserList(UserVo userVo);
    // 사용자 상세조회
    public UserVo retrieveUserDetail(UserVo userVo);
    // 사용자 수정
    public int updateUser(UserVo userVo);
    // 사용자 등록
    public int registUser(UserVo userVo);
    // 사용자 삭제
    public int deleteUser(String userEmail);
}
