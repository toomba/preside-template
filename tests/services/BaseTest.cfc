component extends="testbox.system.compat.framework.TestCase" appMapping="/"{


	function matchStructures(required struct modelStruct, required struct matchStruct){

		expect(	modelStruct ).toBeTypeOf('struct');

		for(local.key in matchStruct){
			if(!isNull(modelStruct[key]) && local.key != "password"){
				expect(	modelStruct ).toHaveKey(local.key);
				expect( modelStruct[key] ).toBe(matchStruct[key]);
			}
		}
	}

	function newEventArgs( method = "GET" ) {
        //rebuild the context
        setup();
        //mock the context
        var event = getRequestContext();
        prepareMock( event ).$( "getHTTPMethod", arguments.method );
        var rc = event.getCollection();
        var prc = event.getCollection( private=true );
        prc['unitTestApiKey'] = 'T00mb44cc3ss2018';
        //prc.response = getWirebox().getInstance( "APIResponse" );

        return {
            "event":event,
            "rc":rc,
            "prc":prc
        };
	}

    function testCreateUser() {

        var testWidget = { "first_name"= "test",
                             "last_name"= "lasttest",
                             "email" = "te123st@email.com",
                             "password" = "Thepassword" };

        var eventArguments = this.newEventArgs( "POST" );

        structAppend( eventArguments.rc, testWidget, true );

        var user = execute(
            route = "api/user",
            eventArguments = eventArguments
        );
        var response = user.getPrivateValue( "response" );
        expect( response.getError() ).toBeFalse();
        this.localUser = response.getData();
        this.matchStructures(this.localUser, testWidget);

    }

    function testDeleteUser() {
        var eventArguments = this.newEventArgs( "DELETE" );
        var user = execute(
            route = "api/user/" & this.localUser["id"]
        );

        var response = user.getPrivateValue( "response" );
        expect( response.getError() ).toBeFalse();
        expect( response.getData() ).toBe("object deleted");
    }

    function testCreateCustomer() {

        var testWidget = { "name" : "testcustomer", "reeleezee_customer_id" :  9999999};

        var eventArguments = this.newEventArgs( "POST" );

        structAppend( eventArguments.rc, testWidget, true );

        var customer = execute(
            route = "api/customer",
            eventArguments = eventArguments
        );
        var response = customer.getPrivateValue( "response" );
        expect( response.getError() ).toBeFalse();
        this.localCustomer = response.getData();
        this.matchStructures(this.localCustomer, testWidget);

    }

    function testDeleteCustomer() {
        var eventArguments = this.newEventArgs( "DELETE" );
        var customer = execute(
            route = "api/customer/" & this.localCustomer["id"]
        );

        var response = customer.getPrivateValue( "response" );
        expect( response.getError() ).toBeFalse();
        expect( response.getData() ).toBe("object deleted");
    }

}