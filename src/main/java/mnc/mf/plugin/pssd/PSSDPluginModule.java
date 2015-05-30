package mnc.mf.plugin.pssd;

import java.util.Collection;
import java.util.Vector;

import mnc.mf.plugin.pssd.services.*;


import arc.mf.plugin.ConfigurationResolver;
import arc.mf.plugin.PluginModule;
import arc.mf.plugin.PluginService;

public class PSSDPluginModule implements PluginModule {

	private Collection<PluginService> _services = null;

	public String description() {

		return "MNC PSSD Plugin Module.";
	}

	@Override
	public void initialize(ConfigurationResolver config) throws Throwable {

		_services = new Vector<PluginService>();
		_services.add(new SvcObjectMetaSet());
		_services.add(new SvcRNCreate());
		_services.add(new SvcSubjectRNSet());
		
		// One shot migration services now done
		//_services.add(new SvcProjectMetaMigrate());
		//_services.add(new SvcEthicsMetaMigrate());
		
		// Other useful services
		_services.add(new SvcSubjectDiagnosisUpdate());
		_services.add(new SvcStudyScanGrab());

	}

	protected void registerSystemEvents() throws Throwable {

	}

	public boolean isCompatible(ConfigurationResolver config) throws Throwable {

		return false;
	}

	public void shutdown(ConfigurationResolver config) throws Throwable {

	
	}

	protected void unregisterSystemEvents() throws Throwable {

	
	}

	public String vendor() {

		return "Melbourne Neuropsychiatry Centre, the University of Melbourne.";
	}

	public String version() {

		return "1.0";
	}

	public Collection<PluginService> services() {

		return _services;
	}

}