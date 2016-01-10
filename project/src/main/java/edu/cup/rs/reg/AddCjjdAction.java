package edu.cup.rs.reg;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import edu.cup.rs.common.BaseAction;
import edu.cup.rs.common.DBOperator;
import edu.cup.rs.common.ICommonList;
import edu.cup.rs.common.UTF8String;
import edu.cup.rs.log.LogHandler;

public class AddCjjdAction extends BaseAction {
	protected static final LogHandler logger = LogHandler
			.getInstance(AddCjjdAction.class);

	public AddCjjdAction() {
		super();
	}

	protected void execute(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			String userId = (String) session.getAttribute("user_id");
			if (null == userId) {
				logger.error("没有登录!");
				response.sendRedirect("/error.jsp?error="
						+ new UTF8String("请先登录!").toUTF8String());
				return;
			}

			String bmxxId = (String) session.getAttribute("bmxxid");

			if (null == bmxxId) {
				logger.error("没有报过名！");
				response.sendRedirect("/error.jsp?error="
						+ new UTF8String("没有报过名！").toUTF8String());
				return;
			}
			/*
			
			*/
			String ksZxtdz = "";
			String ksZxjb = "";
			String ksZxyb = ""; // zhong xue you zheng bian ma
			String ksZxlxdh = "";
			String ksNjfzr = "";
			String ksGysyw = "";
			String ksGyssx = "";
			String ksGyswy = "";
			String ksGyswl = "";
			String ksGyshx = "";
			String ksGyssw = "";
			String ksGysls = "";
			String ksGyszz = "";
			String ksGysdl = "";
			String ksGysty = "";
			String ksGyszf = "";
			String gysbjmc = "";
			String gysbjrs = "";
			String gysnjmc = "";
			String gysnjrs = "";

			String ksGyxyw = "";
			String ksGyxsx = "";
			String ksGyxwy = "";
			String ksGyxwl = "";
			String ksGyxhx = "";
			String ksGyxsw = "";
			String ksGyxls = "";
			String ksGyxzz = "";
			String ksGyxdl = "";
			String ksGyxty = "";
			String ksGyxzf = "";
			String gyxbjmc = "";
			String gyxbjrs = "";
			String gyxnjmc = "";
			String gyxnjrs = "";

			String ksGesyw = "";
			String ksGessx = "";
			String ksGeswy = "";
			String ksGeswl = "";
			String ksGeshx = "";
			String ksGessw = "";
			String ksGesls = "";
			String ksGeszz = "";
			String ksGesdl = "";
			String ksGesty = "";
			String ksGeszf = "";
			String gesbjmc = "";
			String gesbjrs = "";
			String gesnjmc = "";
			String gesnjrs = "";

			String ksGexyw = "";
			String ksGexsx = "";
			String ksGexwy = "";
			String ksGexwl = "";
			String ksGexhx = "";
			String ksGexsw = "";
			String ksGexls = "";
			String ksGexzz = "";
			String ksGexdl = "";
			String ksGexty = "";
			String ksGexzf = "";
			String gexbjmc = "";
			String gexbjrs = "";
			String gexnjmc = "";
			String gexnjrs = "";

			String ksGssyw = "";
			String ksGsssx = "";
			String ksGsswy = "";
			String ksGsswl = "";
			String ksGsshx = "";
			String ksGsssw = "";
			String ksGssls = "";
			String ksGsszz = "";
			String ksGssdl = "";
			String ksGssty = "";
			String ksGsszf = "";
			String gssbjmc = "";
			String gssbjrs = "";
			String gssnjmc = "";
			String gssnjrs = "";

			String ksHkyw = "";
			String ksHksx = "";
			String ksHkwy = "";
			String ksHkwl = "";
			String ksHkhx = "";
			String ksHksw = "";
			String ksHkls = "";
			String ksHkzz = "";
			String ksHkdl = "";
			String ksHkty = "";
			String ksHkzf = "";
			String hkbjmc = "";
			String hkbjrs = "";
			String hknjmc = "";
			String hknjrs = "";

			String ksZjyw = "";
			String ksZjsx = "";
			String ksZjwy = "";
			String ksZjwl = "";
			String ksZjhx = "";
			String ksZjsw = "";
			String ksZjls = "";
			String ksZjzz = "";
			String ksZjdl = "";
			String ksZjty = "";
			String ksZjzf = "";
			String zjbjmc = "";
			String zjbjrs = "";
			String zjnjmc = "";
			String zjnjrs = "";
			String bzrpj = request.getParameter("bzrpj");

			ksZxtdz = request.getParameter("pzxdz");
			ksZxjb = request.getParameter("pzxjb");
			ksZxyb = request.getParameter("pzxyb");
			ksZxlxdh = request.getParameter("pzxdh");
			ksNjfzr = request.getParameter("pzxfzr");
			ksGysyw = request.getParameter("pgysyw");
			ksGyssx = request.getParameter("pgyssx");
			ksGyswy = request.getParameter("pgyswy");
			ksGyswl = request.getParameter("pgyswl");
			ksGyshx = request.getParameter("pgyshx");
			ksGyssw = request.getParameter("pgyssw");
			ksGysls = request.getParameter("pgysls");
			ksGyszz = request.getParameter("pgyszz");
			ksGysdl = request.getParameter("pgysdl");
			ksGysty = request.getParameter("pgysty");
			ksGyszf = request.getParameter("pgyszf");
			gysbjmc = request.getParameter("pgysbjmc");
			gysbjrs = request.getParameter("pgysbjrs");
			gysnjmc = request.getParameter("pgysnjmc");
			gysnjrs = request.getParameter("pgysnjrs");

			ksGyxyw = request.getParameter("pgyxyw"); // gao yi xia xue qi
			ksGyxsx = request.getParameter("pgyxsx");
			ksGyxwy = request.getParameter("pgyxwy");
			ksGyxwl = request.getParameter("pgyxwl");
			ksGyxhx = request.getParameter("pgyxhx");
			ksGyxsw = request.getParameter("pgyxsw");
			ksGyxls = request.getParameter("pgyxls");
			ksGyxzz = request.getParameter("pgyxzz");
			ksGyxdl = request.getParameter("pgyxdl");
			ksGyxty = request.getParameter("pgyxty");
			ksGyxzf = request.getParameter("pgyxzf");
			gyxbjmc = request.getParameter("pgyxbjmc");
			gyxbjrs = request.getParameter("pgyxbjrs");
			gyxnjmc = request.getParameter("pgyxnjmc");
			gyxnjrs = request.getParameter("pgyxnjrs");

			ksGesyw = request.getParameter("pgesyw"); // gao er shang xue qi
			ksGessx = request.getParameter("pgessx");
			ksGeswy = request.getParameter("pgeswy");
			ksGeswl = request.getParameter("pgeswl");
			ksGeshx = request.getParameter("pgeshx");
			ksGessw = request.getParameter("pgessw");
			ksGesls = request.getParameter("pgesls");
			ksGeszz = request.getParameter("pgeszz");
			ksGesdl = request.getParameter("pgesdl");
			ksGesty = request.getParameter("pgesty");
			ksGeszf = request.getParameter("pgeszf");
			gesbjmc = request.getParameter("pgesbjmc");
			gesbjrs = request.getParameter("pgesbjrs");
			gesnjmc = request.getParameter("pgesnjmc");
			gesnjrs = request.getParameter("pgesnjrs");

			ksGexyw = request.getParameter("pgexyw"); // gao er xia xue qi
			ksGexsx = request.getParameter("pgexsx");
			ksGexwy = request.getParameter("pgexwy");
			ksGexwl = request.getParameter("pgexwl");
			ksGexhx = request.getParameter("pgexhx");
			ksGexsw = request.getParameter("pgexsw");
			ksGexls = request.getParameter("pgexls");
			ksGexzz = request.getParameter("pgexzz");
			ksGexdl = request.getParameter("pgexdl");
			ksGexty = request.getParameter("pgexty");
			ksGexzf = request.getParameter("pgexzf");
			gexbjmc = request.getParameter("pgexbjmc");
			gexbjrs = request.getParameter("pgexbjrs");
			gexnjmc = request.getParameter("pgexnjmc");
			gexnjrs = request.getParameter("pgexnjrs");

			ksGssyw = request.getParameter("pgssyw"); // gao san shang xue qi
			ksGsssx = request.getParameter("pgsssx");
			ksGsswy = request.getParameter("pgsswy");
			ksGsswl = request.getParameter("pgsswl");
			ksGsshx = request.getParameter("pgsshx");
			ksGsssw = request.getParameter("pgsssw");
			ksGssls = request.getParameter("pgssls");
			ksGsszz = request.getParameter("pgsszz");
			ksGssdl = request.getParameter("pgssdl");
			ksGssty = request.getParameter("pgssty");
			ksGsszf = request.getParameter("pgsszf");
			gssbjmc = request.getParameter("pgssbjmc");
			gssbjrs = request.getParameter("pgssbjrs");
			gssnjmc = request.getParameter("pgssnjmc");
			gssnjrs = request.getParameter("pgssnjrs");

			ksHkyw = request.getParameter("phkyw"); // hui kao cheng ji
			ksHksx = request.getParameter("phksx");
			ksHkwy = request.getParameter("phkwy");
			ksHkwl = request.getParameter("phkwl");
			ksHkhx = request.getParameter("phkhx");
			ksHksw = request.getParameter("phksw");
			ksHkls = request.getParameter("phkls");
			ksHkzz = request.getParameter("phkzz");
			ksHkdl = request.getParameter("phkdl");
			ksHkty = request.getParameter("phkty");
			ksHkzf = request.getParameter("phkzf");
			hkbjmc = request.getParameter("phkbjmc");
			hkbjrs = request.getParameter("phkbjrs");
			hknjmc = request.getParameter("phknjmc");
			hknjrs = request.getParameter("phknjrs");

			ksZjyw = request.getParameter("pzjyw"); // zui jin kao shi cheng ji
			ksZjsx = request.getParameter("pzjsx");
			ksZjwy = request.getParameter("pzjwy");
			ksZjwl = request.getParameter("pzjwl");
			ksZjhx = request.getParameter("pzjhx");
			ksZjsw = request.getParameter("pzjsw");
			ksZjls = request.getParameter("pzjls");
			ksZjzz = request.getParameter("pzjzz");
			ksZjdl = request.getParameter("pzjdl");
			ksZjty = request.getParameter("pzjty");
			ksZjzf = request.getParameter("pzjzf");
			zjbjmc = request.getParameter("pzjbjmc");
			zjbjrs = request.getParameter("pzjbjrs");
			zjnjmc = request.getParameter("pzjnjmc");
			zjnjrs = request.getParameter("pzjnjrs");

			if (0 == ksZxtdz.length()) {
				response.sendRedirect("error.jsp?error="
						+ new UTF8String("中学通信地址不能为空!").toUTF8String());
				return;
			}

			if (0 == ksZxyb.length()) {
				response.sendRedirect("error.jsp?error="
						+ new UTF8String("邮政编码不能为空!").toUTF8String());
				return;
			}
			if (0 == ksZxlxdh.length()) {
				response.sendRedirect("error.jsp?error="
						+ new UTF8String("联系电话不能为空!").toUTF8String());
				return;
			}

			if (0 == ksNjfzr.length()) {
				response.sendRedirect("error.jsp?error="
						+ new UTF8String("年级负责人不能为空!").toUTF8String());
				return;
			}

			DBOperator dbo = new DBOperator();
			ICommonList icl;
			Cjjd cjjd;
			bmxxId = (null == bmxxId) ? "0" : bmxxId;
			int seqKey = Integer.parseInt(bmxxId);

			try {
				dbo.init(false);
			} catch (Exception e2) {
				logger.error(e2.getMessage());
				response.sendRedirect("error.jsp?error="
						+ new UTF8String("数据库访问错误！").toUTF8String());
				return;
			}

			try {

				cjjd = new Cjjd();
				cjjd.setBmxxid(seqKey);
				cjjd.setZxtxdz(ksZxtdz);
				cjjd.setZxjb(ksZxjb);
				cjjd.setZxybm(ksZxyb);
				cjjd.setZxlxdh(ksZxlxdh);
				cjjd.setNjfzr(ksNjfzr);

				cjjd.setGysyw(ksGysyw);
				cjjd.setGyssx(ksGyssx);
				cjjd.setGyswy(ksGyswy);
				cjjd.setGyswl(ksGyswl);
				cjjd.setGyshx(ksGyshx);

				cjjd.setGyssw(ksGyssw);
				cjjd.setGysls(ksGysls);
				cjjd.setGyszz(ksGyszz);
				cjjd.setGysdl(ksGysdl);
				cjjd.setGysty(ksGysty);
				cjjd.setGyszf(ksGyszf);
				if (gysbjmc.matches("\\d+"))
					cjjd.setGysbjmc(Integer.parseInt(gysbjmc));
				else
					cjjd.setGysbjmc(0);
				if (gysbjrs.matches("\\d+"))
					cjjd.setGysbjrs(Integer.parseInt(gysbjrs));
				else
					cjjd.setGysbjrs(0);
				if (gysnjmc.matches("\\d+"))
					cjjd.setGysnjmc(Integer.parseInt(gysnjmc));
				else
					cjjd.setGysnjmc(0);
				if (gysnjrs.matches("\\d+"))
					cjjd.setGysnjrs(Integer.parseInt(gysnjrs));
				else
					cjjd.setGysnjrs(0);

				cjjd.setGyxyw(ksGyxyw);
				cjjd.setGyxsx(ksGyxsx);
				cjjd.setGyxwy(ksGyxwy);
				cjjd.setGyxwl(ksGyxwl);
				cjjd.setGyxhx(ksGyxhx);

				cjjd.setGyxsw(ksGyxsw);
				cjjd.setGyxls(ksGyxls);
				cjjd.setGyxzz(ksGyxzz);
				cjjd.setGyxdl(ksGyxdl);
				cjjd.setGyxty(ksGyxty);
				cjjd.setGyxzf(ksGyxzf);

				if (gyxbjmc.matches("\\d+"))
					cjjd.setGyxbjmc(Integer.parseInt(gyxbjmc));
				else
					cjjd.setGyxbjmc(0);
				if (gyxbjrs.matches("\\d+"))
					cjjd.setGyxbjrs(Integer.parseInt(gyxbjrs));
				else
					cjjd.setGyxbjrs(0);
				if (gyxnjmc.matches("\\d+"))
					cjjd.setGyxnjmc(Integer.parseInt(gyxnjmc));
				else
					cjjd.setGyxnjmc(0);
				if (gyxnjrs.matches("\\d+"))
					cjjd.setGyxnjrs(Integer.parseInt(gyxnjrs));
				else
					cjjd.setGyxnjrs(0);

				cjjd.setGesyw(ksGesyw);
				cjjd.setGessx(ksGessx);
				cjjd.setGeswy(ksGeswy);
				cjjd.setGeswl(ksGeswl);
				cjjd.setGeshx(ksGeshx);

				cjjd.setGessw(ksGessw);
				cjjd.setGesls(ksGesls);
				cjjd.setGeszz(ksGeszz);
				cjjd.setGesdl(ksGesdl);
				cjjd.setGesty(ksGesty);
				cjjd.setGeszf(ksGeszf);
				if (gesbjmc.matches("\\d+"))
					cjjd.setGesbjmc(Integer.parseInt(gesbjmc));
				else
					cjjd.setGesbjmc(0);
				if (gesbjrs.matches("\\d+"))
					cjjd.setGesbjrs(Integer.parseInt(gesbjrs));
				else
					cjjd.setGesbjrs(0);
				if (gesnjmc.matches("\\d+"))
					cjjd.setGesnjmc(Integer.parseInt(gesnjmc));
				else
					cjjd.setGesnjmc(0);
				if (gesnjrs.matches("\\d+"))
					cjjd.setGesnjrs(Integer.parseInt(gesnjrs));
				else
					cjjd.setGesnjrs(0);

				cjjd.setGexyw(ksGexyw);
				cjjd.setGexsx(ksGexsx);
				cjjd.setGexwy(ksGexwy);
				cjjd.setGexwl(ksGexwl);
				cjjd.setGexhx(ksGexhx);
				cjjd.setGexsw(ksGexsw);
				cjjd.setGexls(ksGexls);
				cjjd.setGexzz(ksGexzz);
				cjjd.setGexdl(ksGexdl);
				cjjd.setGexty(ksGexty);
				cjjd.setGexzf(ksGexzf);
				if (gexbjmc.matches("\\d+"))
					cjjd.setGexbjmc(Integer.parseInt(gexbjmc));
				else
					cjjd.setGexbjmc(0);
				if (gexbjrs.matches("\\d+"))
					cjjd.setGexbjrs(Integer.parseInt(gexbjrs));
				else
					cjjd.setGexbjrs(0);
				if (gexnjmc.matches("\\d+"))
					cjjd.setGexnjmc(Integer.parseInt(gexnjmc));
				else
					cjjd.setGexnjmc(0);
				if (gexnjrs.matches("\\d+"))
					cjjd.setGexnjrs(Integer.parseInt(gexnjrs));
				else
					cjjd.setGexnjrs(0);

				cjjd.setGssyw(ksGssyw);
				cjjd.setGsssx(ksGsssx);
				cjjd.setGsswy(ksGsswy);
				cjjd.setGsswl(ksGsswl);
				cjjd.setGsshx(ksGsshx);
				cjjd.setGsssw(ksGsssw);
				cjjd.setGssls(ksGssls);
				cjjd.setGsszz(ksGsszz);
				cjjd.setGssdl(ksGssdl);
				cjjd.setGssty(ksGssty);
				cjjd.setGsszf(ksGsszf);
				if (gssbjmc.matches("\\d+"))
					cjjd.setGssbjmc(Integer.parseInt(gssbjmc));
				else
					cjjd.setGssbjmc(0);
				if (gssbjrs.matches("\\d+"))
					cjjd.setGssbjrs(Integer.parseInt(gssbjrs));
				else
					cjjd.setGssbjrs(0);
				if (gssnjmc.matches("\\d+"))
					cjjd.setGssnjmc(Integer.parseInt(gssnjmc));
				else
					cjjd.setGssnjmc(0);
				if (gssnjrs.matches("\\d+"))
					cjjd.setGssnjrs(Integer.parseInt(gssnjrs));
				else
					cjjd.setGssnjrs(0);

				cjjd.setHkyw(ksHkyw);
				cjjd.setHksx(ksHksx);
				cjjd.setHkwy(ksHkwy);
				cjjd.setHkwl(ksHkwl);
				cjjd.setHkhx(ksHkhx);
				cjjd.setHksw(ksHksw);
				cjjd.setHkls(ksHkls);
				cjjd.setHkzz(ksHkzz);
				cjjd.setHkdl(ksHkdl);
				cjjd.setHkty(ksHkty);
				cjjd.setHkzf(ksHkzf);
				if (hkbjmc.matches("\\d+"))
					cjjd.setHkbjmc(Integer.parseInt(hkbjmc));
				else
					cjjd.setHkbjmc(0);
				if (hkbjrs.matches("\\d+"))
					cjjd.setHkbjrs(Integer.parseInt(hkbjrs));
				else
					cjjd.setHkbjrs(0);
				if (hknjmc.matches("\\d+"))
					cjjd.setHknjmc(Integer.parseInt(hknjmc));
				else
					cjjd.setHknjmc(0);
				if (hknjrs.matches("\\d+"))
					cjjd.setHknjrs(Integer.parseInt(hknjrs));
				else
					cjjd.setHknjrs(0);

				cjjd.setZjyw(ksZjyw);
				cjjd.setZjsx(ksZjsx);
				cjjd.setZjwy(ksZjwy);
				cjjd.setZjwl(ksZjwl);
				cjjd.setZjhx(ksZjhx);
				cjjd.setZjsw(ksZjsw);
				cjjd.setZjls(ksZjls);
				cjjd.setZjzz(ksZjzz);
				cjjd.setZjdl(ksZjdl);
				cjjd.setZjty(ksZjty);
				cjjd.setZjzf(ksZjzf);
				if (zjbjmc.matches("\\d+"))
					cjjd.setZjbjmc(Integer.parseInt(zjbjmc));
				else
					cjjd.setZjbjmc(0);
				if (zjbjrs.matches("\\d+"))
					cjjd.setZjbjrs(Integer.parseInt(zjbjrs));
				else
					cjjd.setZjbjrs(0);
				if (zjnjmc.matches("\\d+"))
					cjjd.setZjnjmc(Integer.parseInt(zjnjmc));
				else
					cjjd.setZjnjmc(0);
				if (zjnjrs.matches("\\d+"))
					cjjd.setZjnjrs(Integer.parseInt(zjnjrs));
				else
					cjjd.setZjnjrs(0);
				cjjd.setBzrpj(bzrpj);

				icl = new CjjdList(seqKey);
				if (0 != seqKey) {
					dbo.delete(icl.delete(cjjd));
				}

				dbo.insert(icl.insert(cjjd));

				Log log = new Log();
				icl = new LogsList();
				log.setContent(USERNAME + " 填写成绩鉴定表。");
				dbo.insert(icl.insert(log));

				dbo.commit();
			} catch (Exception ess) {
				dbo.rollback();
				logger.error(ess.getMessage());
				response.sendRedirect("error.jsp?error="
						+ new UTF8String("数据库访问错误！").toUTF8String());
			} finally {
				if (null != dbo)
					dbo.dispose();
			}
			// response.sendRedirect("loginin/browsecjjd.jsp");
			response.sendRedirect("loginin/saveok.html");
			return;
		} catch (Exception e) {
			logger.error(e.getMessage());
			response.sendRedirect("error.jsp?error="
					+ new UTF8String("填写成绩鉴定表时发生错误！").toUTF8String());
			return;
		}

	}
}
