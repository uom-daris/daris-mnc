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
// mnc:project
// 1. Run this service
// 2. Destroy old document type mnc:project (asset.doc.type.destroy)
// 3. Rename new to old (asset.doc.type.rename)
//

public class SvcProjectMetaMigrate extends PluginService {

	final String DOCTYPE_OLD = "mnc:project";
	final String DOCTYPE_NEW = "mnc:project_new";

	private Interface _defn;

	public SvcProjectMetaMigrate() {
		_defn = new Interface();
		_defn.add(new Element("id", CiteableIdType.DEFAULT,
				"The citeable id of the PSSD project. All will be found if not supplied.", 0, 1));
	}

	public String name() {
		return "mnc.pssd.project.meta.migrate";
	}

	public String description() {
		return "Migrates meta-data (one off) from old mnc:project to new";
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
			if (n.equals("investigator")) {

				// Rebuild
				XmlDocMaker dm2 = new XmlDocMaker("investigator");

				// Title
				XmlDoc.Element t = oldElement.element("title");
				if (t!=null) dm2.add(t);

				// Name
				t = oldElement.element("name");
				if (t!=null) {
					String[] parts = t.value().split(" ");
					int l = parts.length;
					if (l>0) {
						XmlDoc.Element t2 = new XmlDoc.Element("first_name", parts[0]);
						dm2.add(t2);
					}
					if (l>1) {
						XmlDoc.Element t2 = new XmlDoc.Element("last_name", parts[1]);
						dm2.add(t2);
					}
					if (l==3) {
						XmlDoc.Element t2 = new XmlDoc.Element("middle_name", parts[2]);
						dm2.add(t2);
					}
					if (l==4) {
						XmlDoc.Element t2 = new XmlDoc.Element("middle_name", parts[2]);
						dm2.add(t2);
						t2 = new XmlDoc.Element("middle_name", parts[3]);
						dm2.add(t2);
					}
				}

				// role
				t = oldElement.element("role");
				if (t!=null) dm2.add(t);

				// email
				t = oldElement.element("email");
				if (t!=null) dm2.add(t);

				// organisation
				t = oldElement.element("organisation");
				if (t!=null) {
					XmlDocMaker dm3 = new XmlDocMaker("institution");
					XmlDocMaker dm4 = null;     // FOr dual parents of departments

					String s = t.value();
					if (s.equals("Department of Psychiatry, The University o Melbourne")) { 
						XmlDoc.Element t2 = new XmlDoc.Element("name", "The University of Melbourne");
						dm3.add(t2);
						t2 = new XmlDoc.Element("department", "Department of Psychiatry");
						dm3.add(t2);
					} else if (s.equals("Department of Psychiatry, The University of Melbourne")) {
						XmlDoc.Element t2 = new XmlDoc.Element("name", "The University of Melbourne");
						dm3.add(t2);
						t2 = new XmlDoc.Element("department", "Department of Psychiatry");
						dm3.add(t2);				
					} else if (s.equals("Melbourne Neuropsychiatry Centre, Department of Psychiatry, The University of Melbourne, & Melbourne Health")) {
						XmlDoc.Element t2 = new XmlDoc.Element("name", "The University of Melbourne");
						dm3.add(t2);
						t2 = new XmlDoc.Element("department", "Department of Psychiatry");
						dm3.add(t2);
						t2 = new XmlDoc.Element("centre", "Melbourne Neuropsychiatry Centre");
						dm3.add(t2);
						//
						dm4 = new XmlDocMaker("institution");
						t2 = new XmlDoc.Element("name", "Melbourne Health");
						dm4.add(t2);
						t2 = new XmlDoc.Element("centre", "Melbourne Neuropsychiatry Centre");
						dm4.add(t2);
					} else if (s.equals("Monash University"))	{
						XmlDoc.Element t2 = new XmlDoc.Element("name", "Monash University");
						dm3.add(t2);
					} else if (s.equals("Orygen Youth Health Research Centre, Centre for Youth Mental Health, The University of Melbourne")) {
						XmlDoc.Element t2 = new XmlDoc.Element("name", "The University of Melbourne");
						dm3.add(t2);
						t2 = new XmlDoc.Element("centre", "Orygen Youth Health Research Centre");
						dm3.add(t2);	
					} else if (s.equals("Other")) {
						XmlDoc.Element t2 = new XmlDoc.Element("name", "Other research organization");
						dm3.add(t2);
					} else if (s.equals("Royal Melbourne Hospital")) {
						XmlDoc.Element t2 = new XmlDoc.Element("name", "Royal Melbourne Hospital");
						dm3.add(t2);
					} else if (s.equals("School of Psychological Sciences, The University of Melbourne")) {
						XmlDoc.Element t2 = new XmlDoc.Element("name", "The University of Melbourne");
						dm3.add(t2);
						t2 = new XmlDoc.Element("department", "School of Psychological Sciences");
						dm3.add(t2);	
					} else if (s.equals("Sunshine Hospital")) {
						XmlDoc.Element t2 = new XmlDoc.Element("name", "Sunshine Hospital");
						dm3.add(t2);			
					}

					// Set  
					dm2.add(dm3.root());
					if (dm4!=null) dm2.add(dm4.root());		
				}
				dm.add(dm2.root());
			} else if (n.equals("key_words")) {
				oldElement.setName("keyword");
				dm.add(oldElement);
			} else if (n.equals("keywords_other")) {
				oldElement.setName("keyword_other");
				dm.add(oldElement);
			} else if (n.equals("short_name") || n.equals("funding") || n.equals("data_collected")) {
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
