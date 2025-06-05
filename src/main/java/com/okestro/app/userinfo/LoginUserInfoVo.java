package com.okestro.app.userinfo;
import com.okestro.app.cmmn.vo.BaseVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class LoginUserInfoVo extends BaseVo {
    private String userEmail;
    private String userPassword;
}
