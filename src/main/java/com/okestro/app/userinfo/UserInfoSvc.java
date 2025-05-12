package com.okestro.app.userinfo;

import java.util.List;

public interface UserInfoSvc {
    //  MyBatis Mapper로 연결 → Mapper가 XML의 SQL을 실행 → 결과 반환
    //  parameterType : DB로 보내줄 값이 어떤 타입인지
    //  resultType : DB에서 받아올 값이 어떤 타입인지
    // 사용자 등록
    void insertUserInfo(UserInfoVo userInfoVo);

    // 사용자 이메일 중복 확인
    boolean checkUserDuplicate(String userEmail);

    // 사용자 상세 정보 확인
    UserInfoVo userDetail(String userEmail);

    // 사용자 정보 수정
    void updateUserInfo(UserInfoVo userInfoVo);

    // 사용자 정보 삭제(DEL_YN 을 'N'에서 'Y'로 변경
    void deleteUserInfo(String userEmail);


    int userLoginCheck(String userEmail, String userPassword);

    // 로그인 성공 시 사용자 정보 조회
    UserInfoVo retrieveUserInfoForLogin(String userEmail);
}