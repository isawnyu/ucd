<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="xs t xsl"
    version="2.0">
    
    <xsl:strip-space elements="t:*"/>
    <xsl:preserve-space elements="t:education t:occupation t:p t:item"/>
    <xsl:output method="xhtml" indent="yes"  />
    
    <xsl:template match="/">
        <html xmlns="http://www.w3.org/1999/xhtml">
            <head>
                <title><xsl:value-of select="normalize-space(//t:titleStmt/t:title)"/></title>
                <link rel="stylesheet" href="css/reset-fonts-grids.css" type="text/css" />
                <link rel="stylesheet" href="css/personas.css" type="text/css" />
            </head>
            <body>
                <xsl:apply-templates select="//t:body"/>
                <div id="footer">
                    <xsl:apply-templates select="//t:publicationStmt"/>
                    <xsl:apply-templates select="//t:figure[@xml:id='portrait']" mode="rights"/>
                </div>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="t:body">
        <xsl:apply-templates select="t:listPerson"/>
    </xsl:template>
    
    <xsl:template match="t:listPerson">
        <xsl:apply-templates select="//t:person"/>
    </xsl:template>
    
    <xsl:template match="t:person">
        <div id="person-{count(preceding::t:person)+1}">
            <div class="person-header">
                <div class="person-portrait">
                    <xsl:apply-templates select="t:figure[@xml:id='portrait']"/>
                </div>
                <div class="person-basics"> 
                    <xsl:apply-templates select="t:persName"/>
                    <xsl:apply-templates select="t:age"/>
                    <xsl:apply-templates select="t:education"/>
                    <xsl:apply-templates select="t:occupation"/>
                </div>
            </div>
            <div class="person-details"> 
                <xsl:for-each select="t:state">
                    <div class="state" id="{@type}">
                        <xsl:apply-templates/>
                    </div>
                </xsl:for-each>
            </div>
        </div>

    </xsl:template>
        
    <xsl:template match="t:figure[@xml:id='portrait']" mode="rights">
        <xsl:if test="t:ab[@type='rights']">
            <p><xsl:value-of select="normalize-space(t:graphic/t:desc)"/>: <xsl:apply-templates select="t:ab[@type='rights']/node()"/></p>
        </xsl:if>
    </xsl:template>
        
    <xsl:template match="t:figure[@xml:id='portrait']">
        <img src="{t:graphic/@url}" alt="{normalize-space(t:graphic/t:desc)}"/>
    </xsl:template>
    <xsl:template match="t:persName">
        <p>Name: <xsl:choose>
                <xsl:when test="t:forename | t:surname">
                    <xsl:value-of select="t:forename"/><xsl:text> </xsl:text><xsl:value-of select="t:surname"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose></p>
    </xsl:template>
    
    <xsl:template match="t:age">
        <p>Age: <xsl:value-of select="@value"/></p>
    </xsl:template>
    
    <xsl:template match="t:education">
        <p>Education: <xsl:value-of select="."/></p>
    </xsl:template>
    
    <xsl:template match="t:occupation">
        <p>Occupation, employer, and job situation: <xsl:apply-templates/></p>
    </xsl:template>
    
    <xsl:template match="t:p[t:list]">
        <ul>
            <xsl:apply-templates select="t:list/t:item"/>
        </ul>
    </xsl:template>
    
    <xsl:template match="t:item">
        <li><xsl:apply-templates/></li>
    </xsl:template>
    
    <xsl:template match="t:p">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    
    <xsl:template match="t:publicationStmt">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="t:ref[starts-with(@target, 'http://')]">
        <a href="{@target}"><xsl:value-of select="."/></a>
    </xsl:template>
    
    <xsl:template match="t:*"><span class="{local-name(.)}"><xsl:apply-templates/></span></xsl:template>
    
    
    <xsl:template match="text()">
        <xsl:choose>
            <xsl:when test="normalize-space(.) = ''"><xsl:text> </xsl:text></xsl:when>
            <xsl:when test="normalize-space(substring(., 1, 1)) = '' and normalize-space(substring(., string-length(.), 1)) = ''">
                <xsl:text> </xsl:text><xsl:value-of select="normalize-space(.)"/><xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="normalize-space(substring(., 1, 1)) = ''">
                <xsl:text> </xsl:text><xsl:value-of select="normalize-space(.)"/><xsl:text></xsl:text>
            </xsl:when>
            <xsl:when test="normalize-space(substring(., string-length(.), 1)) = ''">
                <xsl:text></xsl:text><xsl:value-of select="normalize-space(.)"/><xsl:text> </xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text></xsl:text><xsl:value-of select="normalize-space(.)"/><xsl:text></xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    
</xsl:stylesheet>