package org.notepress.security.authentication;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.notepress.security.model.Account;
import org.notepress.util.hibernate.HibernateDaoSupport;
import org.springframework.dao.DataAccessException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.GrantedAuthorityImpl;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

public class UserDetailsServiceImpl extends HibernateDaoSupport implements
		UserDetailsService {

	@Override
	public UserDetails loadUserByUsername(String username)
			throws UsernameNotFoundException, DataAccessException {

		UserDetailsImpl userDetails = new UserDetailsImpl();

		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("accountName", username);
		String queryString = "from Account where accountName=:accountName";
		List accounts = this.findEntity(queryString, parameters);
		if (accounts.size() == 0) {
			throw new UsernameNotFoundException("没有找到用户信息。");
		}
		Account account = (Account) accounts.get(0);

		userDetails.setUsername(account.getAccountName());
		userDetails.setPassword(account.getPassword());
		userDetails.setCredentialsNonExpired(true);// 密码未到期
		userDetails.setAccountNonExpired(true);// 账号未到期

		// 账号状态 0，未激活1，正常2，锁定3，注销
		if (!account.getAccountStatus().equals(2)) {// 如果没有锁定
			userDetails.setAccountNonLocked(true);
		}
		if (account.getAccountStatus().equals(1)) {// 如果正常
			userDetails.setEnabled(true);
		}

		parameters = new HashMap<String, Object>();
		parameters.put("accountId", account.getId());
		queryString = "select b.roleName from AccountRole a,Role b where a.accountId=:accountId and a.roleId=b.id";
		List roles = this.findEntity(queryString, parameters);

		ArrayList<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
		for (Object roleName : roles) {
			GrantedAuthority grantedAuthority = new GrantedAuthorityImpl(
					"ROLE_" + (String) roleName);
			authorities.add(grantedAuthority);
		}
		userDetails.setAuthorities(authorities);
		return userDetails;
	}

}
