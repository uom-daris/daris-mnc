proc createDict_MRI_Sequence { } {

    if { [xvalue exists [dictionary.exists :name MRI_sequence]] == "false" } {
	dictionary.create :name MRI_sequence :description "MRI sequence descriptions" :case-sensitive false
    }
    addDictionaryEntry  MRI_sequence "DTI"
    addDictionaryEntry  MRI_sequence "EPI"
    addDictionaryEntry  MRI_sequence "MRS"
    addDictionaryEntry  MRI_sequence "T1"
    addDictionaryEntry  MRI_sequence "T2"
    addDictionaryEntry  MRI_sequence "other"
}


proc createDict_SI_Units { } {

    if { [xvalue exists [dictionary.exists :name SI_units]] == "false" } {
	dictionary.create :name SI_units :description "SI Unit descriptions" :case-sensitive false
    }
    # No entries yet
}





proc createDict_Ethics_Organizations {} {
    if { [xvalue exists [dictionary.exists :name ethics_organization]] == "false" } {
	dictionary.create :name ethics_organization  :description "The organization that approves the ethics." :case-sensitive false
    }
    addDictionaryEntry ethics_organization "Melbourne Health"
    addDictionaryEntry ethics_organization "Monash University"
    addDictionaryEntry ethics_organization "Other"
    addDictionaryEntry ethics_organization "RCH" "Royal Children Hospital"
    addDictionaryEntry ethics_organization "SVH" "St Vincent Hospital"
    addDictionaryEntry ethics_organization "Southern Health"
    addDictionaryEntry ethics_organization "University of Melbourne"
}

proc createDict_Ethics_Usage {} {
    if { [xvalue exists [dictionary.exists :name ethics_usage]] == "false" } {
	dictionary.create :name ethics_usage :description "Usage of the datasets." :case-sensitive false
    }
    addDictionaryEntry ethics_usage "NA"
    addDictionaryEntry ethics_usage "full use"
    addDictionaryEntry ethics_usage "management purposes only"
    addDictionaryEntry ethics_usage "potential use only after contact with CIA" 
}


proc createDict_Imaging_Datatype {} {
    if { [xvalue exists [dictionary.exists :name imaging_data_type]] == "false" } {
	dictionary.create :name imaging_data_type :description "Type of imaging data" :case-sensitive false
    }
    addDictionaryEntry imaging_data_type "DTI"
    addDictionaryEntry imaging_data_type "MRS"
    addDictionaryEntry imaging_data_type "Other"
    addDictionaryEntry imaging_data_type "PET"
    addDictionaryEntry imaging_data_type "Resting fMRI"
    addDictionaryEntry imaging_data_type "SPECT"
    addDictionaryEntry imaging_data_type "Structural MRI"
    addDictionaryEntry imaging_data_type "Task fMRI"
}


proc createDict_Investigator_Role {} {
    if { [xvalue exists [dictionary.exists :name investigator_role]] == "false" } {
	dictionary.create :name investigator_role :description "Role of the investigator." :case-sensitive false
    }
    addDictionaryEntry investigator_role "associated investigator"
    addDictionaryEntry investigator_role "cia" "Chief Investigator"
    addDictionaryEntry investigator_role "other chief investigators"
    addDictionaryEntry investigator_role "research assistant"
    addDictionaryEntry investigator_role "student"
}


proc createDict_Keywords {} {
    if { [xvalue exists [dictionary.exists :name key_words]] == "false" } {
	dictionary.create :name key_words :description "Keyword relevant to the project." :case-sensitive false
    }
    addDictionaryEntry key_words "adolesence"
    addDictionaryEntry key_words "depression"
    addDictionaryEntry key_words "magnetic resonance imaging"
    addDictionaryEntry key_words "neuropsychiatry"
    addDictionaryEntry key_words "neuroscience"
    addDictionaryEntry key_words "risk factor"
    addDictionaryEntry key_words "schizophrenia"
    addDictionaryEntry key_words "substance use"
}

proc createDict_Scanner_Site {} {
    if { [xvalue exists [dictionary.exists :name scanner_site]] == "false" } {
	dictionary.create :name scanner_site :description "MRI Scanner locations" :case-sensitive false
    }
    addDictionaryEntry scanner_site  "Brain Research Institute"
    addDictionaryEntry scanner_site  "Royal Childrens Hospital"
    addDictionaryEntry scanner_site  "Royal Melbourne Hospital Public"
    addDictionaryEntry scanner_site  "Royal Melbourne Hospital Private"
    addDictionaryEntry scanner_site  "Sunshine Hospital"	
}


proc createDict_UR_Provider {} {
    if { [xvalue exists [dictionary.exists :name UR_provider]] == "false" } {
	dictionary.create :name UR_provider :description "Providers of UR numbers for patients. Generally a hospital" :case-sensitive false
    }
    addDictionaryEntry UR_provider  "Western Health"
    addDictionaryEntry UR_provider  "Austin Health"
    addDictionaryEntry UR_provider "Northern Health"
    addDictionaryEntry UR_provider "Orygen Youth Health"
    addDictionaryEntry UR_provider "Mental Health (state-wide)"
}
 

proc createDict_Site_Type {} {
    if { [xvalue exists [dictionary.exists :name site_type]] == "false" } {
	dictionary.create :name site_type :description "Category of project site." :case-sensitive false
    }
    addDictionaryEntry site_type "data collection"
    addDictionaryEntry site_type "site of collaborator"
    addDictionaryEntry site_type "site of investigator"
}


proc createDict_Subject_Consent {} {
    if { [xvalue exists [dictionary.exists :name subject_consent]] == "false" } {
	dictionary.create :name subject_consent :description "Category of subject consent." :case-sensitive false
    }
    addDictionaryEntry subject_consent "NA" "The participant was not given the opportunity to consent for their data to be included in the databank"
    addDictionaryEntry subject_consent "No" "The participant wishes there data to be included for management purposes only"
    addDictionaryEntry subject_consent "yes"	
}

proc createDict_Title {} {
    if { [xvalue exists [dictionary.exists :name title]] == "false" } {
	dictionary.create :name title :description "The title to address a person." :case-sensitive false
    }
    addDictionaryEntry title "Assistant Professor"
    addDictionaryEntry title "Associate Professor"
    addDictionaryEntry title "Dr"
    addDictionaryEntry title "Mdm"
    addDictionaryEntry title "Miss"
    addDictionaryEntry title "Mr"
    addDictionaryEntry title "Mrs"
    addDictionaryEntry title "Ms"
    addDictionaryEntry title "Professor"
}

proc createDict_TimePoint {} {
    if { [xvalue exists [dictionary.exists :name time_point]] == "false" } {
	  dictionary.create :name time_point :description "Provides symbolic time point representations" :case-sensitive false
    }
    addDictionaryEntry time_point  baseline  "The initial or baseline acquisition"
    addDictionaryEntry time_point  followup-1 "The first follow up after baseline"
    addDictionaryEntry time_point  followup-2 "The second follow up after baseline"
    addDictionaryEntry time_point  followup-3 "The third follow up after baseline"
    addDictionaryEntry time_point  followup-4 "The fourth follow up after baseline"
    addDictionaryEntry time_point  followup-5 "The fifth follow up after baseline"
}


proc createDict_Diagnosis_primary {} {

if { [xvalue exists [dictionary.exists :name "Diagnosis_Primary"]] == "false" } {
  dictionary.create :name "Diagnosis_Primary" :case-sensitive true :description "Primary Diagnosis"
}

addDictionaryEntry  "Diagnosis_Primary"  "292.11 Substance Induced Psychosis_Delusions"  "Sedative, hypnotic or anxiolytic substances."
addDictionaryEntry  "Diagnosis_Primary"  "292.12 Substance Induced Psychosis_Hallucinations"  "Sedative, hypnotic or anxiolytic substances."
addDictionaryEntry  "Diagnosis_Primary"  "292.1x Cannabis Induced Psychotic Disorder" 
addDictionaryEntry  "Diagnosis_Primary"  "292.1x Cocaine Induced Psychotic Disorder" 
addDictionaryEntry  "Diagnosis_Primary"  "294.8 Dementia NOS" 
addDictionaryEntry  "Diagnosis_Primary"  "294.9 Cognitive Disorder NOS" 
addDictionaryEntry  "Diagnosis_Primary"  "295.1 Schizophrenia_Disorganised" 
addDictionaryEntry  "Diagnosis_Primary"  "295.2 Schizophrenia_Catatonic" 
addDictionaryEntry  "Diagnosis_Primary"  "295.3 Schizophrenia_Paranoid" 
addDictionaryEntry  "Diagnosis_Primary"  "295.4 Schizophreniform Disorder" 
addDictionaryEntry  "Diagnosis_Primary"  "295.6 Schizophrenia_Residual" 
addDictionaryEntry  "Diagnosis_Primary"  "295.7 Schizoaffective Disorder" 
addDictionaryEntry  "Diagnosis_Primary"  "295.9 Schizophrenia_Undifferentiated" 
addDictionaryEntry  "Diagnosis_Primary"  "295.xx Schizophrenia"   "Schizophrenia Not Specified"
addDictionaryEntry  "Diagnosis_Primary"  "296.20 Major Depressive Disorder_Single"  "Unspecified severity"
addDictionaryEntry  "Diagnosis_Primary"  "296.24 Major Depressive Disorder_Psychotic Features" "Single episode, severe."
addDictionaryEntry  "Diagnosis_Primary"  "296.30 Major Depressive Disorder_Recurrent "   "Unspecified severity"
addDictionaryEntry  "Diagnosis_Primary"  "296.34 Major Depresive Disorder_Psychotic Features"   "Recurrent episodes, severe."
addDictionaryEntry  "Diagnosis_Primary"  "296.40 Bipolar I Disorder_Manic"  "Unspecified. Most recent episode manic."
addDictionaryEntry  "Diagnosis_Primary"  "296.50 Bipolar I Disorder_Depressed"   "Unspecified. Most recent episode depressed."
addDictionaryEntry  "Diagnosis_Primary"  "296.60 Bipolar I Disorder_Mixed"  "Most recent episode unspecified."
addDictionaryEntry  "Diagnosis_Primary"  "296.7 Bipolar I Disorder_Unspecified" 
addDictionaryEntry  "Diagnosis_Primary"  "296.80 Bipolar  Disorder NOS" 
addDictionaryEntry  "Diagnosis_Primary"  "296.89 Bipolar II Disorder" 
addDictionaryEntry  "Diagnosis_Primary"  "296.90 Mood Disorder NOS" 
addDictionaryEntry  "Diagnosis_Primary"  "297.1 Delusional Disorder" 
addDictionaryEntry  "Diagnosis_Primary"  "297.3 Shared Psychotic Disorder" 
addDictionaryEntry  "Diagnosis_Primary"  "298.8 Brief Psychotic Disorder" 
addDictionaryEntry  "Diagnosis_Primary"  "298.9 Psychotic Disorder NOS" 
addDictionaryEntry  "Diagnosis_Primary"  "299.00 Autistic Disorder" 
addDictionaryEntry  "Diagnosis_Primary"  "299.80 Asperger's Disorder" 
addDictionaryEntry  "Diagnosis_Primary"  "299.80 Attention Deficit/Hyperactivity Disorder" 
addDictionaryEntry  "Diagnosis_Primary"  "300.00 Anxiety Disorder NOS" 
addDictionaryEntry  "Diagnosis_Primary"  "300.01 Panic Disorder_Without Agoraphobia " 
addDictionaryEntry  "Diagnosis_Primary"  "300.02 Generalised Anxiety Disorder" 
addDictionaryEntry  "Diagnosis_Primary"  "300.21 Panic Disorder_Agoraphobia" 
addDictionaryEntry  "Diagnosis_Primary"  "300.3 Obsessive Compulsive Disorder" 
addDictionaryEntry  "Diagnosis_Primary"  "300.4 Dysthymic Disorder" 
addDictionaryEntry  "Diagnosis_Primary"  "300.81 Somatization Disorder" 
addDictionaryEntry  "Diagnosis_Primary"  "300.81 Somatoform Disorder NOS" 
addDictionaryEntry  "Diagnosis_Primary"  "300.82 Somatoform Disorder NOS" 
addDictionaryEntry  "Diagnosis_Primary"  "300.xx Anxiety Disorder NOS " 
addDictionaryEntry  "Diagnosis_Primary"  "301.2 Schizoid Personality Disorder" 
addDictionaryEntry  "Diagnosis_Primary"  "301.22 Schizotypal Personality Disorder" 
addDictionaryEntry  "Diagnosis_Primary"  "301.7 Antisocial Personality Disorder" 
addDictionaryEntry  "Diagnosis_Primary"  "301.83 Borderline Personality Disorder" 
addDictionaryEntry  "Diagnosis_Primary"  "301.9 Personality Disorder NOS" 
addDictionaryEntry  "Diagnosis_Primary"  "303.9 Alcohol Dependence" 
addDictionaryEntry  "Diagnosis_Primary"  "304.00 Opioid Dependence" 
addDictionaryEntry  "Diagnosis_Primary"  "304.2 Cocaine Dependence " 
addDictionaryEntry  "Diagnosis_Primary"  "304.3 Cannabis Dependence" 
addDictionaryEntry  "Diagnosis_Primary"  "304.40 Amphetamine Dependence" 
addDictionaryEntry  "Diagnosis_Primary"  "304.80 Polysubstance Dependence" 
addDictionaryEntry  "Diagnosis_Primary"  "304.90 Substance Dependence" 
addDictionaryEntry  "Diagnosis_Primary"  "305.00 Alcohol Abuse" 
addDictionaryEntry  "Diagnosis_Primary"  "305.2 Cannabis Abuse" 
addDictionaryEntry  "Diagnosis_Primary"  "305.50 Opioid abuse" 
addDictionaryEntry  "Diagnosis_Primary"  "305.6 Cocaine Abuse" 
addDictionaryEntry  "Diagnosis_Primary"  "305.70 Amphetamine abuse" 
addDictionaryEntry  "Diagnosis_Primary"  "305.90 Substance Abuse" 
addDictionaryEntry  "Diagnosis_Primary"  "307.1 Anorexia Nervosa" 
addDictionaryEntry  "Diagnosis_Primary"  "307.5 Eating Disorder NOS" 
addDictionaryEntry  "Diagnosis_Primary"  "307.51 Bulimia Nervosa" 
addDictionaryEntry  "Diagnosis_Primary"  "309.81Posttraumatic Stress Disorder" 
addDictionaryEntry  "Diagnosis_Primary"  "311.xx Depressive Disorder NOS" 
addDictionaryEntry  "Diagnosis_Primary"  "313.81 Oppositional Defiant Disorder" 
addDictionaryEntry  "Diagnosis_Primary"  "315.9 Learning Disorder NOS" 
addDictionaryEntry  "Diagnosis_Primary"  "799.9 Diagnosis Deferred on Axis I/II" 
addDictionaryEntry  "Diagnosis_Primary"  "Child Onset Schizophrenia" 
addDictionaryEntry  "Diagnosis_Primary"  "Epilepsy" 
addDictionaryEntry  "Diagnosis_Primary"  "First Episode Psychosis" 

}

proc createDict_Clinical_assessments {} {

if { [xvalue exists [dictionary.exists :name "Clinical_Assessments"]] == "false" } {
  dictionary.create :name "Clinical_Assessments" :case-sensitive true
}

addDictionaryEntry  "Clinical_Assessments"  "ASI_Anxiety Sensitivity Index" 
addDictionaryEntry  "Clinical_Assessments"  "ASSIST_Alcohol Smoking & Substance Involvement Screening Test" 
addDictionaryEntry  "Clinical_Assessments"  "AUDIT_Alcohol Use Disorders Identification Test" 
addDictionaryEntry  "Clinical_Assessments"  "BPRS_Brief Psychiatric Rating Scale" 
addDictionaryEntry  "Clinical_Assessments"  "CAARMS_Comprehensive Assessment of At Risk Mental States" 
addDictionaryEntry  "Clinical_Assessments"  "CANTAB_Cambridge Neuropsychological Test Automated Battery" 
addDictionaryEntry  "Clinical_Assessments"  "CDSS_Calgary Depression Scale for Schizophrenia" 
addDictionaryEntry  "Clinical_Assessments"  "CERQ_Cognitive Emotion Regulation Questionnaire" 
addDictionaryEntry  "Clinical_Assessments"  "CESD_Centre for Epidemiological Studies Depression scale" 
addDictionaryEntry  "Clinical_Assessments"  "CGI_Clinical Global Impression" 
addDictionaryEntry  "Clinical_Assessments"  "CTQ_Childhood Trauma Questionnaire" 
addDictionaryEntry  "Clinical_Assessments"  "Cogstate" 
addDictionaryEntry  "Clinical_Assessments"  "DANVA_Diagnostic Analysis of Non-Verbal Accuracy" 
addDictionaryEntry  "Clinical_Assessments"  "EHS_Edinburgh Handedness Scale" 
addDictionaryEntry  "Clinical_Assessments"  "ERQ_Emotion Regulation Questionnaire" 
addDictionaryEntry  "Clinical_Assessments"  "FIGS_Family Interview for Genetic Studies" 
addDictionaryEntry  "Clinical_Assessments"  "Fagerstrom Test for Nicotine Dependence" 
addDictionaryEntry  "Clinical_Assessments"  "GAD-7_Generalized Anxiety Disorder 7-item scale" 
addDictionaryEntry  "Clinical_Assessments"  "GAF_Global Assessment of Functioning Scale" 
addDictionaryEntry  "Clinical_Assessments"  "GASP_Guilt and Shame Proneness scale" 
addDictionaryEntry  "Clinical_Assessments"  "Hinting Task" 
addDictionaryEntry  "Clinical_Assessments"  "IES_Impact of Events Scale" 
addDictionaryEntry  "Clinical_Assessments"  "IPPA_Inventory of Parent and Peer Attachment" 
addDictionaryEntry  "Clinical_Assessments"  "IPSAQ_Internal, Personal, Situational Attribution Questionnaire" 
addDictionaryEntry  "Clinical_Assessments"  "LNS_Letter Number Sequencing" 
addDictionaryEntry  "Clinical_Assessments"  "MDRS_Montgomery Asberg Depression Rating Scale" 
addDictionaryEntry  "Clinical_Assessments"  "MINI International Neuropsychiatric Interview" 
addDictionaryEntry  "Clinical_Assessments"  "MSPSS_Multidimensional Scale of Perceived Social Support" 
addDictionaryEntry  "Clinical_Assessments"  "Mycoclonus Screening Questionnaire" 
addDictionaryEntry  "Clinical_Assessments"  "NAPLS_North American Prodromal Longitudinal Study Role Scale" 
addDictionaryEntry  "Clinical_Assessments"  "NES_Neurological Evaluation Scale" 
addDictionaryEntry  "Clinical_Assessments"  "Nutritional Questionnaire" 
addDictionaryEntry  "Clinical_Assessments"  "OSI_Orygen Substance Use Inventory" 
addDictionaryEntry  "Clinical_Assessments"  "PANSS_Positive and Negative Syndrome Scale" 
addDictionaryEntry  "Clinical_Assessments"  "PSP_Personal and Social Performance Scale" 
addDictionaryEntry  "Clinical_Assessments"  "PSS_Perceived Stress Scale" 
addDictionaryEntry  "Clinical_Assessments"  "Picture Sequencing Task" 
addDictionaryEntry  "Clinical_Assessments"  "QIDS-SR_Quick Inventory of Depressive Symptomatology" 
addDictionaryEntry  "Clinical_Assessments"  "RRS_Ruminative Response Scale" 
addDictionaryEntry  "Clinical_Assessments"  "RSQ_Rejection Sensitivity Questionnaire" 
addDictionaryEntry  "Clinical_Assessments"  "SANS_Scale for the Assessment of Negative Symptoms" 
addDictionaryEntry  "Clinical_Assessments"  "SAPS_Scale for the Assessment of Positive Symptoms" 
addDictionaryEntry  "Clinical_Assessments"  "SCID Screener_Control" 
addDictionaryEntry  "Clinical_Assessments"  "SCID_Structured Clinical Interview for DSM-IV Axis I Disorders" 
addDictionaryEntry  "Clinical_Assessments"  "SEI_Self-Esteem Inventory" 
addDictionaryEntry  "Clinical_Assessments"  "SIQ_Suicidal Ideation Questionnaire" 
addDictionaryEntry  "Clinical_Assessments"  "SOFAS_Social & Occupational Functioning Assessment Scale" 
addDictionaryEntry  "Clinical_Assessments"  "SWN_Subjective Wellbeing under Neuroleptics" 
addDictionaryEntry  "Clinical_Assessments"  "UKU_Udvalg for Kliniske undersogelser Side Effect Rating Scale" 
addDictionaryEntry  "Clinical_Assessments"  "WAIS-III_Wechsler Adult Intelligence Scale ? III " 
addDictionaryEntry  "Clinical_Assessments"  "WASI_Wechsler Abbreviated Scale of Intelligence" 
addDictionaryEntry  "Clinical_Assessments"  "WCST_Wisconsin Card Sorting Test" 
addDictionaryEntry  "Clinical_Assessments"  "WTAR_Wechsler Test of Adult Reading" 
addDictionaryEntry  "Clinical_Assessments"  "YMRS_Young Mania Rating Scale"
}


#============================================================================#
proc createUpdatePSSDDicts { } {

    createDict_MRI_Sequence
    createDict_SI_Units
    createDict_Ethics_Organizations
    createDict_Ethics_Usage
    createDict_Imaging_Datatype
    createDict_Investigator_Role
    createDict_Keywords
    createDict_Scanner_Site
    createDict_Site_Type
    createDict_Subject_Consent
    createDict_Title
    createDict_TimePoint
    createDict_Diagnosis_primary
    createDict_Clinical_assessments
    createDict_UR_Provider
}



#============================================================================#
proc destroyPSSDDicts { } {

	set dicts { MRI_sequence SI_units ethics_organization ethics_usage imaging_data_type \
		   investigator_role key_words scanner_site site_type subject_consent title time_point \
		   Clinical_Assessments Diagnosis_Primary UR_provider }
	foreach dict $dicts {
		if { [xvalue exists [dictionary.exists :name $dict]] == "true" } {
			dictionary.destroy :name $dict
		}
	}
}

