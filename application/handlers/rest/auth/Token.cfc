/**
 * Handler for authenticating with token authentication
 *
 */
component {

	property name="authService" inject="presideRestAuthService";

	private string function authenticate() {
		var headers    	= getHTTPRequestData().headers;
		var authHeader 	= headers.Authorization ?: "";
		var token      	= "";
		var typeAuth 	= "";

		try {
			token      	= ListLast( authHeader, " " );
			typeAuth 	= ListFirst( authHeader, " " );

			if ( !token.trim().len() ) {
				throw( type="missing.token" );
			}
			if ( typeAuth != "Basic" ) {
				throw( type="wrong.authmode" );
			}
		} catch( any e ) {
			return "";
		}

		var userId = authService.getUserIdByToken( token );
		if ( userId.len() && authService.userHasAccessToApi( userId, restRequest.getApi() ) ) {
			return userId;
		}

		return "";
	}

}