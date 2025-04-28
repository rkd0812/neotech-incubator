package com.okestro.app.code;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter @Setter
public class CodeVo {

    private String codeName;
    private String codeVal;
    private String codeKr;
    private String delYn;
    private String frstRgsrId;
    private Date frstRgsrDtlDttm;
    private String lastChngId;
    private Date lastChngDtlDttm;

}
