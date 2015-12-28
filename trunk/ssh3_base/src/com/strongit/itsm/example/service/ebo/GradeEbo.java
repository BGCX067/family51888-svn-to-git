package com.strongit.itsm.example.service.ebo;

import java.util.Date;

import com.strongit.framework.model.StrongLogInfo;
import com.strongit.framework.service.AbstractEbo;
import com.strongit.itsm.example.model.GradeModel;
import com.strongit.itsm.example.model.GradeQueryModel;
import com.strongit.itsm.example.service.ebi.GradeEbi;
/**
 * 具体业务实现
 * 
 * 需要注入dao GradeDAOHibernateImpl
 * @author lanjh
 *
 */
public class GradeEbo extends AbstractEbo<GradeModel,GradeQueryModel> implements GradeEbi {

	@Override
	public StrongLogInfo getCreateLogInfo(GradeModel model) {
		StrongLogInfo logInfo = new StrongLogInfo();
		logInfo.setLogContent("日志内容：年级号为"+model.getGrade()+"的班级增加成功！");
		logInfo.setLogDate(new Date());
		logInfo.setLogIp("1.1.1.1");
		logInfo.setLogOrgId("1001");
		logInfo.setLogOrgName("管理员");
		logInfo.setLogUserName("admin");
		return logInfo;
	}

	@Override
	public StrongLogInfo getDeleteLogInfo(GradeModel model) {
		StrongLogInfo logInfo = new StrongLogInfo();
		logInfo.setLogContent("日志内容：年级号为"+model.getGrade()+"的班级删除成功！");
		logInfo.setLogDate(new Date());
		logInfo.setLogIp("1.1.1.1");
		logInfo.setLogOrgId("1001");
		logInfo.setLogOrgName("管理员");
		logInfo.setLogUserName("admin");
		return logInfo;
	}

	@Override
	public StrongLogInfo getUpdateLogInfo(GradeModel model) {
		StrongLogInfo logInfo = new StrongLogInfo();
		logInfo.setLogContent("日志内容：年级号为"+model.getGrade()+"的班级修改成功！");
		logInfo.setLogDate(new Date());
		logInfo.setLogIp("1.1.1.1");
		logInfo.setLogOrgId("1001");
		logInfo.setLogOrgName("管理员");
		logInfo.setLogUserName("admin");
		return logInfo;
	}

}
