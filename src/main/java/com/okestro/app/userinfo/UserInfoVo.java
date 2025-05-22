package com.okestro.app.userinfo;

import com.okestro.app.cmmn.vo.BaseVo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserInfoVo extends BaseVo {
    // user 테이블 컬럼 목록
    private String userEmail;
    private String userPassword;
    private String userName;
    private String roleCd;

    // code 테이블 컬럼 목록
    private String codeName;
    private String codeVal;
    private String codeKr;
}
