package com.niyongsheng.persistence.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.niyongsheng.persistence.dao.ConversationDao;
import com.niyongsheng.persistence.domain.Conversation;
import com.niyongsheng.persistence.domain.User;
import com.niyongsheng.persistence.service.ConversationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
@Service
public class ConversationServiceImpl extends ServiceImpl<ConversationDao, Conversation> implements ConversationService {

    @Autowired
    private ConversationDao conversationDao;

    @Override
    public List<Conversation> getConversationListByFellowship(int fellowship) {
        return conversationDao.getConversationListByFellowship(fellowship);
    }
}
