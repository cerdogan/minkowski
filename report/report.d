# vim: ft=make
.PHONY: report._graphics
report.aux report.aux.make report.d report.pdf: $(call path-norm,/usr/share/texmf-texlive/tex/generic/babel/babel.sty)
report.aux report.aux.make report.d report.pdf: $(call path-norm,/usr/share/texmf-texlive/tex/latex/amsmath/amsbsy.sty)
report.aux report.aux.make report.d report.pdf: $(call path-norm,/usr/share/texmf-texlive/tex/latex/amsmath/amsgen.sty)
report.aux report.aux.make report.d report.pdf: $(call path-norm,/usr/share/texmf-texlive/tex/latex/amsmath/amsmath.sty)
report.aux report.aux.make report.d report.pdf: $(call path-norm,/usr/share/texmf-texlive/tex/latex/amsmath/amsopn.sty)
report.aux report.aux.make report.d report.pdf: $(call path-norm,/usr/share/texmf-texlive/tex/latex/amsmath/amstext.sty)
report.aux report.aux.make report.d report.pdf: $(call path-norm,/usr/share/texmf-texlive/tex/latex/blindtext/blindtext.sty)
report.aux report.aux.make report.d report.pdf: $(call path-norm,/usr/share/texmf-texlive/tex/latex/graphics/graphics.sty)
report.aux report.aux.make report.d report.pdf: $(call path-norm,/usr/share/texmf-texlive/tex/latex/graphics/graphicx.sty)
report.aux report.aux.make report.d report.pdf: $(call path-norm,/usr/share/texmf-texlive/tex/latex/graphics/keyval.sty)
report.aux report.aux.make report.d report.pdf: $(call path-norm,/usr/share/texmf-texlive/tex/latex/graphics/trig.sty)
report.aux report.aux.make report.d report.pdf: $(call path-norm,/usr/share/texmf-texlive/tex/latex/tools/enumerate.sty)
report.aux report.aux.make report.d report.pdf: $(call path-norm,/usr/share/texmf-texlive/tex/latex/tools/xspace.sty)
report.aux report.aux.make report.d report.pdf: $(call path-norm,ieeeconf.cls)
report.aux report.aux.make report.d report.pdf: $(call path-norm,report.tex)
.SECONDEXPANSION:
-include Figures/main.png.gpi.d
report.d: $$(call graphics-source,Figures/main.png)
report.pdf report._graphics: $$(call graphics-target,Figures/main.png)
-include Figures/bump.png.gpi.d
report.d: $$(call graphics-source,Figures/bump.png)
report.pdf report._graphics: $$(call graphics-target,Figures/bump.png)
-include Figures/bumpConvolved.png.gpi.d
report.d: $$(call graphics-source,Figures/bumpConvolved.png)
report.pdf report._graphics: $$(call graphics-target,Figures/bumpConvolved.png)
-include Figures/bumpFouriers.png.gpi.d
report.d: $$(call graphics-source,Figures/bumpFouriers.png)
report.pdf report._graphics: $$(call graphics-target,Figures/bumpFouriers.png)
report.bbl report.aux report.aux.make: ./minkowski.bib
