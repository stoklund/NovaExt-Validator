# Nova Language Definition Validator

The [Nova](https://nova.app) code editor uses an XML format to define [syntax grammars for language definitions](https://docs.nova.app/syntax-reference/). This repository contains [Relax NG](https://relaxng.org) schemas for the XML format which can be used to validate language extensions under development.

## Usage

Run the `validate.sh` script with the extension directory as an argument:

```sh
% NovaExt-Validator/validate.sh ada.novaextension                                                 jolesen@Embla
Validating(xmllint) ada.novaextension/Syntaxes/ada.xml
ada.novaextension/Syntaxes/ada.xml validates
Validating(xmllint) ada.novaextension/Completions/ada.xml
ada.novaextension/Completions/ada.xml validates
```

All XML files in the extension's `Syntaxes/` and `Completions/` subdirectories are validated against the Relax NG schemas. By default, the `xmllint` tool from [libxml2](http://www.xmlsoft.org) is used. Other tools can be selected by passing an option to the `validate.sh` script:

- `-j` Validate using [Jing](https://relaxng.org/jclark/jing.html).
- `-v` Validate using [RNV](http://www.davidashen.net/rnv.html)
- `-s` Validate using [XMLStarlet](http://xmlstar.sourceforge.net). This uses libxml2 under the hood, so the error messages are the same as those produced by `xmllint`.
- `-r` Validate against Relax NG schema using `xmllint` (this is the default).
- `-x` Validate against XSD schema using `xmllint`. *Not recommended*. The XSD schema is generated from the Relax NG original using [Trang](https://relaxng.org/jclark/trang.html), and the translation is not without issues.

The `xmllint` tool comes with macOS, and the others are available in [Homebrew](https://brew.sh). Jing and RNV tend to produce better error messages than the libxml2-based tools.

# Building

The `*.rnc` files contain the original schemas in the [Relax NG compact syntax](https://relaxng.org/compact-20021121.html). The `gen/` directory contains Relax NG XML syntax (`*.rng`) and [W3C XML Schema Definition](https://www.w3.org/TR/xmlschema11-1/) translations made with Trang.

After changing the original schemas, regenerate the translations by running:

```sh
% make -C gen
```

This requires Trang to be installed. Get it from the jing-trang package in Homebrew:

```sh
% brew cask install homebrew/cask-versions/adoptopenjdk8
% brew install jing-trang
```
