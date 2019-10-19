package com.niyongsheng.common.rongCloud;

import com.niyongsheng.common.enums.ResponseStatusEnum;
import com.niyongsheng.common.exception.ResponseException;
import io.rong.RongCloud;
import io.rong.methods.user.User;
import io.rong.models.response.TokenResult;
import io.rong.models.user.UserModel;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
@Component
public class RongCloudService {

    @Value("${RongCloud.appKey}")
    private String rongCloudAppKey;

    @Value("${RongCloud.appSecret}")
    private String rongcloudAppSecret;

//    private static RongCloud rongCloud;
//    private static User user;
//
//    static {
//        rongCloud = RongCloud.getInstance(rongCloudAppKey, rongcloudAppSecret);
//        user = rongCloud.user;
//    }

    /**
     * 注册用户，生成用户在融云的唯一身份标识 Token
     */
    public String rongCloudGetToken(String id, String name, String portrait) throws ResponseException {
        RongCloud rongCloud = RongCloud.getInstance(rongCloudAppKey, rongcloudAppSecret);
        User user = rongCloud.user;

        UserModel userModel = new UserModel()
                .setId(id)
                .setName(name)
                .setPortrait(portrait);

        TokenResult result = null;
        try {
            result = user.register(userModel);
        } catch (Exception e) {
            throw new ResponseException(ResponseStatusEnum.RONGCLOUD_GETTOKEN_ERROR);
        }

        System.out.println("getRongCloudToken:" + result.toString());
        return result.getToken();
    }

}
