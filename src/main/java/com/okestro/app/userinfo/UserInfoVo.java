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
    private String quitDtlDttm;

    // code 테이블 컬럼 목록
    private String upperCodeName;
    private String codeVal;
    private String codeName;

}
