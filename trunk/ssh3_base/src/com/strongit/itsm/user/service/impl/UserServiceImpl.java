package com.strongit.itsm.user.service.impl;

import java.util.Date;

import com.strongit.framework.model.StrongLogInfo;
import com.strongit.framework.service.AbstractEbo;
import com.strongit.itsm.user.model.UserModel;
import com.strongit.itsm.user.model.UserQueryModel;

public class UserServiceImpl extends AbstractEbo<UserModel,UserQueryModel> implements IUserService {

	@Override
	public StrongLogInfo getCreateLogInfo(UserModel model) {
		StrongLogInfo logInfo = new StrongLogInfo();
		logInfo.setLogContent("日志内容：用户名为"+model.getUsername()+"的用户增加成功！");
		logInfo.setLogDate(new Date());
		logInfo.setLogIp("1.1.1.1");
		logInfo.setLogOrgId("1001");
		logInfo.setLogOrgName("管理员");
		logInfo.setLogUserName("admin");
		return logInfo;
	}

	@Override
	public StrongLogInfo getDeleteLogInfo(UserModel model) {
		StrongLogInfo logInfo = new StrongLogInfo();
		logInfo.setLogContent("日志内容：用户名为"+model.getUsername()+"的用户增加成功！");
		logInfo.setLogDate(new Date());
		logInfo.setLogIp("1.1.1.1");
		logInfo.setLogOrgId("1001");
		logInfo.setLogOrgName("管理员");
		logInfo.setLogUserName("admin");
		return logInfo;
	}

	@Override
	public StrongLogInfo getUpdateLogInfo(UserModel model) {
		StrongLogInfo logInfo = new StrongLogInfo();
		logInfo.setLogContent("日志内容：用户名为"+model.getUsername()+"的用户增加成功！");
		logInfo.setLogDate(new Date());
		logInfo.setLogIp("1.1.1.1");
		logInfo.setLogOrgId("1001");
		logInfo.setLogOrgName("管理员");
		logInfo.setLogUserName("admin");
		return logInfo;
	}

	
}
