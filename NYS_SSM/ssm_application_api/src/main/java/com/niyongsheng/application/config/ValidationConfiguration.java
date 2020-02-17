package com.niyongsheng.application.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.validation.Validator;
import org.springframework.validation.beanvalidation.LocalValidatorFactoryBean;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurationSupport;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
@Configuration
public class ValidationConfiguration extends WebMvcConfigurationSupport {

    @Autowired
    private MessageSource messageSource;

    @Override
    protected org.springframework.validation.Validator getValidator() {
        return validator();
    }

    @Bean
    public Validator validator() {
        LocalValidatorFactoryBean validator = new LocalValidatorFactoryBean();
//        validator.setValidationMessageSource(messageSource);
        validator.setValidationMessageSource(getMessageSource());
        return validator;
    }

    /**
     * 自定义ValidationMessages国际化文件获取
     * @return
     */
    public ResourceBundleMessageSource getMessageSource() {
        ResourceBundleMessageSource messageSource = new ResourceBundleMessageSource();
        messageSource.setBasenames("ValidationMessages");
//        messageSource.setCacheSeconds(0);
        // TODO:Validated国际化DefaultEncoding需要设置成"ISO-8859-1"或者在properties文件中填写对应的UTF8编码，否则中文乱码;
        messageSource.setDefaultEncoding("ISO-8859-1");
        messageSource.setUseCodeAsDefaultMessage(true);
        return messageSource;
    }
}

