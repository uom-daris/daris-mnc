package mnc.mf.plugin.pssd.services;


import java.util.Collection;

import nig.mf.pssd.CiteableIdUtil;
import arc.mf.plugin.PluginService;
import arc.mf.plugin.ServiceExecutor;
import arc.mf.plugin.PluginService.Interface.Element;
import arc.mf.plugin.dtype.CiteableIdType;
import arc.xml.XmlDoc;
import arc.xml.XmlDocMaker;
import arc.xml.XmlWriter;

// Specialized service used to handle the evolution of some changes to
// mnc:ethics
// 1. Run this service
// 2. Destroy old document type mnc:ethics (asset.doc.type.destroy)
// 3. Rename new to old (asset.doc.type.rename)
//

public class SvcEthicsMetaMigrate extends PluginService {

	final String DOCTYPE_OLD = "mnc:ethics";
	final String DOCTYPE_NEW = "mnc:ethics_new";

	private Interface _defn;

	public SvcEthicsMetaMigrate() {
		_defn = new Interface();
		_defn.add(new Element("id", CiteableIdType.DEFAULT,
				"The citeable id of the PSSD project. All will be found if not supplied.", 0, 1));
	}

	public String name() {
		return "mnc.pssd.ethics.meta.migrate";
	}

	public String description() {
		return "Migrates meta-data (one off) from old mnc:ethics doctype to new";
	}

	public Interface definition() {
		return _defn;
	}

	public Access access() {
		return ACCESS_ADMINISTER;
	}

	public void execute(XmlDoc.Element args, Inputs in, Outputs out, XmlWriter w) throws Throwable {
		String cid = args.value("id");
		if (cid!=null) {
			if (!CiteableIdUtil.isProjectId(cid)) {
				throw new Exception ("The supplied object is not a project");
			}
		}

		// Query to find content
		XmlDocMaker doc = new XmlDocMaker("args");
		if (cid==null) {
			doc.add("where", DOCTYPE_OLD + " has value");
			doc.add("size", "infinity");
		} else {
			doc.add("where", DOCTYPE_OLD + " has value and cid='" + cid + "'");
		}
		doc.add("pdist", 0);      // Force local
		XmlDoc.Element ret = executor().execute("asset.query", doc.root());

		// Get collection of asset IDs
		Collection<String> assets = ret.values("id");
		int nAssets = 0;
		if (assets != null) {

			// Iterate through and get each asset
			for (String id : assets) {
				cid = nig.mf.pssd.plugin.util.CiteableIdUtil.idToCid(executor(), id);
				migrate (executor(), id, cid);
				w.add("id", cid);
			}
		}
	}

	private void migrate (ServiceExecutor executor, String id, String cid) throws Throwable {

		// Get old document type
		XmlDocMaker dm = new XmlDocMaker("args");
		dm.add("id", cid);
		XmlDoc.Element doc = executor.execute("om.pssd.object.describe", dm.root());
		if (doc==null) return;

		// Get old
		XmlDoc.Element old = doc.element("object/meta/"+DOCTYPE_OLD);
		if (old==null) return;
		Collection<XmlDoc.Element> oldElements =  old.elements();


		// Build new document
		dm = new XmlDocMaker("args");
		dm.add("cid", cid);
		dm.push("meta");
		dm.push(DOCTYPE_NEW, new String[]{"ns", "om.pssd.project", "tag", "pssd.meta"});
		for (XmlDoc.Element oldElement : oldElements) {
			String n = oldElement.name();
			//
			if (n.equals("ID")) {
				
				// Get existing attributes
				int l = 0;
				XmlDoc.Attribute t = oldElement.attribute("organization");
				if (t!=null) l++;
				XmlDoc.Attribute t2 = oldElement.attribute("Title");
				if (t2!=null) l++;
				XmlDoc.Attribute t3 = oldElement.attribute("Ethics_number");
				if (t3!=null) l++;

				// Get existing child element
				String t4 = oldElement.stringValue("other_organisation");
				if (t4!=null) l++;
				

				// Rebuild
				String[] atts = new String[2*l];
				int idx = 0;
				if (t!=null) {
					atts[idx] = "Organisation";
					atts[idx+1] = t.value();
					idx += 2;
				}
				if (t2!=null) {
					atts[idx] = "Title";
					atts[idx+1] = t2.value();
					idx += 2;
				}
				if (t3!=null) {
					atts[idx] = "ID";
					atts[idx+1] = t3.value();
					idx += 2;
				}
				if (t4!=null) {
					atts[idx] = "Organisation_other";
					atts[idx+1] = t4;
					idx += 2;
				}
				//			
				XmlDocMaker dm2 = new XmlDocMaker("Project_ethics", atts);
				dm.add(dm2.root());
			} else if (n.equals("databank_ethics")) {
				oldElement.setName("Databank_ethics");
				XmlDoc.Element mr = oldElement.element("MRIClinical");
				if (mr!=null) mr.setName("MRI_Clinical");			
				dm.add(oldElement);
			}
		}	
	    dm.pop();
	    dm.pop();
		// Set
		executor.execute("asset.set", dm.root());

		// Remove old document type
		dm = new XmlDocMaker("args");
		dm.add("cid", cid);
		dm.push("meta", new String[] {"action", "remove"});
		dm.push(DOCTYPE_OLD, new String[]{"ns", "om.pssd.project", "tag", "pssd.meta"});
		dm.pop();
		dm.pop();
		executor.execute("asset.set", dm.root());

	}
}
