package com.niyongsheng.common.rongCloud;

import com.niyongsheng.common.enums.ResponseStatusEnum;
import com.niyongsheng.common.exception.ResponseException;
import io.rong.RongCloud;
import io.rong.methods.group.Group;
import io.rong.methods.user.User;
import io.rong.models.Result;
import io.rong.models.group.GroupMember;
import io.rong.models.group.GroupModel;
import io.rong.models.response.GroupUserQueryResult;
import io.rong.models.response.TokenResult;
import io.rong.models.user.UserModel;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

/**
 * @author niyongsheng.com
 * @version $
 * @des 融云IM Service
 * @updateAuthor $
 * @updateDes
 */
@Component
public class RongCloudService {

    @Value("${RongCloud.appKey}")
    private String rongCloudAppKey;

    @Value("${RongCloud.appSecret}")
    private String rongcloudAppSecret;

/*
    private static RongCloud rongCloud;
    private static User user;

    static {
        rongCloud = RongCloud.getInstance(rongCloudAppKey, rongcloudAppSecret);
        user = rongCloud.user;
    }
*/
    /**
     * 注册用户
     * @param id 用户account
     * @param name 用户nickname
     * @param portrait 用户icon
     * @return 用户在融云的唯一身份标识IM Token
     * @throws ResponseException 异常处理
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
            throw new ResponseException(ResponseStatusEnum.RONGCLOUD_GET_TOKEN_ERROR);
        }

        System.out.println("getRongCloudToken:" + result.toString());
        return result.getToken();
    }

    /**
     * 创建群组
     * @param groupID 群id
     * @param name 群名称
     * @param id 创建者id（user:account）
     * @return 状态码：成功200
     * @throws ResponseException 异常处理
     */
    public Integer createGroup(String groupID, String name, String id) throws ResponseException {
        RongCloud rongCloud = RongCloud.getInstance(rongCloudAppKey, rongcloudAppSecret);
        Group group = rongCloud.group;

        GroupMember[] members = {new GroupMember().setId(id)};
        GroupModel groupModel = new GroupModel().setId(groupID).setName(name).setMembers(members);
        GroupUserQueryResult groupResult = null;
        try {
            groupResult = group.get(groupModel);
        } catch (Exception e) {
            throw new ResponseException(ResponseStatusEnum.RONGCLOUD_CREATE_GROUP_ERROR);
        }

        System.out.println("Create Group:  " + groupResult.toString());
        return groupResult.getCode();
    }

    /**
     * 解散群组
     * @param id 解散群组的用户id（任何用户id，非群组创建者也可以解散群组）
     * @param groupID 被解散群组id
     * @return 状态码：成功200
     * @throws ResponseException
     */
    public Integer dismissGroup(String id, String groupID) throws ResponseException {
        RongCloud rongCloud = RongCloud.getInstance(rongCloudAppKey, rongcloudAppSecret);
        Group group = rongCloud.group;

        GroupMember[] members = new GroupMember[]{new GroupMember().setId(id)};
        GroupModel groupModel = new GroupModel().setId(groupID).setMembers(members);
        Result groupDismissResult = null;
        try {
            groupDismissResult = (Result)group.dismiss(groupModel);
        } catch (Exception e) {
            throw new ResponseException(ResponseStatusEnum.RONGCLOUD_DISMISS_GROUP_ERROR);
        }

        System.out.println("Dismiss  Group:  " + groupDismissResult.toString());
        return groupDismissResult.getCode();
    }

    /**
     * 加入群组
     * @param id 用户id
     * @param groupID 群组id
     * @return 状态码：成功200
     * @throws ResponseException
     */
    public Integer joinGroup(String id, String groupID, String groupName) throws ResponseException {
        RongCloud rongCloud = RongCloud.getInstance(rongCloudAppKey, rongcloudAppSecret);
        Group group = rongCloud.group;

        GroupMember[] members = new GroupMember[]{new GroupMember().setId(id)};
        GroupModel groupModel = new GroupModel().setId(groupID).setName(groupName).setMembers(members);
        Result groupJoinResult = null;
        try {
            groupJoinResult = (Result)group.join(groupModel);
        } catch (Exception e) {
            throw new ResponseException(ResponseStatusEnum.RONGCLOUD_JOIN_GROUP_ERROR);
        }

        System.out.println("Join Group:  " + groupJoinResult.toString());
        return groupJoinResult.getCode();
    }

    /**
     * 退出群组
     * @param id 用户id
     * @param groupID 群组id
     * @return 状态码：成功200
     * @throws ResponseException
     */
    public Integer quitGroup(String id, String groupID, String groupName) throws ResponseException {
        RongCloud rongCloud = RongCloud.getInstance(rongCloudAppKey, rongcloudAppSecret);
        Group group = rongCloud.group;

        GroupMember[] members = new GroupMember[]{new GroupMember().setId(id)};
        GroupModel groupModel = new GroupModel().setId(groupID).setName(groupName).setMembers(members);
        Result groupQuitResult = null;
        try {
            groupQuitResult = (Result)group.quit(groupModel);
        } catch (Exception e) {
            throw new ResponseException(ResponseStatusEnum.RONGCLOUD_QUIT_GROUP_ERROR);
        }

        System.out.println("Quit Group:  " + groupQuitResult.toString());
        return groupQuitResult.getCode();
    }
}
