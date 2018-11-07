<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output encoding="UTF-8" indent="yes" />
<xsl:strip-space elements="*" /><!-- might alter implicit line feeds in whitespace or empty text nodes from the source, but yields consistent output indentation -->

<xsl:template match="/">
    <xsl:for-each select="*"><!-- only one element, by XML specification -->
        <xsl:copy-of select="preceding-sibling::comment()" />
        <xsl:element name="{local-name()}">
            <xsl:for-each select="@*">
                <xsl:sort select="local-name()" />
                <xsl:attribute name="{local-name()}">
                    <xsl:value-of select="." />
                </xsl:attribute>
            </xsl:for-each>
            <xsl:value-of select="./text()" />
            <xsl:call-template name="loop" />
        </xsl:element>
    </xsl:for-each>
</xsl:template>

<xsl:template name="loop">
    <xsl:choose>
        <xsl:when test="count(ancestor::*) = 0">
            <xsl:for-each select="*">
            <xsl:sort select="((local-name() = 'language') * 2) + 
                ((local-name() = 'symbol') * 1)" 
                data-type="number" order="descending" /><!-- non-matching elements are least important -->
            <xsl:sort select="@lang" />
            <xsl:call-template name="loopelement" />
            </xsl:for-each>
        </xsl:when>
        <xsl:otherwise>
        <xsl:choose>
            <xsl:when test="count(ancestor::*) = 1">
                <xsl:for-each select="*">
                <xsl:sort select="count(@lang)" data-type="number" order="descending" /><!-- data-type="number" is actually redundant since the only values are 0 and 1 -->
                <xsl:sort select="@lang" />
                <xsl:sort select="((local-name() = 'name') * 2) 
                    + ((local-name() = 'text') * 1)" 
                    data-type="number" order="descending" />
                <xsl:sort select="count(@plural)" data-type="number" />
                <xsl:sort select="local-name()" />
                <xsl:call-template name="loopelement" />
                </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
                <xsl:for-each select="*">
                <xsl:call-template name="loopelement" />
                </xsl:for-each>
            </xsl:otherwise>
        </xsl:choose>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<xsl:template name="loopelement">
    <xsl:copy-of select="preceding-sibling::comment()[count(following-sibling::*[1] | current()) = 1]" />
    <xsl:element name="{local-name()}">
        <xsl:for-each select="@*">
            <xsl:sort select="((local-name() = 'lang') * 12) 
                + ((local-name() = 'plural-nouns') * 11) 
                + ((local-name() = 'plural-modifiers') * 10) 
                + ((local-name() = 'gender-modifiers') * 9) 
                + ((local-name() = 'genders') * 8) 
                + ((local-name() = 'kind') * 7) 
                + ((local-name() = 'id') * 6) 
                + ((local-name() = 'standard') * 5) 
                + ((local-name() = 'thickness') * 4) 
                + ((local-name() = 'plural') * 3) 
                + ((local-name() = 'gender') * 2) 
                + ((local-name() = 'case') * 1)" 
                data-type="number" order="descending" />
            <xsl:sort select="local-name()" />
            <xsl:attribute name="{local-name()}">
                <xsl:value-of select="." />
            </xsl:attribute>
        </xsl:for-each>
        <xsl:value-of select="./text()" />
        <xsl:call-template name="loop" />
    </xsl:element>
</xsl:template>

</xsl:stylesheet>
