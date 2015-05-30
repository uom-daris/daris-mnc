package mnc.mf.plugin.pssd.services;


import java.util.Date;

import nig.mf.pssd.CiteableIdUtil;
import nig.util.DateUtil;
import arc.mf.plugin.PluginService;
import arc.mf.plugin.PluginService.Interface.Element;
import arc.mf.plugin.dtype.CiteableIdType;
import arc.xml.XmlDoc;
import arc.xml.XmlDocMaker;
import arc.xml.XmlWriter;

// Specialized service used to grab meta-data from DICOM files
// and populate mnc:scan
//

public class SvcStudyScanGrab extends PluginService {


	private Interface _defn;

	public SvcStudyScanGrab() {
		_defn = new Interface();
		_defn.add(new Element("id", CiteableIdType.DEFAULT,
				"The citeable id of the PSSD Study.", 1, 1));
	}

	public String name() {
		return "mnc.pssd.study.scan.grab";
	}

	public String description() {
		return "Grabs meta-data from DICOM files to populate mnc:scan.";
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
			if (!CiteableIdUtil.isStudyId(cid)) {
				throw new Exception ("The supplied object is not a Study");
			}
		}
		
		// Get the DICOM meta-data for the first child DICOM file
		XmlDocMaker dm = new XmlDocMaker("args");
		dm.add("pdist", 0);
		dm.add("where", "cid starts with '" + cid + "' and type='dicom/series'");
		XmlDoc.Element r = executor().execute("asset.query", dm.root());
		if (r==null) return;
		
		// Get first file
		String id = r.value("id");
		if (id==null) return;
		
		// Get DICOM meta-data
		dm = new XmlDocMaker("args");
		dm.add("id", id);
		XmlDoc.Element dicomMeta = executor().execute("dicom.metadata.get", dm.root());
		if (dicomMeta==null) return;
		
		// Create document to pass to the domain meta-data setting function
		dm = new XmlDocMaker("args");
		dm.add("id", cid);
		dm.push("dicom");
		// Convert date + time to standard MF format
		String studyDate = dicomMeta.value("de[@tag='00080020']/value");
		String studyTime = dicomMeta.value("de[@tag='00080030']/value");
		String t = studyTime.substring(0, studyTime.indexOf("."));
		String t2 = studyDate + " " + t;
		Date dateTime = DateUtil.dateFromString(t2, "dd-MMM-yyyy HHmmss");
		String dateTime2 = DateUtil.formatDate(dateTime, true, false);
		System.out.println("date = " + dateTime2);
		/*
		(0x0008,0x0020)  VR=<DA> VL=<0x00000008> StudyDate                           	 <20061023>
		(0x0008,0x0030)  VR=<TM> VL=<0x0000000E> StudyTime                           	 <145024.921000>
*/
		//
		String station = dicomMeta.value("de[@tag='00081010']/value");
		String magField = dicomMeta.value("de[@tag='00180087']/value");
		String age = dicomMeta.value("de[@tag='00101010']/value");
		
		dm.add("date", dateTime);
		dm.add("station", station);
		dm.add("magnetic_field_strength", magField);
		dm.push("subject");
		dm.add("age", age.substring(0,age.length()-1));    // Dyop off ending 'Y'
		dm.pop();
		dm.pop();

		// DO it.  This will compute time point also and set.
		executor().execute("mnc.pssd.object.meta.set", dm.root());

	}


}
