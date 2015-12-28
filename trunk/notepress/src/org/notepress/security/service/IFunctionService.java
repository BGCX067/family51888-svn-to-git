package org.notepress.security.service;

import java.util.Collection;
import java.util.Map;

import org.springframework.security.access.ConfigAttribute;

public interface IFunctionService {

	public Map<String, Collection<ConfigAttribute>> findRoleUrl()
			throws Exception;
}
