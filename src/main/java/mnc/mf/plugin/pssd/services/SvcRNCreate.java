package mnc.mf.plugin.pssd.services;


import nig.mf.pssd.CiteableIdUtil;
import arc.mf.plugin.*;
import arc.xml.*;


public class SvcRNCreate extends PluginService {

	public static final String RN_NAMED_ROOT = "MNC-Research-Number";

	private Interface _defn;

	public SvcRNCreate() {
		_defn = new Interface();		

	}


	public String name() {
		return "mnc.pssd.rn.create";
	}

	public String description() {
		return "Allocates the next MNC Research Number (RN).";
	}

	public Interface definition() {
		return _defn;
	}

	public Access access() {
		return ACCESS_MODIFY;
	}

	public void execute(XmlDoc.Element args, Inputs in, Outputs out, XmlWriter w) throws Throwable {
		XmlDoc.Element r = allocate (executor(), RN_NAMED_ROOT);
		w.add(r.element("cid"));
	}

	public static XmlDoc.Element  allocateAsRN (ServiceExecutor executor, String rootName) throws Throwable {
		// Allocate cid
		XmlDoc.Element r = allocate (executor, rootName);
		
		// Convert to Research Number
		String cid = r.value("cid");
		String rnNumber = CiteableIdUtil.getLastSection(cid);
		XmlDoc.Element RN = new XmlDoc.Element("RN", rnNumber);
		XmlDoc.Attribute att = new XmlDoc.Attribute("cid", cid);
		RN.add(att);
		return RN;
	}
	
	public static XmlDoc.Element  allocate (ServiceExecutor executor, String rootName) throws Throwable {
		// Fetch named root; creates if not in existence
		XmlDocMaker dm = new XmlDocMaker("args");
		dm.add("name", rootName);
		XmlDoc.Element r = executor.execute("citeable.named.id.create", dm.root());
		String pid = r.value("cid");

		// Get next value
		dm = new XmlDocMaker("args");
		dm.add("pid", pid);
		dm.add("pdist", 0);
		return executor.execute ("citeable.id.create", dm.root());
	}
}

