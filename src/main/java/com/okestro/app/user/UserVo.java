package com.okestro.app.user;

import lombok.Getter;
import lombok.Setter;
import org.stringtemplate.v4.ST;

@Getter @Setter
public class UserVo {

    private String userEmail;
    private String userPassword;
    private String roleCd;
    private String delYn;
    private String frstRgsrId;
    private String frstRgsrDtlDttm;
    private String lastChngId;
    private String lastChngDtlDttm;

    private String codeKr;
}
