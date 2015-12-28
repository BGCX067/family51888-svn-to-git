package org.notepress.config.service.impl;

import java.util.List;

import org.apache.log4j.Logger;
import org.notepress.config.model.Options;
import org.notepress.config.service.IOptionsService;
import org.notepress.util.hibernate.HibernateDaoSupport;

public class OptionsServiceImpl extends HibernateDaoSupport implements
		IOptionsService {
	private static Logger log = Logger.getLogger(OptionsServiceImpl.class);

	public void create(Options option) {
		this.createEntity(option);
	}

	public Options read(String id) {
		return (Options) this.findEntityById(Options.class, id);
	}

	public void update(Options option) {
		this.updateEntity(option);
	}

	public void delete(String id) {
		this.deleteEntity(id);
	}

	public List<Options> query() {
		return this.findAllEntity(Options.class);
	}
}
