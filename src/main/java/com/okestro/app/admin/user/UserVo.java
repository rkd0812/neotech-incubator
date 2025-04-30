package com.okestro.app.admin.user;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter @Setter
public class UserVo {

    private String userEmail;
    private String userPassword;
    private String roleCd;
    private String delYn;
    private String frstRgsrId;
    private Date frstRgsrDtlDttm;
    private String lastChngId;
    private Date lastChngDtlDttm;

    private String codeKr;
}
