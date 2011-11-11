<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxml="urn:schemas-microsoft-com:xslt">
<xsl:output method="html" indent="no"/>

<xsl:template match="/">

  <xsl:variable name="unique-asms" select="/PartCoverReport/Assembly"/>

	<html>
  <head>
    <title>Code Coverage Results</title>
    <style type="text/css">
    
    * {
      font-family: verdana, arial, sans-serif;
      font-size: 10px;
    }
    
    th {
      text-align: left;
    }
    
    .cov0 {
      background:#E79090;text-align:right;
    }
    
    .cov20 {
      background:#D79797;text-align:right;
    }
    
    .cov40 {
      background:#D7A0A0;text-align:right;
    }
    
    .cov60 {
      background:#C7A7A7;text-align:right;
    }
    
    .cov80 {
      background:#C0B0B0;text-align:right;
    }
    
    .cov100 {
      background:#D7D7D7;text-align:right;
    }
    
    .assembly {
      background:ghostwhite; padding: 5px  30px 5px  5px;
    }
    
    .coverage-details {
      display: none;
    }
    
    .assembly a {
      text-decoration: none;
      color: black;
      display: block;
    }
    </style>
    
    <script type="text/javascript">
      /* <![CDATA[ */
    /*
      getElementsByClassName Developed by Robert Nyman, http://www.robertnyman.com
      Code/licensing: http://code.google.com/p/getelementsbyclassname/
    */
    var getElementsByClassName = function (className, tag, elm){
      if (document.getElementsByClassName) {
        getElementsByClassName = function (className, tag, elm) {
          elm = elm || document;
          var elements = elm.getElementsByClassName(className),
            nodeName = (tag)? new RegExp("\\b" + tag + "\\b", "i") : null,
            returnElements = [],
            current;
          for(var i=0, il=elements.length; i<il; i+=1){
            current = elements[i];
            if(!nodeName || nodeName.test(current.nodeName)) {
              returnElements.push(current);
            }
          }
          return returnElements;
        };
      }
      else if (document.evaluate) {
        getElementsByClassName = function (className, tag, elm) {
          tag = tag || "*";
          elm = elm || document;
          var classes = className.split(" "),
            classesToCheck = "",
            xhtmlNamespace = "http://www.w3.org/1999/xhtml",
            namespaceResolver = (document.documentElement.namespaceURI === xhtmlNamespace)? xhtmlNamespace : null,
            returnElements = [],
            elements,
            node;
          for(var j=0, jl=classes.length; j<jl; j+=1){
            classesToCheck += "[contains(concat(' ', @class, ' '), ' " + classes[j] + " ')]";
          }
          try	{
            elements = document.evaluate(".//" + tag + classesToCheck, elm, namespaceResolver, 0, null);
          }
          catch (e) {
            elements = document.evaluate(".//" + tag + classesToCheck, elm, null, 0, null);
          }
          while ((node = elements.iterateNext())) {
            returnElements.push(node);
          }
          return returnElements;
        };
      }
      else {
        getElementsByClassName = function (className, tag, elm) {
          tag = tag || "*";
          elm = elm || document;
          var classes = className.split(" "),
            classesToCheck = [],
            elements = (tag === "*" && elm.all)? elm.all : elm.getElementsByTagName(tag),
            current,
            returnElements = [],
            match;
          for(var k=0, kl=classes.length; k<kl; k+=1){
            classesToCheck.push(new RegExp("(^|\\s)" + classes[k] + "(\\s|$)"));
          }
          for(var l=0, ll=elements.length; l<ll; l+=1){
            current = elements[l];
            match = false;
            for(var m=0, ml=classesToCheck.length; m<ml; m+=1){
              match = classesToCheck[m].test(current.className);
              if (!match) {
                break;
              }
            }
            if (match) {
              returnElements.push(current);
            }
          }
          return returnElements;
        };
      }
      return getElementsByClassName(className, tag, elm);
    };
    
      function showAssembly(assemblyId) {
        // Hide all assembly details
        var details = getElementsByClassName("coverage-details");
        for(var i = 0; i < details.length; i++) {
          details[i].style.display = "none";
        }
       
        //Show selected assembly 
        var elem = document.getElementById("coverage-assembly-" + assemblyId);
        elem.style.display = "block";
        
      }
      /* ]]> */
    </script>
  </head>
  <body>
  
    
  
    <table style="border-collapse: collapse;">
      <tr><th colspan="2">Assemblies (click for details)</th></tr>

      <xsl:for-each select="$unique-asms">
        <xsl:variable name="current-asm" select="./@id"/>
        <tr>
          
          <xsl:element name="td">
            <xsl:attribute name="class">assembly</xsl:attribute>
            <xsl:element name="a">
              <xsl:attribute name="href">javascript:void(0)</xsl:attribute>
              <xsl:attribute name="onclick">showAssembly('<xsl:value-of select="$current-asm" />')</xsl:attribute>
              <xsl:value-of select="./@name"/>
            </xsl:element>
          </xsl:element>
          
          <xsl:variable name="codeSize" select="sum(//Type[@asmref=$current-asm]/Method/pt/@len)+sum(//Type[@asmref=$current-asm]/Method[count(pt)=0]/@bodysize)"/>
          <xsl:variable name="coveredCodeSize" select="sum(//Type[@asmref=$current-asm]/Method/pt[@visit>0]/@len)"/>
          
          <xsl:element name="td">
            <xsl:if test="$codeSize=0">
              <xsl:attribute name="class">cov0</xsl:attribute>
              0%
            </xsl:if>

            <xsl:if test="$codeSize &gt; 0">
              <xsl:variable name="coverage" select="round(100 * $coveredCodeSize div $codeSize)"/>
              
              <xsl:if test="$coverage &gt;=  0 and $coverage &lt; 20"><xsl:attribute name="class">cov20</xsl:attribute></xsl:if>
              <xsl:if test="$coverage &gt;= 20 and $coverage &lt; 40"><xsl:attribute name="class">cov40</xsl:attribute></xsl:if>
              <xsl:if test="$coverage &gt;= 40 and $coverage &lt; 60"><xsl:attribute name="class">cov60</xsl:attribute></xsl:if>
              <xsl:if test="$coverage &gt;= 60 and $coverage &lt; 80"><xsl:attribute name="class">cov80</xsl:attribute></xsl:if>
              <xsl:if test="$coverage &gt;= 80"><xsl:attribute name="style">cov100</xsl:attribute></xsl:if>
              <xsl:value-of select="$coverage"/>%
            </xsl:if>
            
          </xsl:element>
        </tr>
      </xsl:for-each>
    </table>
    
    <xsl:for-each select="$unique-asms">
      <xsl:variable name="current-asm" select="./@id"/>
      
      <xsl:element name="div">
        <xsl:attribute name="class">coverage-details</xsl:attribute>
        <xsl:attribute name="id">coverage-assembly-<xsl:value-of select="$current-asm" /></xsl:attribute>
        <h2><xsl:value-of select="./@name"/></h2>
        
        <table style="border-collapse: collapse;">
          <xsl:for-each select="/PartCoverReport/Type[@asmref=$current-asm]">
              <tr>
                  <xsl:element name="td">
                      <xsl:attribute name="style">background:ghostwhite; padding: 5px  30px 5px  5px;</xsl:attribute>
                      <xsl:value-of select="@name"/>
                  </xsl:element>

                  <xsl:variable name="codeSize" select="sum(./Method/pt/@len)+0"/>
                  <xsl:variable name="coveredCodeSize" select="sum(./Method/pt[@visit>0]/@len)+0"/>

                  <xsl:element name="td">
                      <xsl:if test="$codeSize=0">
                          <xsl:attribute name="class">cov0</xsl:attribute>
                          0%
                      </xsl:if>

                      <xsl:if test="$codeSize &gt; 0">
                          <xsl:variable name="coverage" select="ceiling(100 * $coveredCodeSize div $codeSize)"/>

                          <xsl:if test="$coverage &gt;=  0 and $coverage &lt; 20"><xsl:attribute name="class">cov20</xsl:attribute></xsl:if>
                          <xsl:if test="$coverage &gt;= 20 and $coverage &lt; 40"><xsl:attribute name="class">cov40</xsl:attribute></xsl:if>
                          <xsl:if test="$coverage &gt;= 40 and $coverage &lt; 60"><xsl:attribute name="class">cov60</xsl:attribute></xsl:if>
                          <xsl:if test="$coverage &gt;= 60 and $coverage &lt; 80"><xsl:attribute name="class">cov80</xsl:attribute></xsl:if>
                          <xsl:if test="$coverage &gt;= 80"><xsl:attribute name="style">cov100</xsl:attribute></xsl:if>
                          <xsl:value-of select="$coverage"/>%
                      </xsl:if>

                  </xsl:element>
              </tr>
          </xsl:for-each>
        </table>
        
        
        
        
        
      </xsl:element>
    </xsl:for-each>
    
    
    
    
	</body>
	</html>
</xsl:template>

</xsl:stylesheet>
