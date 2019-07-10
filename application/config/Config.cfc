component extends="preside.system.config.Config" {

	public void function configure() {
		super.configure();

		settings.preside_admin_path  = "${admin_path}";
		settings.system_users        = "sysadmin";
		settings.default_locale      = "en";

		settings.default_log_name    = "${site_id}";
		settings.default_log_level   = "information";
		settings.sql_log_name        = "${site_id}";
		settings.sql_log_level       = "information";

		settings.ckeditor.defaults.stylesheets.append( "css-bootstrap" );
		settings.ckeditor.defaults.stylesheets.append( "css-layout" );

		settings.features.websiteUsers.enabled = true;
		settings.features.websiteBenefits.enabled = true;


		settings.assetmanager.derivatives.toombaGalleryImage = {
			  permissions = "inherit"
			, transformations = [{
				  method="shrinkToFit"
				  , args={ width=150, height=150, useCropHint=true }
			  }]
			, useCropHint=true
			, inEditor = true
		};
	}

	public void function local() {
		super.local( argumentCollection=arguments );
	}
}
