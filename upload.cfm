<!---
<fusedoc fuse="upload.cfm" language="ColdFusion" specification="2.0">
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

<html>
	<head>
		<title>Validation.cfc Upload Example</title>
		<style>
			.redtext {
				color: red;
			}
		</style>
	</head>
	<body>
		<h1>Upload Example</h1>

		<!--- Since We're Doing a Postback --->
		<cfif isDefined("form.fieldnames")>
			<cfscript>
				stcDirectories = structNew();
				stcDirectories.Document = "#expandPath("./")#";
				stcDirectories.Image = "#expandPath("./")#";
				objValidation = createObject("component","com.Validation").init();
				objValidation.setFields(form);
				objValidation.setDirectories(stcDirectories);
				objValidation.validate();
			</cfscript>

			<cfif objValidation.getErrorCount() is 0>
				<h2>No errors!</h2>
				<cfdump var="#objValidation.getFiles()#" />
			<cfelse>
				<h2>There were errors in your submission:</h2>
				<ul>
					<cfloop collection="#variables.objValidation.getMessages()#" item="rr">
						<li><cfoutput>#variables.objValidation.getMessage(rr)#"</cfoutput></li>
					</cfloop>
				</ul>
			</cfif>
		</cfif>

		<cfoutput>
		<form action="upload.cfm" method="post" enctype="multipart/form-data">

			<p>Document: (Word, Excel, Powerpoint, or PDF) <br />
			<input type="file" name="Document" /></p>

			<p>Image: (JPEG, GIF, or PNG Image)<br />
			<input type="file" name="Image" /></p>

			<input name="validate_file" type="hidden" value="Document|doc,xls,ppt,pdf|'Document' must be Word, Excel, PowerPoint, or PDF.;Image|jpg,gif,png|'Image' must be JPEG, GIF, or PNG." />

			<input type="submit" value="Submit" />

		</form>
		</cfoutput>
	</body>
</html>