package com.niyongsheng.application.utils;

import com.auth0.jwt.JWTSigner;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.JWTVerifyException;
import com.auth0.jwt.internal.com.fasterxml.jackson.databind.ObjectMapper;

import java.io.IOException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.SignatureException;
import java.util.HashMap;
import java.util.Map;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
public class JwtUtil {

    // 加盐
    private static final String SECRET = "XX#$%()(#*!()!KL<><MQLMNQNQJQK_sdfkjsdrow32234545fdf>?N<:{LWPW";
    // 过期时间
    private static final String EXP = "exp";
    // 载荷JSON
    private static final String PAYLOAD = "payload";

    // 加密，传入一个对象和有效期
    public static <T> String encryption(T object, long maxAge) {
        try {
            final JWTSigner signer = new JWTSigner(SECRET);
            final Map<String, Object> claims = new HashMap<String, Object>();
            ObjectMapper mapper = new ObjectMapper();
            String jsonString = mapper.writeValueAsString(object);
            claims.put(PAYLOAD, jsonString);
            claims.put(EXP, System.currentTimeMillis() + maxAge);
            return signer.sign(claims);
        } catch(Exception e) {
            return null;
        }
    }

    // 解密，传入一个加密后的token字符串和解密后的类型
    public static<T> T decryption(String jwt, Class<T> classT) {
        final JWTVerifier verifier = new JWTVerifier(SECRET);
        try {
            final Map<String,Object> claims= verifier.verify(jwt);
            if (claims.containsKey(EXP) && claims.containsKey(PAYLOAD)) {
                long exp = (Long)claims.get(EXP);
                long currentTimeMillis = System.currentTimeMillis();
                if (exp > currentTimeMillis) {
                    String json = (String)claims.get(PAYLOAD);
                    ObjectMapper objectMapper = new ObjectMapper();
                    return objectMapper.readValue(json, classT);
                }
            }
            return null;
        } catch (Exception e) {
            return null;
        }
    }

    // 测试demo
    public static void main(String[] args) {
         JWTVerifier verifier = new JWTVerifier("VbNphC94rh1KD1UPiJXrI9AHvx5tVQEYbfJ5xz4VC153bFB2auW2e0GsRAYV1Y9sCZHiIhLaafExcbmoP47KM1BP");
        try {
            Map<String,Object> claims= verifier.verify("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImp0aSI6Ik14Y0FlcVhBWFVLZ3lkUkpkbE9KdlNKbFFNbWNhYVRqIn0.eyJpc3MiOiJodHRwOlwvXC8xMjcuMC4wLjE6ODAwOCIsImF1ZCI6Imh0dHA6XC9cLzEyNy4wLjAuMTo4MDA4IiwianRpIjoiTXhjQWVxWEFYVUtneWRSSmRsT0p2U0psUU1tY2FhVGoiLCJpYXQiOjE1ODM5MzQzMDQsIm5iZiI6MTU4MzkzNDMwNCwiZXhwIjoxNTg1MjMwMzA0LCJpbmZvIjp7InVpZCI6IjExIn19._mDPOjAey9Cwh4RCGigih6X0yzUbpYACe8CzBcSYI-0");
            System.out.println(claims);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (InvalidKeyException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (SignatureException e) {
            e.printStackTrace();
        } catch (JWTVerifyException e) {
            e.printStackTrace();
        }
    }
}
