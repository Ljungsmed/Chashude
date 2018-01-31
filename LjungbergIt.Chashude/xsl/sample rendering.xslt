<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:sc="http://www.sitecore.net/sc"
  xmlns:ljungbergit="http://www.sitecore.net/ljungbergit"
  xmlns:sql="http://www.sitecore.net/sql"
  exclude-result-prefixes="sc sql">

  <!-- output directives -->
  <xsl:output method="html" indent="no" encoding="UTF-8"  />

  <!-- sitecore parameters -->
  <xsl:param name="lang" select="'en'"/>
  <xsl:param name="id" select="''"/>
  <xsl:param name="sc_item"/>
  <xsl:param name="sc_currentitem"/>

  <!-- entry point -->
  <xsl:template match="*">

    <div>
      <xsl:for-each select="sc:item('/sitecore/system/Languages',.)/item">
        <li>
          <!-- LjungbergIt Added Start -->
          <a href="{ljungbergit:ReturnUrl(./@name)}?sc_lang={./@name}">
            <!-- LjungbergIt Added End -->
            <xsl:if test="$lang = sc:fld('@name',.)">
              <xsl:attribute name="class">selected</xsl:attribute>
            </xsl:if>
            <xsl:choose>
              <xsl:when test="sc:fld('__display name',.)!=''">
                <xsl:value-of select="sc:fld('__display name',.)" />
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="sc:fld('@name',.)" />
              </xsl:otherwise>
            </xsl:choose>
          </a>
          <xsl:value-of select="ljungbergit:ReturnUrl(./@name)" />
        </li>
        <xsl:if test="position() != last()">
          <li class="servicenavigation-divider">/</li>
        </xsl:if>
      </xsl:for-each>
      <h1>
        <sc:text field="title"/>
      </h1>
      <div>
        <sc:text field="text" />
      </div>
    </div>
  </xsl:template>

</xsl:stylesheet>
