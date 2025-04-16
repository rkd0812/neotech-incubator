package com.okestro.app.user.impl;

import com.okestro.app.user.UserSvc;
import org.egovframe.rte.fdl.access.service.impl.EgovAccessServiceImpl;
import org.springframework.stereotype.Service;

@Service
public class UserSvcImpl extends EgovAccessServiceImpl implements UserSvc {
}
