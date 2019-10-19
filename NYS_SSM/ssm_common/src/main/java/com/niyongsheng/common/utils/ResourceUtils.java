package com.niyongsheng.common.utils;

import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import java.util.Locale;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
public class ResourceUtils {

    private static ReloadableResourceBundleMessageSource messageSource = new ReloadableResourceBundleMessageSource();

    static {
        // 指定国家化资源文件路径
        messageSource.setBasename("i18n");

        // 指定将用来加载对应资源文件时使用的编码，默认为空，表示将使用默认的编码进行获取。
        messageSource.setDefaultEncoding("UTF-8");

        // 是否允许并发刷新
        messageSource.setConcurrentRefresh(true);

        // ReloadableResourceBundleMessageSource也是支持缓存对应的资源文件的，默认的缓存时间为永久，即获取了一次资源文件后就将其缓存起来，以后再也不重新去获取该文件。这个可以通过setCacheSeconds()方法来指定对应的缓存时间，单位为秒
        messageSource.setCacheSeconds(1200);
    }

    public static String getChineseValueByKey(String key){

        return messageSource.getMessage(key, null, Locale.CHINA);
    }

    public static String getDeafultValueByKey(String key){

        return messageSource.getMessage(key, null, LocaleContextHolder.getLocale());
    }

    public static String getEnglishValueByKey(String key){

        return messageSource.getMessage(key, null, Locale.US);
    }

    public static String getValueAndPlaceholder(String key){

        return messageSource.getMessage(key, new Object[]{"占位值"}, LocaleContextHolder.getLocale());
    }

}
