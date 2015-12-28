package org.notepress.security.service;

import org.notepress.security.model.Account;

public interface IAccountService {
	public Account read(String accountName) throws Exception;

	public String duplicateAccount(String accountName) throws Exception;

	public String duplicateEmail(String email) throws Exception;

	public String create(Account account) throws Exception;
}
