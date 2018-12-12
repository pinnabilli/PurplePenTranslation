# PurplePenTranslation
My first repository with some code to help translating Purple Pen, actually a way to get confident with Git

The current version of [Purple Pen](http://purplepen.golde.org/) (3.1.4) crashes as soon as one tries to add a new translation of the textual control descriptions. In the need of having an Italian translation for future events, manually editing the source file `symbols.xml` seemed a reasonable effort: I ended up sorting the file contents in a more intuitive way to speed up the process, using XSL transformations.

- `FormatSortWithPrecedingComments.xsl`: nice sorting including comments, which are considered bound to the following element
- `FormatSort.xsl`: nice sorting
- `ExtractStructure.xsl`: synthetic and complete structure
- `Identity.xsl`: identity transformation, does nothing
<!-- -->
- `ItalianTranslationWithFlagPlacement.xml`: added custom symbols in column H for flag placement, added changelog
- `ItalianTranslation.xml`: English trench plural, 11.14W fix, Italian (Italy) translation
