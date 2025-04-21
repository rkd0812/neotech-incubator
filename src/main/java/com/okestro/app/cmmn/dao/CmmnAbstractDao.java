package com.okestro.app.cmmn.dao;

import org.apache.ibatis.session.SqlSessionFactory;
import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;

@Repository("cmmnDao")
public class CmmnAbstractDao extends EgovAbstractMapper {

    @Resource(name="egov.sqlSession")
    public void setSqlSessionFactory(SqlSessionFactory sqlSession) {
        super.setSqlSessionFactory(sqlSession);
    }
}
