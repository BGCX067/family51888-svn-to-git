package org.notepress.security.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.notepress.security.model.Account;
import org.notepress.security.model.AccountRole;
import org.notepress.security.service.IAccountService;
import org.notepress.util.hibernate.HibernateDaoSupport;

public class AccountServiceImpl extends HibernateDaoSupport implements
		IAccountService {
	public Account read(String accountName) throws Exception {
		Account account = null;

		Map<String, String> parameters = new HashMap<String, String>();
		parameters.put("accountName", accountName);

		// 查找指定ID是否还有下级栏目
		String queryString = "from Account where accountName = :accountName";
		List accountNameList = this.findEntity(queryString, parameters);
		if (accountNameList.size() > 0) {
			account = (Account) accountNameList.get(0);
		} else {
			account = null;
		}
		return account;
	}

	@Override
	public String duplicateAccount(String accountName) throws Exception {
		String json = "";
		Map<String, String> parameters = new HashMap<String, String>();
		parameters.put("accountName", accountName);

		// 查找指定ID是否还有下级栏目
		String queryString = "from Account where accountName = :accountName";
		List accountNameList = this.findEntity(queryString, parameters);
		if (accountNameList.size() > 0) {
			json = "{\"duplicate\":true}";
		} else {
			json = "{\"duplicate\":false}";
		}
		return json;
	}

	@Override
	public String duplicateEmail(String email) throws Exception {
		String json = "";
		Map<String, String> parameters = new HashMap<String, String>();
		parameters.put("email", email);

		// 查找指定ID是否还有下级栏目
		String queryString = "from Account where email = :email";
		List emailList = this.findEntity(queryString, parameters);
		if (emailList.size() > 0) {
			json = "{\"duplicate\":true}";
		} else {
			json = "{\"duplicate\":false}";
		}
		return json;
	}

	@Override
	public String create(Account account) throws Exception {
		String json = "";
		String duplicateAccount = duplicateAccount(account.getAccountName());
		String duplicateEmail = duplicateEmail(account.getEmail());
		if (duplicateAccount.indexOf("true") > 0) {
			json = "{\"result\":false,\"msg\":\"账户名称已经存在！\"}";
		} else if (duplicateEmail.indexOf("true") > 0) {
			json = "{\"result\":false,\"msg\":\"邮件地址已经存在！\"}";
		} else {
			String accountId = this.createEntity(account);
			AccountRole accountRole = new AccountRole();
			accountRole.setAccountId(accountId);
			accountRole.setRoleId("5");// 个人会员
			this.createEntity(accountRole);
			json = "{\"result\":true,\"msg\":\"成功创建账户，您可以登录了。\"}";
		}
		return json;
	}

}
