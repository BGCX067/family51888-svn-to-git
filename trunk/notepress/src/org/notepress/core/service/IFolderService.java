package org.notepress.core.service;

import java.util.List;

import org.notepress.core.model.Folder;

public interface IFolderService {

	public void create(Folder folder) throws Exception;

	public Object[] query(String storyId, int start) throws Exception;

	public Folder read(String id) throws Exception;

	public void update(Folder folder) throws Exception;

	public void delete(String id) throws Exception;

	public void updateThumbnail(String folderId, String thumbnail)
			throws Exception;

	public List findFolderByStoryId(String storyId) throws Exception;
}