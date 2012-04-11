README for ISAW personas

* Personas are authored in *.xml files (using TEI P5 person elements etc.)
* HTML views of same are generated with ./xsl/persona2html.xsl
  * there is a transform defined for this purpose in personas.xpr (dependency: OxygenXML editor)
* cartoon headshots for the personas are kept in ./gfx/
  * ./gfx/*.pdf are the editable master files (using Adobe Illustrator)
  * from those are generated the 300ppi and 72ppi PNGs; the latter is to be used in the xml files
* at present nissma-hassan.xml is pretty complete and is probably the best place to look for an example