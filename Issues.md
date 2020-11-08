# Issues in Nova 2.1

This is a list of issues found while validating the extensions shipped with Nova 2.1.

## CSS

### Syntax identifiers

The `<syntax>` element has an `<identifiers>` child:

```xml
<identifiers>
    <characters>
        <alphanumeric />
        <string>-_</string>
    </characters>
    <prefixes>
        <string>#</string>
    </prefixes>
</identifiers>
```

This undocumented element appears in other extensions too.

### Captures on `<strings>`

A `<strings>` element with a `suffix=` attribute can be followed by captures:

```xml
<starts-with>
    <strings suffix="(:)?">
        <string>any-hover</string>
        <string>any-pointer</string>
        ...
        <string>min-width</string>
        <string>max-width</string>
    </strings>
    <capture number="1" name="css.style.media-feature.keyword" />
    <capture number="2" name="css.style.media-feature.separator" />
</starts-with>
```

This makes sense, but it isn't clear from the documentation that this is possible.

### `prefixsuffix` attribute

This looks like a typo:

```xml
<strings case-insensitive="true" prefixsuffix="(?=\()">
```

### Expression capture attribute

A single case of `<expression capture="1"` in one of the CSS completion behaviors. What does it mean?

### Description attribute on completions.

A `completion string="..." description="..."` appeared. Is this attribute used?

### Assistant element

A completion provider contains an `<assistant type="files" />` element.

