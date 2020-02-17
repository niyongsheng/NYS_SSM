package com.niyongsheng.persistence.service.impl;

import com.niyongsheng.persistence.service.CxfWebService;
import org.springframework.stereotype.Component;

import javax.jws.WebService;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
@Component
@WebService(endpointInterface = "com.niyongsheng.persistence.service.CxfWebService")
public class CxfWebServiceImpl implements CxfWebService {
    @Override
    public String helloCxf(String content) {
        return "Hello" + content;
    }
}
