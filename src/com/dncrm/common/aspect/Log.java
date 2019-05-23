package com.dncrm.common.aspect;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Target({ElementType.PARAMETER, ElementType.METHOD})  
@Retention(RetentionPolicy.RUNTIME)  
@Documented
public @interface Log {
	String module() default "";
	String title() default "";
	String ext_idTitle() default "";//操作Id标题
	String[] ext_idParam() default "";//操作Id参数
	String ext_contentTitle() default "";//操作内容标题
	String[] ext_contentParam() default "";//操作内容参数
}
