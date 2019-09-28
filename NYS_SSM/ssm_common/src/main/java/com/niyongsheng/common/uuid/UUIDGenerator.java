package com.niyongsheng.common.uuid;

import com.fasterxml.uuid.Generators;
import com.fasterxml.uuid.impl.TimeBasedGenerator;

import java.util.UUID;

public class UUIDGenerator {

    private static final TimeBasedGenerator v1Generator = Generators.timeBasedGenerator();

    public static UUID getUUIDV1() {
        return v1Generator.generate();
    }

    public static UUID getUUIDV4() {
        return UUID.randomUUID();
    }

    public String get32V1() {
        return getUUIDV1().toString().replaceAll("-", "").toUpperCase();
    }

    public String get32V4() {
        return getUUIDV4().toString().replaceAll("-", "").toUpperCase();
    }

    public String getId() {
        UUID rawUUID = getUUIDV1();
        String[] splits = rawUUID.toString().split("-");
        return (splits[2] + splits[1] + splits[0] + splits[3] + splits[4]).toUpperCase();
    }

    public static boolean isIdValid(String id) {
        return !(id == null || id.length() != 32) && id.matches("^[0-9a-zA-Z]{32}$");
    }

}
