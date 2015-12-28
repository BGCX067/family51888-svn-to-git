package org.notepress.core.config;

import java.util.ArrayList;
import java.util.List;

public class FileExtra {
	private List<ExtraData> text = new ArrayList();
	private List<ExtraData> image = new ArrayList();
	private List<ExtraData> file = new ArrayList();
	private List<ExtraData> video = new ArrayList();

	public List<ExtraData> getText() {
		return text;
	}

	public void setText(List<ExtraData> text) {
		this.text = text;
	}

	public List<ExtraData> getImage() {
		return image;
	}

	public void setImage(List<ExtraData> image) {
		this.image = image;
	}

	public List<ExtraData> getFile() {
		return file;
	}

	public void setFile(List<ExtraData> file) {
		this.file = file;
	}

	public List<ExtraData> getVideo() {
		return video;
	}

	public void setVideo(List<ExtraData> video) {
		this.video = video;
	}
}
