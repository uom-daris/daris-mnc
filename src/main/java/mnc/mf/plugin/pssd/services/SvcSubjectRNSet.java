package mnc.mf.plugin.pssd.services;


import java.util.Collection;
import java.util.Vector;

import arc.mf.plugin.*;
import arc.mf.plugin.PluginService.Interface.Element;
import arc.mf.plugin.dtype.BooleanType;
import arc.mf.plugin.dtype.StringType;
import arc.xml.*;

import nig.mf.plugin.util.AssetUtil;


public class SvcSubjectRNSet extends PluginService {

	private Interface _defn;

	public SvcSubjectRNSet() {
		_defn = new Interface();	
		_defn.add(new Element("cid", StringType.DEFAULT, "The subject's citeable ID.", 0,1));
		_defn.add(new Element("id", StringType.DEFAULT, "The subject's asset id.", 0,1));
		_defn.add(new Element("ns", StringType.DEFAULT, "The meta-data namespace for the mnc:subject.ID document.  If not pre-existing, defaults to pssd.private.", 0,1));
		_defn.add(new Element("all", BooleanType.DEFAULT, "If true (default), update all Subject assets, matching this subject, which don't have an RN. Otherwise, just do this asset. ", 0, 1));
		_defn.add(new Element("allocate", BooleanType.DEFAULT, "Actually allocate the RN (default true).", 0, 1));
		_defn.add(new Element("set", BooleanType.DEFAULT, "Actually set the new RN (default true) if needed.", 0, 1));
	}


	public String name() {
		return "mnc.pssd.rn.subject.set";
	}

	public String description() {
		return "Finds existing subjects matching the given one, looks for an MNC Research Number (mnc:subject.ID/RN) and sets on this asset. If none, allocate new RN and set. Optionally sets the RN on all other like subjects which currently have no RN.";
	}

	public Interface definition() {
		return _defn;
	}

	public Access access() {
		return ACCESS_MODIFY;
	}

	public void execute(XmlDoc.Element args, Inputs in, Outputs out, XmlWriter w) throws Throwable {
		
		// Parse
		String id = args.value("id");
		String cid = args.value("cid");
		if (id == null && cid == null) {
			throw new Exception("Neither id nor cid was specified.");
		}
		if (id == null) id = AssetUtil.getId(executor(), cid);
		Boolean allocate = args.booleanValue("allocate", true);
		Boolean set = args.booleanValue("set", true);
		String defNS = args.stringValue("ns", "pssd.private");
		Boolean all = args.booleanValue("all", true);

		// Get the asset. We circumvent the om.pssd layer as we don't want application
		// controls stopping us from seeing private meta-data
		XmlDoc.Element assetIn = AssetUtil.getAsset(executor(), cid, id);
		if (assetIn==null) {
			throw new Exception ("No asset associated with this id");
		}
		String model = assetIn.value("asset/model");
		if (model==null || !model.equals("om.pssd.subject")) {
			throw new Exception ("The given asset is not a Subject");
		}
		XmlDoc.Element r = assetIn.element("asset/meta");


		// Get the meta-data
		String firstName = r.value("mnc:subject.name/first_name");
		String lastName = r.value("mnc:subject.name/surname");
		String gender = r.value("mnc:subject.characteristics/gender");
		String dob = r.value("mnc:subject.characteristics/DOB");

		// We must have all of these
		if (firstName==null || lastName==null || gender==null || dob==null) {
			return;
		}

		// Find other subject with same credentials
		String query = "xpath(mnc:subject.name/first_name)=ignore-case('" + firstName + "')";
		query += " and xpath(mnc:subject.name/surname)=ignore-case('" + lastName + "')";
		query += " and xpath(mnc:subject.characteristics/gender)=ignore-case('" + gender + "')";
		query += " and xpath(mnc:subject.characteristics/DOB)='" + dob + "'";
		query += " and id!=" + id;    // Don't find ourselves

		// Fetch named root; creates if not in existence
		XmlDocMaker dm = new XmlDocMaker("args");
		dm.add("where", query);
		dm.add("pdist", 0);
		dm.add("action", "get-meta");
		System.out.println("query=" + dm.root());
		r = executor().execute("asset.query", dm.root());

		// Work through the results and work out who needs an RN
		boolean needNewRN = false;
		Vector<XmlDoc.Element> subjectsWithNoRN = new Vector<XmlDoc.Element>();
		XmlDoc.Element firstRN = null;
		if (r==null) {
			needNewRN = true;
			System.out.println("A: found no other subject assets with this RN");
		} else {
			Collection<XmlDoc.Element> assets = r.elements("asset");
			//
			if (assets==null) {
				System.out.println("B: found no other subject assets with this RN");
				needNewRN = true;
			} else {
				System.out.println("Found " + assets.size() + " other subject assets");

				// Iterate through subjects
				boolean first = true;
				String concat = "";
				for (XmlDoc.Element asset : assets) {
					XmlDoc.Element RN = asset.element("meta/mnc:subject.ID/RN");
					System.out.println("Found RN = " + RN + " on asset" + asset.value("cid"));
					if (RN==null) {
						subjectsWithNoRN.add(asset);
					} else {
						// We have an RN; compare with others for this Subject
						String RNVal = RN.value();
						concat += " " + RNVal;
						if (first) {
							firstRN = RN;
							first = false;
						} else {
							if (!RNVal.equals(firstRN.value())) {
								throw new Exception ("Found multiple subjects with RNs, but they are not all the same: '" + concat + "'");
							}
						}
					}
				}
				// Did we find and RN for this Subject ?
				if (firstRN==null) needNewRN = true;
			}
		}

		//  Allocate new RN if needed
		if (needNewRN) {
			// We need a new RN
			if  (allocate) {
				firstRN = SvcRNCreate.allocateAsRN (executor(), SvcRNCreate.RN_NAMED_ROOT);
				System.out.println("allocated" + firstRN);
			} else {
				return;
			}
		} else {
			System.out.println("found old RN = " + firstRN);

		}

		// Now set the new RN for ourself, and if desired, others too
		if (set) {
			setRN (executor(), firstRN, assetIn.element("asset"), defNS);
			w.add("id", new String[]{"fullRN", firstRN.value("@cid"), "RN", firstRN.value()}, assetIn.value("asset/@id"));
			System.out.println("set " + firstRN + " on self");
			if (all) {
				for (XmlDoc.Element subjectWithNoRN : subjectsWithNoRN) {
					setRN (executor(), firstRN, subjectWithNoRN, defNS);
					w.add("id", new String[]{"fullRN", firstRN.value("@cid"), "RN", firstRN.value()}, subjectWithNoRN.value("@id"));
					System.out.println("set " + firstRN + subjectWithNoRN.value("@id"));
				}	
			}
		}
	}

	private void setRN (ServiceExecutor executor, XmlDoc.Element RN, XmlDoc.Element asset, String defNS) throws Throwable {
		String id = asset.value("@id");
		String ns = asset.value("meta/mnc:subject.ID/@ns");
		if (ns==null) ns = defNS;
		XmlDocMaker dm = new XmlDocMaker("args");
		dm.add("id", id);
		dm.push("meta", new String[]{"action", "merge"});
		dm.push("mnc:subject.ID", new String[]{"ns", ns});
		dm.add(RN);
		dm.pop();
		dm.pop();
		executor.execute("asset.set", dm.root());
	}
}

