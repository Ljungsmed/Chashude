<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:sc="http://www.sitecore.net/sc"
   exclude-result-prefixes="sc">

   <!-- output directives -->
   <xsl:output method="html" indent="no" encoding="UTF-8" />

   <!-- parameters -->
   <xsl:param name="lang" select="'en'"/>
   <xsl:param name="id" select="''"/>
   <xsl:param name="sc_item"/>
   <xsl:param name="sc_currentitem"/>
   <!--List of allowed/forbidden template ids-->
   <xsl:param name="templates" select="concat('|', '{9C73C109-F6D0-44B0-A3D2-E77E6C5C2162}', '|', '{62E9A5B6-42FF-4001-AAF5-D523444774EC}', '|', '{40992A3A-1D93-4B0B-A33A-DD2D451C21B8}')"/>
   <xsl:param name="SMClass" select="'sitemap'" />
   <xsl:param name="SMStyle" select="''"/>
   <xsl:param name="SMTitleClass" select="''" />
   <xsl:param name="SMTitleStyle" select="''" />
   <xsl:param name="SMTextClass" select="''"/>
   <xsl:param name="SMTextStyle" select="''" />
   <xsl:param name="SMTopLevelTextStyle" select="''" />
   <xsl:param name="SMTopLevelTextClass" select="''" />
   <xsl:param name="SMTitleField" select="'Title'" />
   <xsl:param name="DividerClass" select="''" />
   <xsl:param name="DividerStyle" select="''" />
   <xsl:param name="VerticalDividerImage" select="'/valtech/standardtemplates/files/images/smvertical.gif'" />
   <xsl:param name="BottomDividerImage" select="'/valtech/standardtemplates/files/images/smbottom.gif'" />
   <xsl:param name="ItemDividerImage" select="'/valtech/standardtemplates/files/images/smitem.gif'" />

   <!-- variables -->
   <xsl:variable name="home" select="$sc_item/ancestor-or-self::item[@template='homepage']" />

   <!-- entry point -->
   <xsl:template match="*">
      <xsl:apply-templates select="$sc_item" mode="main"/>
   </xsl:template>


   <!--==============================================================-->
   <!-- main                                                         -->
   <!--==============================================================-->
   <xsl:template match="*">

      <div class="{$SMClass} spot" style="{$SMStyle}">
         <!--Do not show home page link-->
         <!--<xsl:for-each select="$home/item[@template!='folder']">-->
         <xsl:for-each select="$home[contains($templates,@tid)]">
             <xsl:sort select="@sortorder" data-type="number"/>
             <xsl:call-template name="sitemap">
               <xsl:with-param name="level" select="'0'" />
               <xsl:with-param name="position" select="position()" />
             </xsl:call-template>
         </xsl:for-each>
      </div>

   </xsl:template>


   <!--***************************************-->
   <!--              Sitemap                  -->
   <!--***************************************-->
   <xsl:template name="sitemap">
      <xsl:param name="totItems" />
      <xsl:param name="level" />
      <xsl:param name="lastElemLevels"/>

      <xsl:variable name="itemsCount" select="count(item[contains($templates,@tid)])" />
      <xsl:variable name="itemsFollowing" select="count(./following-sibling::item[contains($templates,@tid)])" />

      <xsl:variable name="lastElemLevel">
         <xsl:choose>
            <xsl:when test="$itemsFollowing=0 and $itemsCount!=0">
               <xsl:value-of select="concat($lastElemLevels, ',',$level, ',')"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="$lastElemLevels"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>

      <table cellpadding="0" cellspacing="0" border="0">
         <tr>
            <xsl:call-template name="for">
               <xsl:with-param name="n" select="$level"/>
               <xsl:with-param name="lastElemLevels" select="$lastElemLevel"/>
            </xsl:call-template>

            <xsl:if test="$level!=0">
               <xsl:call-template name="DividerTemplate" >
                  <xsl:with-param name="position" select="position()" />
                  <xsl:with-param name="totItems" select="$totItems" />
               </xsl:call-template>
            </xsl:if>

            <td valign="top">
               <xsl:choose>
                  <xsl:when test="$level=0">
                     <xsl:attribute name="class">
                        <xsl:value-of select="$SMTopLevelTextClass" />
                     </xsl:attribute>
                     <xsl:attribute name="style">
                        <xsl:value-of select="$SMTopLevelTextStyle" />
                     </xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:attribute name="class">
                        <xsl:value-of select="$SMTextClass" />
                     </xsl:attribute>
                     <xsl:attribute name="style">
                        <xsl:value-of select="$SMTextStyle" />
                     </xsl:attribute>
                  </xsl:otherwise>
               </xsl:choose>
               <xsl:variable name="title" select="sc:fld('MenuText',.)" />
               <a href="{sc:path(.)}" class="{$SMClass}">
                  <xsl:choose>
                     <xsl:when test="$title">
                        <xsl:value-of select="$title"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:value-of select="./@name"/>
                     </xsl:otherwise>
                  </xsl:choose>
               </a>
            </td>
         </tr>
      </table>
      
      <xsl:if test="$itemsCount>0">
         <xsl:for-each select="item[contains($templates,@tid)]">
            <xsl:call-template name="sitemap">
               <xsl:with-param name="totItems" select="$itemsCount" />
               <xsl:with-param name="level" select="$level+1" />
               <xsl:with-param name="lastElemLevels" select="$lastElemLevel" />
            </xsl:call-template>
         </xsl:for-each>
      </xsl:if>

   </xsl:template>


   <!--***************************************-->
   <!--              Devider template         -->
   <!--***************************************-->
   <xsl:template name="DividerTemplate">
      <xsl:param name="position"/>
      <xsl:param name="totItems" />

      <td valign="top"  align="right">
         <xsl:choose>
            <xsl:when test="($position=1 and $position=$totItems) or $position=$totItems">
               <xsl:call-template name="Divider">
                  <xsl:with-param name="DividerImage" select="$BottomDividerImage"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
               <xsl:call-template name="Divider">
                  <xsl:with-param name="DividerImage" select="$ItemDividerImage"/>
               </xsl:call-template>
            </xsl:otherwise>
         </xsl:choose>
      </td>
      
   </xsl:template>

   <!--***************************************-->
   <!--              For                      -->
   <!--***************************************-->
   <xsl:template name="for">
      <xsl:param name="i" select="1"/>
      <xsl:param name="n"/>
      <xsl:param name="lastElemLevels"/>
      
      <xsl:if test="$i &lt; $n">
         <!--<xsl:value-of select="$lastElemLevels"/>
         <br/>
         <xsl:value-of select="$i"/>-->
         <td style="width:25px">
            <xsl:if test="not(contains($lastElemLevels,concat(',',$i,',')))">
               <xsl:call-template name="Divider">
                  <xsl:with-param name="DividerImage" select="$VerticalDividerImage"/>
               </xsl:call-template>
            </xsl:if>
         </td>
         <xsl:call-template name="for">
            <xsl:with-param name="i" select="$i + 1"/>
            <xsl:with-param name="n" select="$n"/>
            <xsl:with-param name="lastElemLevels" select="$lastElemLevels"/>
         </xsl:call-template>
      </xsl:if>
      
   </xsl:template>

   <!--***************************************-->
   <!--              Divider                  -->
   <!--***************************************-->
   <xsl:template name="Divider">
      <xsl:param name="DividerImage" select="''"/>

      <img class="{$DividerClass}" style="{$DividerStyle}" alt="|" src="{$DividerImage}"/>

   </xsl:template>
   
</xsl:stylesheet>


<!--

Sitecore Shared Source License

This License governs use of the accompanying Software, and your use of the Software 
constitutes acceptance of this license. 

Subject to the restrictions in this license, you may use this Software for any commercial or 
non-commercial purpose in Sitecore solutions only. You may also distribute this Software with 
books or other teaching materials, or publish the Software on websites, that are intended to 
teach the use of the Software in relation to Sitecore. 

You may not use or distribute this Software or any derivative works in any form for uses other 
than with Sitecore. 

You may modify this Software and distribute the modified Software as long as it relates to 
Sitecore, however, you may not grant rights to the Software or derivative works that are 
broader than those provided by this License. For example, you may not distribute modifications 
of the Software under terms that would permit uses not relating to Sitecore, or under terms 
that purport to require the Software or derivative works to be sublicensed to others. 

You may use any information in intangible form that you remember after accessing the Software. 
However, this right does not grant you a license to any of Sitecore's copyrights or patents 
for anything you might create using such information. 

In return, we simply require that you agree: 

1.	Not to remove any copyright or other notices from the Software.

2.	That if you distribute the Software in source or object form, you will include a verbatim 
    copy of this license. 
    
3.	That if you distribute derivative works of the Software in source code form you do so only 
    under a license that includes all of the provisions of this License, and if you distribute 
    derivative works of the Software solely in object form you do so only under a license that 
    complies with this License. 
    
4.	That if you have modified the Software or created derivative works, and distribute such 
    modifications or derivative works, you will cause the modified files to carry prominent 
    notices so that recipients know that they are not receiving the original Software. Such 
    notices must state: (i) that you have changed the Software; and (ii) the date of any changes. 
    
5.	THAT THE SOFTWARE COMES "AS IS", WITH NO WARRANTIES. THIS MEANS NO EXPRESS, IMPLIED OR 
    STATUTORY WARRANTY, INCLUDING WITHOUT LIMITATION, WARRANTIES OF MERCHANTABILITY OR FITNESS 
    FOR A PARTICULAR PURPOSE OR ANY WARRANTY OF TITLE OR NON-INFRINGEMENT. ALSO, YOU MUST PASS 
    THIS DISCLAIMER ON WHENEVER YOU DISTRIBUTE THE SOFTWARE OR DERIVATIVE WORKS. 
    
6.	THAT SITECORE WILL NOT BE LIABLE FOR ANY DAMAGES RELATED TO THE SOFTWARE OR THIS LICENSE, 
    INCLUDING DIRECT, INDIRECT, SPECIAL, CONSEQUENTIAL OR INCIDENTAL DAMAGES, TO THE MAXIMUM 
    EXTENT THE LAW PERMITS, NO MATTER WHAT LEGAL THEORY IT IS BASED ON. ALSO, YOU MUST PASS 
    THIS LIMITATION OF LIABILITY ON WHENEVER YOU DISTRIBUTE THE SOFTWARE OR DERIVATIVE WORKS. 
    
7.	That if you sue anyone over patents that you think may apply to the Software or anyone's 
    use of the Software, your license to the Software ends automatically. 
    
8.	That your rights under the License end automatically if you breach it in any way. 

9.	Sitecore reserves all rights not expressly granted to you in this license. 

-->