/**
********************************************************************************
Copyright 2005-2007 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.ortussolutions.com
********************************************************************************
*/
component{

	// APPLICATION CFC PROPERTIES
	this.name 				= "ColdBoxTestingSuite" & hash(getCurrentTemplatePath());
	this.sessionManagement 	= true;
	this.sessionTimeout 	= createTimeSpan( 0, 0, 15, 0 );
	this.applicationTimeout = createTimeSpan( 0, 0, 15, 0 );
	this.setClientCookies 	= true;

	// Create testing mapping
	this.mappings[ "/tests" ] = getDirectoryFromPath( getCurrentTemplatePath() );
	// Map back to its root
	rootPath = REReplaceNoCase( this.mappings[ "/tests" ], "tests(\\|/)", "" );
	this.mappings["/root"]   = rootPath;

	this.mappings[ "/cborm" ] = rootPath & "modules/cborm";

	this.ormEnabled = true;
	this.datasource = "app";
	this.ormSettings = {
		// Location of your entities, default is your convention model folder
	    cfclocation = ["models"],
	    // Choose if you want ORM to create the database for you or not?
	    dbcreate = "update",
    	dialect = "MySQLwithInnoDB",
	    // Log SQL or not
	    logSQL         = true,
	    // Don't flush at end of requests, let Active Entity manage it for you
	    flushAtRequestEnd = false,
	    // Don't manage session, let Active Entity manage it for you
	    autoManageSession = false,
	    // Active ORM events
	    eventHandling       =  true,
	    // Use the ColdBox WireBox Handler for events
	    eventHandler = "cborm.models.EventHandler"
	};


}