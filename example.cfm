<!---
<fusedoc fuse="example.cfm" language="ColdFusion" specification="2.0">
	<responsibilities>
		I am an example of Validation.cfc form validation.
	</responsibilities>
	<properties>
		<history
			author="Ryan J. Heldt"
			email="rheldt@ryanheldt.com"
			date="2008-10-08"
			type="modify" role="architect"
			comments="" />
		<property name="copyright" value="Copyright 2008 Ryan J. Heldt. All rights reserved." />
	</properties>
</fusedoc>
--->

<cfparam name="form.Name" default="" />
<cfparam name="form.Email" default="" />
<cfparam name="form.WebSite" default="" />
<cfparam name="form.Age" default="" />
<cfparam name="form.Password" default="" />
<cfparam name="form.Password2" default="" />

<html>
	<head>
		<title>Validation.cfc Example</title>
		<style>
			.redtext {
				color: red;
			}
		</style>
	</head>
	<body>
		<h1>Validation.cfc Example</h1>

		<!--- Since We're Doing a Postback --->
		<cfif isDefined("form.fieldnames")>
			<cfscript>
				objValidation = createObject("component","com.Validation").init();
				objValidation.setFields(form);
				objValidation.validate();
			</cfscript>

			<cfif objValidation.getErrorCount() is 0>
				<h2>No errors!</h2>
			<cfelse>
				<h2>There were <cfoutput>#objValidation.getErrorCount()#</cfoutput> errors in your submission:</h2>
				<ul>
					<cfloop collection="#variables.objValidation.getMessages()#" item="rr">
						<li><cfoutput>#variables.objValidation.getMessage(rr)#"</cfoutput></li>
					</cfloop>
				</ul>
			</cfif>
		</cfif>

		<cfoutput>
		<form action="example.cfm" method="post">

			<p>Name: <span class="redtext">*</span><br />
			<input type="text" name="Name" value="#form.Name#" /></p>

			<p>E-mail Address: <span class="redtext">*</span><br />
			<input type="text" name="Email" value="#form.Email#" /></p>

			<p>Web Site:<br />
			<input type="text" name="WebSite" value="#form.WebSite#" /></p>

			<p>Your Age:<br />
			<input type="text" name="Age" value="#form.Age#" /></p>

			<p>Password: <span class="redtext">*</span><br />
			<input type="Password" name="Password" value="#form.Password#" /></p>

			<p>Confirm Password: <span class="redtext">*</span><br />
			<input type="Password" name="Password2" value="#form.Password2#" /></p>

			<input name="validate_require" type="hidden" value="Name|'Name' is a required field.;Email|'E-mail Address' is a required field.;Password|'Password' is a required field.;Password2|'Confirm Password' is a required field." />
			<input name="validate_password" type="hidden" value="Password|Password2|'Password' and 'Confirm Password' must both match." />
			<input name="validate_email" type="hidden" value="Email|'E-mail Address' must be a valid e-mail address." />
			<input name="validate_url" type="hidden" value="WebSite|'Web Site' must be a valid web site address." />
			<input name="validate_numeric" type="hidden" value="Age|'Age' must be a number." />

			<input type="submit" value="Submit" />

		</form>
		</cfoutput>
	</body>
</html>