package com.okestro.framework.config;

import com.okestro.framework.context.EgovWebServletContextListener;
import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.context.ContextLoaderListener;
import org.springframework.web.context.support.XmlWebApplicationContext;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.multipart.support.MultipartFilter;
import org.springframework.web.servlet.DispatcherServlet;

import javax.servlet.*;
import java.nio.charset.StandardCharsets;

public class EgovWebApplicationInitializer implements WebApplicationInitializer {

    @Override
    public void onStartup(ServletContext servletContext) throws ServletException {

        servletContext.addListener(new EgovWebServletContextListener()); // 스프링 기본 컨텍스트 리스너

        FilterRegistration.Dynamic characterEncoding = servletContext.addFilter(ConfigConst.ENCODING_FILTER, new CharacterEncodingFilter());
        characterEncoding.setInitParameter(ConfigConst.ENCODING, StandardCharsets.UTF_8.toString());
        characterEncoding.setInitParameter(ConfigConst.FORCE_ENCODING, "true");
        characterEncoding.addMappingForUrlPatterns(null, false, "*.do");

        // root context  설정
        XmlWebApplicationContext rootContext = new XmlWebApplicationContext();
        rootContext.setConfigLocations(new String[] { "classpath*:egov/spring/context-*.xml"});
        rootContext.refresh();
        rootContext.start();

        servletContext.addListener(new ContextLoaderListener(rootContext));

        // servlet context 설정
        XmlWebApplicationContext webServletContext = new XmlWebApplicationContext();
        webServletContext.setConfigLocation("/WEB-INF/config/egov-com-*.xml");
        ServletRegistration.Dynamic dispatcher = servletContext.addServlet(ConfigConst.DISPATCHER, new DispatcherServlet(webServletContext));
        dispatcher.setMultipartConfig(new MultipartConfigElement(
                null,           // location (임시 파일 저장 위치, null이면 시스템 기본값)
                50000000L,      // maxFileSize (50MB)
                100000000L,     // maxRequestSize (100MB)
                0               // fileSizeThreshold (메모리에서 파일로 전환되는 크기)
        ));
        dispatcher.addMapping("/");
        dispatcher.setLoadOnStartup(1);

        // multipart filter
        MultipartFilter springMultipartFilter = new MultipartFilter();
        springMultipartFilter.setMultipartResolverBeanName(ConfigConst.MULTIPART_RESOLVER);
        FilterRegistration.Dynamic multipartFilter = servletContext.addFilter(ConfigConst.SPRING_MULTIPART_FILTER, springMultipartFilter);
        multipartFilter.addMappingForUrlPatterns(null, false, "*.do");

        servletContext.addListener(new org.springframework.web.context.request.RequestContextListener());
    }
}
