package com.niyongsheng.common.utils;

import org.apache.commons.codec.binary.Base64;

import java.security.*;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;

/**
 * @author niyongsheng.com
 * @version $
 * @des DSA-SHA246加密
 * @updateAuthor $
 * @updateDes
 */
public class SHA256Util {

    //指定算法 DSA
    private static final String ALGORITHM = "DSA";
    //DSA算法使用SHA-256算法指定    SHA1withDSA/SHA224withDSA/SHA256withDSA
    private static final String signatureAlgorithm = "SHA256withDSA";
    private static final KeyPair keyPair = initKey();
    private static final Base64 sbase64 = new Base64();

    /**
     * 私钥获取
     *
     * @return
     */
    public static String getKeypriStr() {
        return sbase64.encodeToString(keyPair.getPrivate().getEncoded());
    }

    /**
     * 公钥获取
     *
     * @return
     */
    public static String getKeypubStr() {
        return sbase64.encodeToString(keyPair.getPublic().getEncoded());
    }

    /**
     * 初始化密钥
     *
     * @return
     */
    private static KeyPair initKey() {
        try {
            KeyPairGenerator keyPairGen = KeyPairGenerator.getInstance(ALGORITHM);
            //密钥大小:512/768/1024
            keyPairGen.initialize(1024);
            return keyPairGen.generateKeyPair();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            System.out.println("初始化密钥异常");
        }
        return null;
    }

    /**
     * 签名加密
     *
     * @param data       原始文本
     * @param privateKey 私钥
     * @return
     */
    public static String EncodeSig(String data, String privateKey) {
        try {
            //私钥编码
            PKCS8EncodedKeySpec pkcs8KeySpec = new PKCS8EncodedKeySpec(sbase64.decode(privateKey));
            //密钥工厂,密钥转换
            KeyFactory keyFactory = KeyFactory.getInstance(ALGORITHM);
            //根据提供的私钥生成内部私钥对象
            PrivateKey priKey = keyFactory.generatePrivate(pkcs8KeySpec);
            //加载数字签名
            Signature signature = Signature.getInstance(signatureAlgorithm);
            //初始化对象使用内部私钥进行签名
            signature.initSign(priKey);
            //对数据签名
            signature.update(data.getBytes());
            //返回签名结果
            return sbase64.encodeToString(signature.sign());
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (InvalidKeySpecException e) {
            e.printStackTrace();
        } catch (InvalidKeyException e) {
            e.printStackTrace();
        } catch (SignatureException e) {
            e.printStackTrace();
        }
        System.out.println("签名加密失败");
        return data;
    }

    /**
     * 公钥加密校验
     *
     * @param data      原始文本
     * @param publicKey 公钥
     * @param sign      已加密的文本
     * @return
     */
    public static boolean verify(String data, String publicKey, String sign) {
        try {
            X509EncodedKeySpec keySpec = new X509EncodedKeySpec(sbase64.decode(publicKey));
            KeyFactory keyFactory = KeyFactory.getInstance(ALGORITHM);
            PublicKey pubKey = keyFactory.generatePublic(keySpec);
            Signature signature = Signature.getInstance(signatureAlgorithm);
            signature.initVerify(pubKey);
            signature.update(data.getBytes());
            return signature.verify(sbase64.decode(sign));
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (InvalidKeySpecException e) {
            e.printStackTrace();
        } catch (InvalidKeyException e) {
            e.printStackTrace();
        } catch (SignatureException e) {
            e.printStackTrace();
        }
        System.out.println("无效的密钥");
        return false;
    }
}
