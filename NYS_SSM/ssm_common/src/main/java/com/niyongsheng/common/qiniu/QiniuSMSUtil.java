package com.niyongsheng.common.qiniu;

import com.qiniu.common.QiniuException;
import com.qiniu.http.Response;
import com.qiniu.sms.SmsManager;
import com.qiniu.util.Auth;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
@Component
public class QiniuSMSUtil {

    // 七牛云ACCESS_KEY
    @Value("${qiniu.accessKey}")
    private String accessKey;

    // 七牛云SECRET_KEY
    @Value("${qiniu.secretKey}")
    private String secretKey;

    public void testSMS() {
        // 设置需要操作的账号的AK和SK
        Auth auth = Auth.create(accessKey, secretKey);

        // 实例化一个SmsManager对象
        SmsManager smsManager = new SmsManager(auth);

        try {
            Map<String, String> map = new HashMap<String, String>();
            Response resp = smsManager.sendMessage("templateId", new String[] { "10086" }, map);
//          Response resp = smsManager.describeSignature("passed", 0, 0);
//          Response resp = smsManager.createSignature("signature", "app",
//                  new String[] { "data:image/gif;base64,xxxxxxxxxx" });
//          Response resp = smsManager.describeTemplate("passed", 0, 0);
//          Response resp = smsManager.createTemplate("name", "template", "notification", "test", "signatureId");
//          Response resp = smsManager.modifyTemplate("templateId", "name", "template", "test", "signatureId");
//          Response resp = smsManager.modifySignature("SignatureId", "signature");
//          Response resp = smsManager.deleteSignature("signatureId");
//          Response resp = smsManager.deleteTemplate("templateId");
            System.out.println(resp.bodyString());

//          SignatureInfo sinfo = smsManager.describeSignatureItems("", 0, 0);
//          System.out.println(sinfo.getItems().get(0).getAuditStatus());
//          TemplateInfo tinfo = smsManager.describeTemplateItems("", 0, 0);
//          System.out.println(tinfo.getItems().get(0).getAuditStatus());


        } catch (QiniuException e) {
            System.out.println(e);
        }

    }
}
