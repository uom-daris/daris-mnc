package mnc.mf.plugin.pssd.services;

import java.io.FileReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;

import com.opencsv.CSVReader;

import nig.iio.metadata.XMLUtil;
import nig.mf.plugin.util.AssetUtil;
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

public class SvcSubjectDiagnosisUpdate extends PluginService {

	private Interface _defn;

	public SvcSubjectDiagnosisUpdate() {
		_defn = new Interface();
	}

	public String name() {
		return "mnc.pssd.subject.diagnosis.update";
	}

	public String description() {
		return "Reads CSV spreadsheet and updates subject primary_diagnosis and diagnosis_notes fields. The element other-diagnosis is removed.";
	}

	public Interface definition() {
		return _defn;
	}

	public Access access() {
		return ACCESS_ADMINISTER;
	}

	public void execute(XmlDoc.Element args, Inputs in, Outputs out, XmlWriter w)
			throws Throwable {

		// Get hold of input csv file
		Input input = in.input(0);
		InputStream s = input.stream();
		InputStreamReader isr = new InputStreamReader(s);
		CSVReader reader = new CSVReader(isr);

		// Read into list
		reader.readNext(); // Drop headers
		List<String[]> list = reader.readAll();
		reader.close();

		// List
		Iterator<String[]> it = list.iterator();
		while (it.hasNext()) {
			String[] line = it.next();

			// CID primary_diagnosis otherdiagnosis diagnosis_notes
			// primary_diagnosis_new otherdiagnosis_new diagnosis_notes_new
			// 0 1 2 3 4 5 6
			String cid = line[0];
			String pd = line[4];
			String od = line[5];
			String notes = line[6];

			// Update
			update(executor(), cid, pd, od, notes, w);
		}
	}

	private void update(ServiceExecutor executor, String cid, String primary,
			String other, String notes, XmlWriter w) throws Throwable {
		if (!AssetUtil.exists(executor, cid, true))
			return;

		// Get old
		XmlDoc.Element oldMeta = AssetUtil.getAsset(executor, cid, null);

		// Set nulls
		primary = setNull(primary);
		other = setNull(other);
		notes = setNull(notes);
		// Nothing to do
		if (primary == null && other == null && notes == null)
			return;

		// Modify primary diagnosis element
		XmlDoc.Element classif = oldMeta
				.element("asset/meta/mnc:subject.classification");

		// This service assumes the old meta-data is always there
		if (classif == null)
			return;

		// Update primary if available or remove
		if (primary != null) {
			String oldPrimary = classif.value("primary_diagnosis");
			if (oldPrimary == null) {
				XmlDoc.Element t = new XmlDoc.Element("primary_diagnosis",
						primary);
				classif.add(t);
			} else {
				// Set new value by reference
				oldPrimary = primary;
			}
		} else {
			XMLUtil.removeElement(classif, "primary_diagnosis");
		}

		// Remove other diagnosis element
		XMLUtil.removeElement(classif, "other-diagnosis");

		// Modify notes
		if (notes != null) {
			String oldNotes = classif.value("diagnosis_notes");
			if (oldNotes == null) {
				XmlDoc.Element t = new XmlDoc.Element("diagnosis_notes", notes);
				classif.add(t);
			} else {
				// Set new value by reference
				oldNotes = notes;
			}
		} else {
			XMLUtil.removeElement(classif, "diagnosis_notes");
		}

		XmlDocMaker dm = new XmlDocMaker("args");
		dm.add("id", cid);
		dm.add("action", "replace");
		dm.push("private");
		dm.add(classif);
		dm.pop();
		executor.execute("om.pssd.subject.update", dm.root());
		w.add("id", cid);

	}

	private String setNull(String thing) {
		// Empty cells in the CSV manifest as Strings of length 1 holding a
		// space
		if (thing.length() == 1 && thing.equals(" ")) {
			return null;
		}
		return thing;
	}

	@Override
	public int maxNumberOfInputs() {
		return 1;
	}

	@Override
	public int minNumberOfInputs() {
		return 1;
	}

}
