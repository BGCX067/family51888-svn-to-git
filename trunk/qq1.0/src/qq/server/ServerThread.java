package qq.server;

import java.io.IOException;
import java.net.Socket;

public class ServerThread extends Thread {
	Socket s;

	protected ServerThread(Socket s) {
		this.s = s;
	}

	public void run() {
		try {
			new ServerController(s).handle();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (s != null)s.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

}
