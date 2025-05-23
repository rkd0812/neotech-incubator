package com.okestro.app.admin.user;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class UserVo {

    private String userEmail;
    private String userPassword;
    private String roleCd;
    private String roleCdNm;
    private String userName;
    private String delYn;
    private String frstRgsrId;
    private String frstRgsrDtlDttm;
    private String lastChngId;
    private String lastChngDtlDttm;
    private String codeName;
    private String startDate;
    private String endDate;
}
