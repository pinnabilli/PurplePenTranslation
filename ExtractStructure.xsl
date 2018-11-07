<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output encoding="UTF-8" indent="yes" />
<xsl:strip-space elements="*" /><!-- might alter implicit line feeds in whitespace or empty text nodes from the source, but yields consistent output indentation -->

<xsl:template match="/">
    <xsl:for-each select="*"><!-- only one element, by XML specification -->
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
    <xsl:variable name="v" select="local-name()" />
    <xsl:for-each select="../*[local-name() = local-name(current())]/*">
        <xsl:sort select="local-name()" />
        <xsl:if test="count(preceding-sibling::*[local-name() = local-name(current())]) + count(../preceding-sibling::*[local-name() = $v]/*[local-name() = local-name(current())]) = 0">
            <xsl:element name="{local-name()}">
                <xsl:for-each select="../../*[local-name() = $v]/*[local-name() = local-name(current())]/@*">
                    <xsl:sort select="local-name()" />
                    <xsl:attribute name="{local-name()}">
                        <xsl:value-of select="." />
                    </xsl:attribute>
                </xsl:for-each>
                <xsl:value-of select="./text()" />
                <xsl:call-template name="loop" />
            </xsl:element>
        </xsl:if>
    </xsl:for-each>
</xsl:template>

</xsl:stylesheet>
