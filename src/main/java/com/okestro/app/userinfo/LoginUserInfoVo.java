package com.okestro.app.userinfo;
import com.okestro.app.cmmn.vo.BaseVo;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class LoginUserInfoVo extends BaseVo {
    private String userEmail;
    private String userPassword;
}
