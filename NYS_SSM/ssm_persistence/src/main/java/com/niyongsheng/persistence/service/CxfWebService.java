package com.niyongsheng.persistence.service;

import javax.jws.WebMethod;
import javax.jws.WebService;

/**
 * @author niyongsheng.com
 * @version $
 * @des
 * @updateAuthor $
 * @updateDes
 */
@WebService
public interface CxfWebService {
    /**
     * WebService
     * http://localhost:8080/web/webservice/cxfWebService?wsdl
     * @param content
     * @return
     */
    @WebMethod
    public String helloCxf(String content);
}
