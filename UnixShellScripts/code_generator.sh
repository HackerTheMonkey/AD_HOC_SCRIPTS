# To generate Parser mapping code
for parser in $(echo "AcceptEncodingParser AcceptLanguageParser AcceptParser AddressParametersParser AddressParser AlertInfoParser AllowEventsParser AllowParser AttributeFieldParser AuthenticationInfoParser AuthorizationParser BandwidthFieldParser CallIDParser CallInfoParser ChallengeParser ConnectionFieldParser ContactParser ContentDispositionParser ContentEncodingParser ContentLanguageParser ContentLengthParser ContentTypeParser CSeqParser DateParser EmailFieldParser ErrorInfoParser EventParser ExpiresParser FromParser HeaderParser InformationFieldParser InReplyToParser JoinParser KeyFieldParser MaxForwardsParser MediaFieldParser MessageParser MessageParserFactory MimeVersionParser MinExpiresParser MinSEParser OrganizationParser OriginFieldParser PAccessNetworkInfoParser ParametersParser Parser ParserFactory ParserFactory PAssertedIdentityParser PAssertedServiceParser PAssociatedURIParser PathParser PCalledPartyIDParser PChargingFunctionAddressesParser PChargingVectorParser PhoneFieldParser PipelinedMsgParser PMediaAuthorizationParser PPreferredIdentityParser PPreferredServiceParser PProfileKeyParser PriorityParser PrivacyParser ProtoVersionFieldParser ProxyAuthenticateParser ProxyAuthorizationParser ProxyRequireParser PServedUserParser PUserDatabaseParser PVisitedNetworkIDParser RAckParser ReasonParser RecordRouteParser ReferencesParser ReferredByParser ReferToParser RepeatFieldParser ReplacesParser ReplyToParser RequestLineParser RequireParser RetryAfterParser RouteParser RSeqParser SDPAnnounceParser SDPParser SecurityAgreeParser SecurityClientParser SecurityServerParser SecurityVerifyParser ServerParser ServiceRouteParser SessionExpiresParser SessionNameFieldParser SIPETagParser SIPIfMatchParser StatusLineParser StringMsgParser StringMsgParserFactory SubjectParser SubscriptionStateParser SupportedParser TimeFieldParser TimeStampParser ToParser UnsupportedParser URIFieldParser URLParser UserAgentParser ViaParser WarningParser WWWAuthenticateParser ZoneFieldParser")
do
	varname="$(echo ${parser} | cut -c1 | tr '[A-Z]' '[a-z]')$(echo ${parser} | cut -c2-)"
	echo '/**'
  echo "* ${parser}"
  echo '*/'
  echo "${parser} ${varname} = new ${parser}(headerFieldTextContent);"
  echo "headerParsersDb.put(\"${parser}\", ${varname});"
done > code_generator_output.txt

----------------------------------------------------------------------------------------------------------
# To generate header wsdl mapping
for headerField in $(echo "Accept Accept-Encoding Accept-Language Alert-Info Allow Authentication-Info Authorization Call-ID Call-Info Contact Content-Disposition Content-Encoding Content-Language Content-Length Content-Type CSeq Date Error-Info Expires From In-Reply-To Max-Forwards Min-Expires MIME-Version Organization Priority Proxy-Authenticate Proxy-Authorization Proxy-Require Record-Route Reply-To Require Retry-After Route Server Subject Supported Timestamp To Unsupported User-Agent Via Warning WWW-Authenticate")
do
	headerFieldElementName=$(echo ${headerField}|sed 's/-//g')
	echo "<part name=\"${headerField}\" element=\"tns:${headerFieldElementName}HeaderFieldElement\"/>"
done

----------------------------------------------------------------------------------------------------------
# To generate header wsdl mapping
for headerField in $(echo "Accept Accept-Encoding Accept-Language Alert-Info Allow Authentication-Info Authorization Call-ID Call-Info Contact Content-Disposition Content-Encoding Content-Language Content-Length Content-Type CSeq Date Error-Info Expires From In-Reply-To Max-Forwards Min-Expires MIME-Version Organization Priority Proxy-Authenticate Proxy-Authorization Proxy-Require Record-Route Reply-To Require Retry-After Route Server Subject Supported Timestamp To Unsupported User-Agent Via Warning WWW-Authenticate")
do
	headerFieldElementName=$(echo ${headerField}|sed 's/-//g')"HeaderFieldElement"
	echo "<xsd:element name=\"${headerFieldElementName}\">"
  echo "  <xsd:simpleType>"                
  echo "    <xsd:restriction base=\"xsd:string\"/>"                    
  echo "  </xsd:simpleType>"
  echo "</xsd:element>"               
done