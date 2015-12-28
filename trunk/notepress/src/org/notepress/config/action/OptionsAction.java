package org.notepress.config.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.MappingDispatchAction;
import org.apache.struts.validator.LazyValidatorForm;
import org.notepress.config.model.Options;
import org.notepress.config.service.IOptionsService;
import org.notepress.util.spring.SpringContextUtil;

/**
 * MyEclipse Struts Creation date: 03-21-2010
 * 
 * XDoclet definition:
 * 
 */
public class OptionsAction extends MappingDispatchAction {

	public ActionForward add(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// 处理默认动作
		LazyValidatorForm baseForm = (LazyValidatorForm) form;
		Options option = new Options();
		BeanUtils.copyProperties(option, baseForm);
		IOptionsService lpOtionsService = (IOptionsService) SpringContextUtil
				.getBean("optionsService");
		lpOtionsService.create(option);

		return null;
	}
}