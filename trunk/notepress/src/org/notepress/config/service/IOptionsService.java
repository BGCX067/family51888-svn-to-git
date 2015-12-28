package org.notepress.config.service;

import java.util.List;

import org.notepress.config.model.Options;

public interface IOptionsService {

	public void create(Options option);

	public Options read(String id);

	public void update(Options option);

	public void delete(String id);

	public List<Options> query();

}