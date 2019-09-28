package com.niyongsheng.common.yml;

import org.yaml.snakeyaml.Yaml;

public class Yml {
    private static final Yaml yml = new Yaml();

    public static String getYmlFromObject(Object obj) {
        return yml.dump(obj);
    }

    public static <T> T getObjectFromYml(String ymlStr, Class<T> valueType) {
        return yml.loadAs(ymlStr, valueType);
    }

}
