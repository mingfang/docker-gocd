<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:cruise="http://studios.thoughtworks.com/ontologies/2009/12/07-cruise#" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:java="http://xml.apache.org/xalan/java" version="1.0">
	<xsl:output method="xml" encoding="utf-8" omit-xml-declaration="yes" indent="yes"/>

	<!-- / -->
	<xsl:template match="/">
		<rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:cruise="http://studios.thoughtworks.com/ontologies/2009/12/07-cruise#">
            <xsl:apply-templates/>
		</rdf:RDF>
	</xsl:template>

	<!-- /job -->
	<xsl:template match="job">
        <cruise:Job>
            <xsl:attribute name="rdf:about">
                <xsl:value-of select="link[@rel='self']/@href"/>
            </xsl:attribute>

            <cruise:jobName rdf:datatype="http://www.w3.org/2001/XMLSchema#string">
                <xsl:value-of select="@name"/>
            </cruise:jobName>

            <xsl:apply-templates/>
        </cruise:Job>
	</xsl:template>

  <!-- /job/result -->
  <xsl:template match="result">
    <xsl:choose>
      <xsl:when test=". = 'Passed'">
        <cruise:jobResult>
          <cruise:PassedResult />
        </cruise:jobResult>
      </xsl:when>
      <xsl:when test=". = 'Failed'">
        <cruise:jobResult>
          <cruise:FailedResult />
        </cruise:jobResult>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

	<!-- /job/properties -->
	<xsl:template match="properties">
    <!-- Do Nothing -->
	</xsl:template>

  <!-- /job/artifacts -->
	<xsl:template match="artifacts">
		<cruise:hasArtifacts>
			<cruise:Artifacts>
        <xsl:attribute name="rdf:about">
          <xsl:value-of select="java:com.thoughtworks.studios.shine.semweb.UUIDURIGenerator.nextType4()"/>
        </xsl:attribute>                
				<cruise:artifactsBaseURL rdf:datatype="http://www.w3.org/2001/XMLSchema#string">
					<xsl:value-of select="@baseUri"/>
				</cruise:artifactsBaseURL>

				<cruise:pathFromArtifactRoot rdf:datatype="http://www.w3.org/2001/XMLSchema#string">
					<xsl:value-of select="@pathFromArtifactRoot"/>
				</cruise:pathFromArtifactRoot>

				<xsl:apply-templates/>
			</cruise:Artifacts>
		</cruise:hasArtifacts>
	</xsl:template>

    <!-- /job/artifacts/artifact -->
	<xsl:template match="artifact">
		<cruise:hasArtifact>
			<cruise:Artifact>
        <xsl:attribute name="rdf:about">
          <xsl:value-of select="java:com.thoughtworks.studios.shine.semweb.UUIDURIGenerator.nextType4()"/>
        </xsl:attribute>

        <cruise:artifactPath rdf:datatype="http://www.w3.org/2001/XMLSchema#string">
            <xsl:value-of select="@dest"/>
        </cruise:artifactPath>
        <cruise:artifactType rdf:datatype="http://www.w3.org/2001/XMLSchema#string">
            <xsl:value-of select="@type"/>
        </cruise:artifactType>
			</cruise:Artifact>
		</cruise:hasArtifact>
	</xsl:template>

  <xsl:template match="environmentvariables">
  </xsl:template>

  <xsl:template match="resources">
  </xsl:template>



</xsl:stylesheet>
