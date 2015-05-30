package mnc.mf.plugin.pssd;

import arc.xml.*;
import nig.iio.metadata.DomainMetaData;
import nig.mf.Executor;

import java.util.Date;
import java.text.SimpleDateFormat;

/**
 * Supply the MNC domain-specific  project, subject and study meta-data to the DICOM server or Bruker client.
 * The framework is Data Model driven so that only the meta-data that could be attached is attached
 * 
 * The only reason we have functions for each object type is for clarity and because some
 * objects are handled slightly differently to others (add/merge/replace).  But the in reality,
 * the framework could hand in the object type and the test on object type be done internally
 * to this class. It does not matter much which way you do it.
 * 
 * The superclass, DomainMetaData sits in commons. In this way, specific packages like nig-pssd
 * can make use of the infrastructure but implement their own fully self-contained domain-specific
 * meta-data handler.
 * 
 * MNC set meta-data only for DICOM
 * 
 * @author nebk
 *
 */
public class MNCDomainMetaData extends DomainMetaData {

	private static final String DATE_FORMAT = "dd-MMM-yyyy";

	// Constructor
	public MNCDomainMetaData () {};



	/**
	 * 
	 * @param executor
	 * @param metaType SHould hold children elements "dicom" and/or "bruker" (but their children are irrelevant). This
	 * gives the context for which document types we are interested in.
	 * @param id
	 * @param objectType "project", "subject", "study"
	 * @param currentMeta The contents of xpath("asset/meta") after retrieval by asset.get
	 * @throws Throwable
	 */
	protected void removeElements (Executor executor, XmlDoc.Element metaType, String id, String objectType, XmlDoc.Element currentMeta) throws Throwable {

		XmlDoc.Element dicom = metaType.element("dicom");
		if (dicom!=null) {
			removeElementsDicom (executor, id, objectType, currentMeta);
		} 

		// No Bruker for MNC
	}

	/**
	 * Update the meta-data on the  project object.  This function must
	 * do the actual update with the appropriate service (e.g. om.pssd.project.update).
	 * This function over-rides the default implementation.
	 * 
	 * @param id The citeable ID of the object to update
	 * @param meta The DICOM Study Metadata or Bruker identifier metadata. This class must understand the structure of this object
	 *      it's up to you what you put in it.  This class is invoked by the service mnc.pssd.subject.meta.set and so its interface 
	 *      determines the structure
	 * @param privacyType The element to find the meta-data in the object description
	 * 					   For SUbjects and RSubjects should be one of "public", "private", "identity" 
	 *                     For other object types, should be "meta"
	 * @param docType the document type to write meta-data for.  The values must be mapped from the Study MetaData
	 * @param currentMeta  The meta-data that are attached to the asset (:foredit false)
	 * @throws Throwable
	 */
	protected void addTranslatedProjectDocument (Executor executor, String id, XmlDoc.Element meta, 
			String privacyType, String docType, XmlDoc.Element currentMeta) throws Throwable {
		if (meta==null) return;

		XmlDocMaker dm = null;
		if (docType.equals("mnc:project")) {
			if (checkDocTypeExists(executor, "mnc:project")) {
				dm = new XmlDocMaker("args");
				dm.add("id", id);
				dm.push(privacyType, new String[]{"action","merge"});
				boolean doIt = addProjectOuter (meta, currentMeta, dm);
				if (!doIt) dm = null;
			}
		} 

		// Update the Project
		if (dm!=null) {
			updateProject(executor, dm);
		}
	}

	/**
	 * Update the meta-data on the  subject object. This function must
	 * do the actual update with the appropriate service (e.g. om.pssd.subject.update).
	 * This function over-rides the default implementation.
	 * 
	 * @param id The citeable ID of the object to update
	 * @param meta The DICOM Study Metadata or Bruker identifier metadata 
	 * @param privacyType The element to find the meta-data in the object description
	 * 					   For SUbjects and RSubjects should be one of "public", "private", "identity" (RSubjects)
	 *                     For other object types, should be "meta"
	 * @param docType the document type to write meta-data for.  The values must be mapped from the Study MetaData
	 * @param currentMeta  The meta-data that are attached to the asset (:foredit false)
	 * @throws Throwable
	 */
	protected void addTranslatedSubjectDocument (Executor executor, String id, XmlDoc.Element meta, String privacyType, 
			String docType, XmlDoc.Element currentMeta) throws Throwable {
		if (meta==null) return;

		XmlDocMaker dm = null;
		if (docType.equals("mnc:subject.characteristics")) {
			if (checkDocTypeExists(executor, "mnc:subject.characteristics")) {
				dm = new XmlDocMaker("args");
				dm.add("id", id);
				dm.push(privacyType);
				boolean doIt = addSubjectCharacteristicsOuter (meta, currentMeta, dm);
				if (!doIt) dm = null;
			}
		}

		// Update the SUbject
		if (dm!=null) {
			updateSubject(executor, dm);
		}

	}


	/**
	 * Update the meta-data on the study object.  This function must
	 * do the actual update with the appropriate service (e.g. om.pssd.project.update).
	 * This function over-rides the default implementation.
	 * 
	 * @param id The citeable ID of the object to update
	 * @param meta The DICOM Study Metadata or Bruker identifier metadata to set
	 * @param privacyType The element to find the meta-data in the object description
	 * 					   For SUbjects and RSubjects should be one of "public", "private", "identity" 
	 *                     For other object types, should be "meta"
	 * @param docType the document type to write meta-data for.  The values must be mapped from the Study MetaData
	 * @param ns An addition namespace to be set on the meta-data being updated.  Its purpose is for
	 *       Method namespaces like cid_step that must be set on the Method specified Study meta-data
	 * @param currentMeta  The meta-data that are attached to the asset (:foredit false)
	 * @throws Throwable
	 */
	protected void addTranslatedStudyDocument (Executor executor, String id, XmlDoc.Element meta, 
			String privacyType, String docType, String ns, XmlDoc.Element currentMeta) throws Throwable {
		if (meta==null) return;
		XmlDocMaker dm = null;
		if (docType.equals("mnc:scan")) {
			if (checkDocTypeExists(executor, "mnc:scan")) {
				dm = new XmlDocMaker("args");
				dm.add("id", id);
				dm.push(privacyType, new String[]{"action","merge"});
				boolean doIt = addStudyOuter (executor, meta, ns, currentMeta, id, dm);
				if (!doIt) dm = null;
			}
		} 

		// Update the Study
		if (dm!=null) {
			updateStudy(executor, dm);
		}
	}


	private boolean addProjectOuter (XmlDoc.Element meta,  XmlDoc.Element currentMeta,  XmlDocMaker dm) throws Throwable {

		// Nothing at this time
		return false;

	}



	private boolean addSubjectCharacteristicsOuter (XmlDoc.Element meta,  XmlDoc.Element currentMeta,  XmlDocMaker dm) throws Throwable {

		XmlDoc.Element dicom = meta.element("dicom");
		Boolean set = false;
		if (dicom!=null) {
			XmlDoc.Element subject = dicom.element("subject");
			if (subject!=null) {

				// Extract values from container
				Date dob = subject.dateValue("dob");
				String dobString = null;
				if (dob != null) {
					SimpleDateFormat df = new SimpleDateFormat(DATE_FORMAT);
					dobString = df.format(dob).toString();
				}
				// Rewrite values as wanted by MNC Doc Type
				String gender = subject.value("sex");
				if (gender!=null) {
					String t = gender.substring(0,1);
					if (t.equalsIgnoreCase("m")) {
						gender = "male";
					} else if (t.equalsIgnoreCase("f")) {
						gender = "female";
					} else {
						if (t.length()>0) {
							gender = "other";
						} else {
							gender = "unknown";
						}
					}
				}
				//
				set = addSubjectCharacteristics (dobString, gender, currentMeta, dm);
			}
		}

		// No Bruker

		return set;
	}

	private boolean addStudyOuter (Executor executor, XmlDoc.Element meta,  String ns, XmlDoc.Element currentMeta,  String id, XmlDocMaker dm) throws Throwable {

		// Only DICOM mapping at this time
		XmlDoc.Element dicom = meta.element("dicom");
		Boolean set = false;
		if (dicom!=null) {
			Date date = dicom.dateValue("date");  
			//
			String station = dicom.value("station"); 
			String scannerString = setScannerString (station);

			// TBD: Not currently available in mf-dicom-study. Request made to Arcitecta to include.
			String magneticField = dicom.value("magnetic_field_strength");   
			//
			String age = dicom.value("subject/age");
			//
			// Try to work out the time point of this acquisition.
			String timePoint = setTimePoint(executor, id, date);
			
			// Set the meta-data
			set = addScanMetaData (ns, date, scannerString, magneticField, age, timePoint, currentMeta, dm);
		}

		return set;
	}

	
	/*
	 * From the data of acquisition and the specified time-point separation, try and
	 * work out what time point this is.  The time points are defined in an enumerated
	 * list in the Doc Type mnc:scan/time_point as baseline, followup1, followup2 etc
	 * The time point separation is defined in mnc:project/time_point_separation
	 * 
	 * id is the CID of the Study
	 * date is the date of this Study
	 */
	private String setTimePoint (Executor executor, String id, Date date) throws Throwable {
		
		// FInd parent Project an Subject
		
		String pid = nig.mf.pssd.CiteableIdUtil.getProjectId(id);
		String eid = nig.mf.pssd.CiteableIdUtil.getParentId(id);
		//System.out.println("id, pid, eid = " + id + ", " + pid + ", " + eid);
		if (pid!=null && eid!=null) {
		
			// Find first STudy (could be this one)
			String fid = findFirstStudy (executor, eid);
			if (fid.equals(id)) {
				return "baseline";
			}

			// Find the acquisition date of the first study
			Date dateFirst = getDicomAcqDate (executor, fid);
			/*
			System.out.println("date       = " + date);
			System.out.println("date first = " + dateFirst);
			 */
		
		   // Get time point separation from project
			XmlDoc.Element meta = describe (executor, pid);
			if (meta!=null) {
				String timePointSep = meta.value("object/meta/mnc:project/time_point/separation");
				if (timePointSep!=null) {
					// See if we can work out the time point
					String tp = calcTimePoint (date, dateFirst, timePointSep);
					// System.out.println("time point = " + tp);
					return tp;
				}
				
			}
		   
		}
		
		return null;
	}
	
	
	private String calcTimePoint (Date date, Date dateFirst, String timePointSep) throws Throwable {
		Integer d = nig.util.DateUtil.dateInDays(date);
		Integer fd = nig.util.DateUtil.dateInDays(dateFirst);
		/*
		System.out.println("d (days) "+ d);
		System.out.println("fd (days) "+ fd);
		*/

		//
		Integer tps = Integer.parseInt(timePointSep) * 31;    // Nominal days
		Integer dt = (d - fd);                                // Separation in Days
		/*
		System.out.println("tps=" + tps);
		System.out.println("dt (days) = " + dt);
		*/
		
		dt = dt - (tps/2);
		if (dt<0) return "baseline";
		Integer n = (dt / tps) + 1;
		
		return "followup-"+n;
	}
	
	/**
	 * This function finds the first Study.
	 * TBD: it should be enhanced to find the first study by date, not CID
	 * 
	 * @param executor
	 * @param exMethodId
	 * @return
	 * @throws Throwable
	 */
	private String findFirstStudy (Executor executor, String exMethodId) throws Throwable {
		XmlDocMaker dm = new XmlDocMaker("args");
		dm.add("id", exMethodId);
		XmlDoc.Element r = executor.execute("om.pssd.collection.member.list", dm);
		if (r!=null) {
			return  r.value("object/id");      // Get the first
		}
		return null;
	}
	
	private Date getDicomAcqDate(Executor executor, String id) throws Throwable {

		XmlDoc.Element meta = describe(executor, id);
		if (meta==null) return null;
		
		// See if we can find a DICOM date
		String dateString = meta.stringValue("object/meta/mf-dicom-study/sdate");
		if (dateString==null) return null;
		return nig.util.DateUtil.dateFromString(dateString, DATE_FORMAT);
	}

	private XmlDoc.Element describe (Executor executor, String id) throws Throwable {
		XmlDocMaker dm = new XmlDocMaker("args");
		dm.add("id", id);
		return executor.execute("om.pssd.object.describe", dm);
	}

	private String setScannerString (String station) {
		if (station==null) return null;

		// TBD: We need to find all the values of the station DICOM element to do this mapping
		// to the dictionary scanner_site
		/*
		   addDictionaryEntry scanner_site  "Brain Research Institute"
		    addDictionaryEntry scanner_site  "Royal Childrens Hospital"
		    addDictionaryEntry scanner_site  "Royal Melbourne Hospital Public"
		    addDictionaryEntry scanner_site  "Royal Melbourne Hospital Private"
		    addDictionaryEntry scanner_site  "Sunshine Hospital"	
		 */
		
		// Dictionary is case insensitive
		if (station.equalsIgnoreCase("MRC35113") || station.equalsIgnoreCase("MRITRIO")) {
			return "royal childrens hospital";
		} else if (station.equalsIgnoreCase("GEHCGEHC")) {
			return "sunshine hospital";
		}
		return null;

	}



	private boolean addScanMetaData  (String ns, Date date, String scanner, String magneticField, String age, 
			String timePoint, XmlDoc.Element currentMeta, XmlDocMaker dm) throws Throwable {

		// Set updated meta-data
		// Bug out if none
		if (date==null && scanner==null && magneticField==null && age==null) {
			dm.pop();        // "meta' pop
			return false;
		}

		// Set the meta-data.  We assume that if the element is already set on the object that it is correct
		XmlDoc.Element scanMeta = currentMeta.element("mnc:scan");

		dm.push("mnc:scan", new String[]{"ns", ns});

		if (date!=null) {
			dm.add("date_from_DICOM", date);     // Always write this field
		}
		if (scanner != null) {
			String oldScanner = null;
			if (scanMeta!=null) oldScanner = scanMeta.value("site");
			if (oldScanner==null) dm.add("site", scanner);
		}
		if (magneticField!=null) {
			String oldField = null;
			if (scanMeta!=null) oldField = scanMeta.value("magnetic_field");
			if (oldField==null) dm.add("magnetic_field", new String[]{"unit", "Tesla"}, magneticField);
		}
		if (age!=null) {
			String oldAge = null;
			if (scanMeta!=null) oldAge = scanMeta.value("age");
			if (oldAge==null) dm.add("age", age);
		}
		// 
		if (timePoint!=null) {
			String oldTimePoint = null;
			if (scanMeta!=null) oldTimePoint = scanMeta.value("time_point");
			if (oldTimePoint==null) dm.add("time_point", timePoint);
		}
		dm.pop();
		dm.pop();      // "meta" pop
		return true;
	}



	private boolean addSubjectCharacteristics (String dob, String gender, XmlDoc.Element currentMeta,  XmlDocMaker dm) throws Throwable {

		// Get current meta-data for appropriate DocType
		if (currentMeta!=null) {
			XmlDoc.Element subjectMeta = currentMeta.element("mnc:subject.characteristics");

			// We assume that if the element is already set on the object that it is correct
			if (subjectMeta!=null) {
				String currGender = subjectMeta.value("gender");
				if (currGender!=null) gender = currGender;
				//
				String currDate = subjectMeta.value("DOB");
				if (currDate != null) dob = currDate;
			}
		}

		// Set updated meta-data
		if (gender!=null || dob!=null) {
			dm.push("mnc:subject.characteristics");
			if (gender!=null) dm.add("gender", gender);
			if (dob != null) dm.add("DOB", dob);
			dm.pop();
		} else {
			return false;
		}

		// Merge these details
		dm.pop();      // "public" or "private" pop
		dm.add("action", "merge");	
		return true;
	}



	/**
	 * Remove the mapped elements for when we are considering DICOM meta-data.  
	 * 
	 * @param executor
	 * @param id
	 * @param objectType
	 * @param currentMeta
	 * @throws Throwable
	 */
	private void removeElementsDicom (Executor executor, String id, String objectType, XmlDoc.Element currentMeta) throws Throwable {
		XmlDocMaker dm = new XmlDocMaker("args");
		dm.add("cid", id);
		//
		boolean some = false;
		if (objectType.equals(DomainMetaData.PROJECT_TYPE)) {
			// Nothing yet
		} else if (objectType.equals(DomainMetaData.SUBJECT_TYPE)) {
			if (prepareRemovedMetaData (dm, currentMeta, "mnc:subject.characteristics", new String[]{"gender", "DOB"})) some = true;
		} else if (objectType.equals(DomainMetaData.STUDY_TYPE)) {
			if (prepareRemovedMetaData (dm, currentMeta, "mnc:scan", new String[]{"date_from_DICOM", "site", "magnetic_field", 
					                   "age", "time_point"})) some = true;	
		}
		//
		if (some) {
			executor.execute("asset.set", dm);
		}
	}
}
