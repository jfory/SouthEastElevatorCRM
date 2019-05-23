package com.dncrm.controller.base;


import com.dncrm.entity.Page;
import com.dncrm.util.Logger;
import com.dncrm.util.PageData;
import com.dncrm.util.UuidUtil;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 * 类名称：BaseController 创建人：Simon 创建时间：2016年7月1日
 */
public class BaseController {

    /**
     * The Logger.
     */
    protected Logger logger = Logger.getLogger(this.getClass());

    private static final long serialVersionUID = 6357869213649815390L;

    /**
     * 得到PageData
     *
     * @return the page data
     */
    public PageData getPageData() {
        return new PageData(this.getRequest());
    }

    /**
     * 得到ModelAndView
     *
     * @return the model and view
     */
    public ModelAndView getModelAndView() {
        return new ModelAndView();
    }

    /**
     * 得到request对象
     *
     * @return the request
     */
    public HttpServletRequest getRequest() {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();

        return request;
    }

    /**
     * 得到32位的uuid
     *
     * @return 32 uuid
     */
    public String get32UUID() {

        return UuidUtil.get32UUID();
    }

    /**
     * 得到分页列表的信息
     *
     * @return the page
     */
    public Page getPage() {

        return new Page();
    }

    /**
     * Log before.
     *
     * @param logger        the logger
     * @param interfaceName the interface name
     */
    public static void logBefore(Logger logger, String interfaceName) {
        logger.info("");
        logger.info("start");
        logger.info(interfaceName);
    }

    /**
     * Log after.
     *
     * @param logger the logger
     */
    public static void logAfter(Logger logger) {
        logger.info("end");
        logger.info("");
    }

}
