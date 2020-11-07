.SUFFIXES: .rnc .rng .xsd
VPATH=..
all: syntax.xsd syntax.rng completions.xsd completions.rng

.rnc.rng:
	trang $< $@

.rnc.xsd:
	trang $< $@

syntax.xsd syntax.rng: common.rnc syntax.rnc scope.rnc symbol.rnc common.rnc provider.rnc
completions.xsd completions.rng: common.rnc provider.rnc
