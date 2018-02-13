<?xml version="1.0" encoding="UTF-8"?>
<!--=============================================================
    File: Banner.xslt                                                   
    Created by: sitecore\admin                                       
    Created: 24-03-2010 11:19:55                                               
    Copyright notice at bottom of file
==============================================================-->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:sc="http://www.sitecore.net/sc"
  xmlns:dot="http://www.sitecore.net/dot"  
  xmlns:ljungbergit="http://www.sitecore.net/ljungbergit"
  exclude-result-prefixes="dot sc ljungbergit">
  <!-- output directives -->
  <xsl:output method="html" indent="no" encoding="UTF-8" />
  <!-- parameters -->
  <xsl:param name="lang" select="'en'"/>
  <xsl:param name="id" select="''"/>
  <xsl:param name="sc_item"/>
  <xsl:param name="sc_currentitem"/>

  <!-- variables -->
  <xsl:variable name="home" select="$sc_currentitem/ancestor-or-self::item[@template='homepage']" />
  <!-- entry point -->
  <xsl:template match="*">
    <xsl:apply-templates select="$sc_item" mode="main"/>
  </xsl:template>
  <!--==============================================================-->
  <!-- main                                                         -->
  <!--==============================================================-->
  <xsl:template match="*" mode="main">
    <xsl:if test="sc:item('/sitecore/system/Languages',.)/item[2]">
      <div id="header-toolbox">

       
      </div>
    </xsl:if>
    <xsl:variable name="servicelinkspath" select="sc:fld('ServiceLinks', $home)"/>
    <div id="servicenavigation">
      <ul class="hnav">
       
       
        <xsl:variable name="ids" select="concat($servicelinkspath, '|')"/>
        <xsl:call-template name="PrintTitles">
          <xsl:with-param name="ids" select="$ids"/>
        </xsl:call-template>
       <xsl:for-each select="sc:item('/sitecore/system/Languages',.)/item">
          <li>
          <!-- LjungbergIt Added Start -->
            <a href="{ljungbergit:ReturnUrl(./@name)}?sc_lang={./@name}">
            <!-- LjungbergIt Added End -->
            <!-- LjungbergIt Removed Start -->
            <!-- <a href="/?sc_lang={./@name}"> -->
            <!-- LjungbergIt Removed End -->
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

          </li>
          <xsl:if test="position() != last()">
            <li class="servicenavigation-divider">/</li>
          </xsl:if>
        </xsl:for-each>
      </ul>
      <fieldset id="searchfield">
        <input type="text" class="search-field" />
        <span class="search-button">
          <button>
            <xsl:value-of select="sc:fld('ServiceSearchText', $home)"/>
          </button>
        </span>
        <script type="text/javascript">
          <![CDATA[
		
                /*
                $j(function(){
                    $j("#searchfield .search-button button").click(function(e){var q = $j('#searchfield .search-field').val();var p = "/services/search.aspx?searchk=";window.location.href = p + q;e.preventDefault();});
                    $j("#searchfield input").keyup(function(e){if (e.keyCode == 13) {e.preventDefault();$j("#searchfield button").click();}}).focus(function(){$j(this).addClass("current");}).blur(function(){if($j(this).val() == ''){$j(this).removeClass("current")};});                
                });
                */
                
                
                $j(function(){
                    $j("#searchfield button").click(function(e){
                        var q = $j(this).parents('fieldset').find('input[type="text"]').val();
                        var p = "/services/search.aspx?searchk=";
                        window.location.href = p + q;e.preventDefault();
                    });
                    $j("#searchfield input").keydown(function(e){
                      if (e.keyCode == 13) {
                      e.preventDefault();
                        $j("#searchfield button").click();
                      }
                      }).focus(function(){$j(this).addClass("current");
                      }).blur(function(){
                          if($j(this).val() == ''){
                            $j(this).removeClass("current")
                          };
                      });                
                });


		      ]]>
        </script>
      </fieldset>
      
      <!--<a href="https://web.chashude.dk/Web/homepage.nsf?Open" title="Log-in" target="_blank" class="login-button">
        <img src="/Valtech/StandardTemplates/files/images/login-butt.png" alt="Log-in"></img>
      </a>-->
<a href="https://chipp.chashude.com" title="Log-in" target="_blank" class="login-button">
        <img src="/Valtech/StandardTemplates/files/images/login-butt.png" alt="Log-in"></img>
      </a>
    </div>
   
  </xsl:template>

  <xsl:template name="PrintTitles">
    <xsl:param name="ids"/>
    <xsl:if test="$ids">
      <xsl:variable name="itm_id" select="substring-before($ids, '|')"/>
      <xsl:if test="$itm_id">
        <xsl:variable name="itm" select="sc:item($itm_id, .)"/>
        <li>
          <xsl:choose>
            <xsl:when test="$itm/@id=$sc_currentitem/@id">
              <xsl:call-template name="writeLink">
                <xsl:with-param name="classValue" select="'selected current'" />
                <xsl:with-param name="currentItem" select="$itm" />
              </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
              <xsl:call-template name="writeLink">
                <xsl:with-param name="classValue" select="''" />
                <xsl:with-param name="currentItem" select="$itm" />
              </xsl:call-template>
            </xsl:otherwise>
          </xsl:choose>
        </li>

       <!-- <xsl:if test="substring-after($ids, '|')">
          <li class="servicenavigation-divider">/</li>
        </xsl:if>-->
      </xsl:if>

      <xsl:call-template name="PrintTitles">
        <xsl:with-param name="ids" select="substring-after($ids, '|')"/>
      </xsl:call-template>
    </xsl:if>

  </xsl:template>

  <xsl:template name="writeLink">
    <xsl:param name="classValue" />
    <xsl:param name="currentItem" />
    <xsl:choose>
      <xsl:when test="sc:fld('menulink', $currentItem) != ''">
        <sc:link field="menulink" select="." class="{$classValue}">
          <xsl:choose>
            <xsl:when test="sc:fld('menutext', $currentItem) != ''">
              <sc:text field="menutext" select="$currentItem" />
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="@name" />
            </xsl:otherwise>
          </xsl:choose>
        </sc:link>
      </xsl:when>
      <xsl:otherwise>
        <sc:link select="$currentItem" class="{$classValue}">
          <xsl:choose>
            <xsl:when test="sc:fld('menutext', $currentItem) != ''">
              <sc:text field="menutext" select="$currentItem" />
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="@name" />
            </xsl:otherwise>
          </xsl:choose>
        </sc:link>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>