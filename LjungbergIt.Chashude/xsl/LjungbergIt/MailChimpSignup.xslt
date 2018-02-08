<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:sc="http://www.sitecore.net/sc"
  xmlns:sql="http://www.sitecore.net/sql"
  exclude-result-prefixes="sc sql">

  <!-- output directives -->
  <xsl:output method="html" indent="no" encoding="UTF-8"  />

  <!-- sitecore parameters -->
  <xsl:param name="lang" select="'en'"/>
  <xsl:param name="id" select="''"/>
  <xsl:param name="sc_item"/>
  <xsl:param name="sc_currentitem"/>

  <xsl:param name="en_heading" />
  <xsl:param name="da_heading" />
  <xsl:param name="en_indicatesrequired" />
  <xsl:param name="da_indicatesrequired" />
  <xsl:param name="en_firstname" />
  <xsl:param name="da_firstname" />
  <xsl:param name="en_lastname" />
  <xsl:param name="da_lastname" />
  <xsl:param name="en_company" />
  <xsl:param name="da_company" />
  <xsl:param name="en_email" />
  <xsl:param name="da_email" />
  <xsl:param name="en_signup" />
  <xsl:param name="da_signup" />

  <!-- entry point -->
  <xsl:template match="*">
    <!-- Begin MailChimp Signup Form -->
    <link href="//cdn-images.mailchimp.com/embedcode/classic-10_7.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
      #mc_embed_signup{background:#fff; clear:left; font:14px Helvetica,Arial,sans-serif; }
    </style>
    <div id="mc_embed_signup" style="width:200px; background: #ECBF04 url(../images/newsletterbg.gif) no-repeat left bottom; margin-bottom: 20px">
      <div id="mc_embed_signup_scroll" style="padding: 5px;">
        
          <xsl:choose>
          <xsl:when test="$lang = 'en'">
            <xsl:choose>
              <xsl:when test="$en_heading != ''">
                <h2 style="color:white">
                  <xsl:value-of select="translate($en_heading, '+', ' ')"/>
                </h2>
              </xsl:when>
              <xsl:otherwise>
                <h2 style="color:white">Subscribe to our mailing list test</h2>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="$da_heading != ''">
                <h2 style="color:white">
                  <xsl:value-of select="translate($da_heading, '+', ' ')"/>
                </h2>
              </xsl:when>
              <xsl:otherwise>
                <h2 style="color:white">Abonner på vores mailing liste</h2>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
        <div class="indicates-required">

          <xsl:choose>
            <xsl:when test="$lang = 'en'">
              <xsl:choose>
                <xsl:when test="$en_indicatesrequired != ''">
                  <span class="asterisk">*</span>
                  <xsl:value-of select="translate($en_indicatesrequired, '+', ' ')"/>
                </xsl:when>
                <xsl:otherwise>
                  <span class="asterisk">*</span> indicates required
                </xsl:otherwise>
              </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
              <xsl:choose>
                <xsl:when test="$da_indicatesrequired != ''">
                  <span class="asterisk">*</span>
                  <xsl:value-of select="translate($da_indicatesrequired, '+', ' ')"/>
                </xsl:when>
                <xsl:otherwise>
                  <span class="asterisk">*</span> betyder obligatorisk
                </xsl:otherwise>
              </xsl:choose>
            </xsl:otherwise>
          </xsl:choose>

        </div>
        <div class="mc-field-group">
          <label for="mce-EMAIL">

            <xsl:choose>
              <xsl:when test="$lang = 'en'">
                <xsl:choose>
                  <xsl:when test="$en_email != ''">
                    <xsl:value-of select="translate($en_email, '+', ' ')"/>
                    <span class="asterisk">*</span>
                  </xsl:when>
                  <xsl:otherwise>
                    Email  <span class="asterisk">*</span>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:when>
              <xsl:otherwise>
                <xsl:choose>
                  <xsl:when test="$da_email != ''">
                    <xsl:value-of select="translate($da_email, '+', ' ')"/>
                    <span class="asterisk">*</span>
                  </xsl:when>
                  <xsl:otherwise>
                    Email  <span class="asterisk">*</span>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:otherwise>
            </xsl:choose>

          </label>
          <input type="email" value="" name="EMAIL" class="required email" id="mce-EMAIL" />
        </div>
        <div class="mc-field-group">
          <label for="mce-FNAME">
            
          <xsl:choose>
              <xsl:when test="$lang = 'en'">
                <xsl:choose>
                  <xsl:when test="$en_firstname != ''">                    
                    <xsl:value-of select="translate($en_firstname, '+', ' ')"/>
                    <span class="asterisk">*</span>
                  </xsl:when>
                  <xsl:otherwise>
                    First Name  <span class="asterisk">*</span>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:when>
              <xsl:otherwise>
                <xsl:choose>
                  <xsl:when test="$da_firstname != ''">
                    <xsl:value-of select="translate($da_firstname, '+', ' ')"/>
                    <span class="asterisk">*</span>
                  </xsl:when>
                  <xsl:otherwise>
                    Fornavn  <span class="asterisk">*</span>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:otherwise>
            </xsl:choose>
          
          </label>
          <input type="text" value="" name="FNAME" class="required" id="mce-FNAME" />
        </div>
        <div class="mc-field-group">
          <label for="mce-LNAME">
            
          <xsl:choose>
              <xsl:when test="$lang = 'en'">
                <xsl:choose>
                  <xsl:when test="$en_lastname != ''">
                    <xsl:value-of select="translate($en_lastname, '+', ' ')"/>
                    <span class="asterisk">*</span>
                  </xsl:when>
                  <xsl:otherwise>
                    Last Name  <span class="asterisk">*</span>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:when>
              <xsl:otherwise>
                <xsl:choose>
                  <xsl:when test="$da_lastname != ''">
                    <xsl:value-of select="translate($da_lastname, '+', ' ')"/>
                    <span class="asterisk">*</span>
                  </xsl:when>
                  <xsl:otherwise>
                    Efternavn  <span class="asterisk">*</span>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:otherwise>
            </xsl:choose>
          
          </label>
          <input type="text" value="" name="LNAME" class="required" id="mce-LNAME" />
        </div>
        <div class="mc-field-group">
          <label for="mce-MMERGE3">
        
            <xsl:choose>
              <xsl:when test="$lang = 'en'">
                <xsl:choose>
                  <xsl:when test="$en_company != ''">
                    <xsl:value-of select="translate($en_company, '+', ' ')"/>
                    <span class="asterisk">*</span>
                  </xsl:when>
                  <xsl:otherwise>
                    Company
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:when>
              <xsl:otherwise>
                <xsl:choose>
                  <xsl:when test="$da_company != ''">
                    <xsl:value-of select="translate($da_company, '+', ' ')"/>
                    <span class="asterisk">*</span>
                  </xsl:when>
                  <xsl:otherwise>
                    Firma
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:otherwise>
            </xsl:choose>
          
        </label>
          <input type="text" value="" name="MMERGE3" class="" id="mce-MMERGE3" />
        </div>
        <div id="mce-responses" class="clear">
          <div class="response" id="mce-error-response" style="display:none"></div>
          <div class="response" id="mce-success-response" style="display:none"></div>
        </div>
        <!-- real people should not fill this in and expect good things - do not remove this or risk form bot signups-->
        <div style="position: absolute; left: -5000px;" aria-hidden="true">
          <input type="text" name="b_4fe23c6fe1c37c86b0e7689a5_2f4daa5a52" tabindex="-1" value="" />
        </div>
        <div class="clear">
          <xsl:choose>
            <xsl:when test="$lang = 'en'">
              <input type="submit" style="" value="Subscribe" name="subscribe" id="mc-embedded-subscribe" class="button" onClick = "this.form.action='https://chashude.us17.list-manage.com/subscribe/post?u=4fe23c6fe1c37c86b0e7689a5&amp;id=2f4daa5a52';this.form.submit();" />
            
            </xsl:when>
            <xsl:otherwise>
              <input type="submit" style="" value="Tilmeld" name="subscribe" id="mc-embedded-subscribe" class="button" onClick = "this.form.action='https://chashude.us17.list-manage.com/subscribe/post?u=4fe23c6fe1c37c86b0e7689a5&amp;id=2f4daa5a52';this.form.submit();" />
            
            </xsl:otherwise>          
          </xsl:choose>
          
        </div>
      </div>
    </div>
    <script type='text/javascript' src='//s3.amazonaws.com/downloads.mailchimp.com/js/mc-validate.js'></script>
    <script type='text/javascript'>(function($) {window.fnames = new Array(); window.ftypes = new Array();fnames[0]='EMAIL';ftypes[0]='email';fnames[1]='FNAME';ftypes[1]='text';fnames[2]='LNAME';ftypes[2]='text';fnames[3]='MMERGE3';ftypes[3]='text';}(jQuery));var $mcj = jQuery.noConflict(true);</script>
    <!--End mc_embed_signup-->

  </xsl:template>

</xsl:stylesheet>
