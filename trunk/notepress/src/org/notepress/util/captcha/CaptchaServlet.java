package org.notepress.util.captcha;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class CaptchaServlet extends HttpServlet {

	private static final long serialVersionUID = -8308121890652496568L;

	protected void processRequest(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("image/jpeg");
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires", 0);
		HttpSession session = request.getSession();
		// 在内存中创建图象
		int width = 88, height = 22;
		BufferedImage image = new BufferedImage(width, height,
				BufferedImage.TYPE_INT_RGB);

		// 获取图形上下文
		Graphics g = image.getGraphics();

		// 生成随机类
		Random random = new Random();

		// 设定背景色
		g.setColor(getRandColor(200, 250));
		g.fillRect(0, 0, width, height);

		// 设定字体
		g.setFont(new Font("宋体", Font.PLAIN, 18));

		// 画边框
		g.setColor(new Color(0, 0, 0));
		g.drawRect(0, 0, width - 1, height - 1);

		// 随机产生155条干扰线使图象中的认证码不易被其它程序探测到
		g.setColor(getRandColor(160, 200));
		for (int i = 0; i < 155; i++) {
			int x = random.nextInt(width);
			int y = random.nextInt(height);
			int xl = random.nextInt(12);
			int yl = random.nextInt(12);
			g.drawLine(x, y, x + xl, y + yl);
		}

		// // 取随机产生的认证码(4位数字)
		// String sRand = "";
		// for (int i = 0; i < 4; i++) {
		// String rand = String.valueOf(random.nextInt(10));
		// sRand += rand;
		// // 将认证码显示到图象中
		// g.setColor(new Color(20 + random.nextInt(110), 20 + random
		// .nextInt(110), 20 + random.nextInt(110)));//
		// 调用函数出来的颜色相同可能是因为种子太接近所以只能直接生成
		// g.drawString(rand, 13 * i + 6, 16);
		// }

		// 三字经上段
		String captcha[] = { "人", "之", "初", "性", "本", "善", "性", "相", "近", "习",
				"相", "远", "苟", "不", "教", "性", "乃", "迁", "教", "之", "道", "贵",
				"以", "专", "昔", "孟", "母", "择", "邻", "处", "子", "不", "学", "断",
				"机", "杼", "窦", "燕", "山", "有", "义", "方", "教", "五", "子", "名",
				"俱", "扬", "养", "不", "教", "父", "之", "过", "教", "不", "严", "师",
				"之", "惰", "子", "不", "学", "非", "所", "宜", "幼", "不", "学", "老",
				"何", "为", "玉", "不", "琢", "不", "成", "器", "人", "不", "学", "不",
				"知", "义", "为", "人", "子", "方", "少", "时", "亲", "师", "友", "习",
				"礼", "仪", "香", "九", "龄", "能", "温", "席", "孝", "于", "亲", "所",
				"当", "执", "融", "四", "岁", "能", "让", "梨", "弟", "于", "长", "宜",
				"先", "知", "首", "孝", "悌", "次", "见", "闻", "知", "某", "数", "识",
				"某", "文", "一", "而", "十", "十", "而", "百", "百", "而", "千", "千",
				"而", "万", "三", "才", "者", "天", "地", "人", "三", "光", "者", "日",
				"月", "星", "三", "纲", "者", "君", "臣", "义", "父", "子", "亲", "夫",
				"妇", "顺", "曰", "春", "夏", "曰", "秋", "冬", "此", "四", "时", "运",
				"不", "穷", "曰", "南", "北", "曰", "西", "东", "此", "四", "方", "应",
				"乎", "中", "曰", "水", "火", "木", "金", "土", "此", "五", "行", "本",
				"乎", "数", "十", "干", "者", "甲", "至", "癸", "十", "二", "支", "子",
				"至", "亥", "曰", "黄", "道", "日", "所", "躔", "曰", "赤", "道" };
		String chinese = "";
		int length = captcha.length;
		for (int i = 0; i < 4; i++) {
			int rand = random.nextInt(length);
			chinese += captcha[rand];
			// 将认证码显示到图象中
			g.setColor(new Color(20 + random.nextInt(110), 20 + random
					.nextInt(110), 20 + random.nextInt(110)));// 调用函数出来的颜色相同可能是因为种子太接近所以只能直接生成
			g.drawString(captcha[rand], 20 * i + 6, 16);
		}
		// 将认证码存入SESSION
		session.setAttribute("captcha", chinese);
		// 图象生效
		g.dispose();
		ServletOutputStream responseOutputStream = response.getOutputStream();
		// 输出图象到页面
		ImageIO.write(image, "JPEG", responseOutputStream);

		// 以下关闭输入流！
		responseOutputStream.flush();
		responseOutputStream.close();
	}

	Color getRandColor(int fc, int bc) {// 给定范围获得随机颜色
		Random random = new Random();
		if (fc > 255)
			fc = 255;
		if (bc > 255)
			bc = 255;
		int r = fc + random.nextInt(bc - fc);
		int g = fc + random.nextInt(bc - fc);
		int b = fc + random.nextInt(bc - fc);
		return new Color(r, g, b);
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}

	/** Returns a short description of the servlet. */
	public String getServletInfo() {
		return "Short description";
	}
}