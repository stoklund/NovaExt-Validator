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

## HTML

### Documentation lookup
A number of syntax scopes have a `lookup="documentation"`, but the documentation only mentions the possibilities:

```relaxng
attribute lookup { "inherit"|"lookup"|"dictionary" }?,
```

### Unclosed parent or extend-parent

The symbol context attribute `unclosed` has a documented value of `extend-parent`, byt the HTML syntax uses:

```xml
<context behavior="start" group-by-name="true" unclosed="parent">
```

So do some of the examples in the documentation.

### Subsyntax collection attribute

Can a subsyntax reference a collection of another syntax?

```xml
<subsyntax name="css" collection="attributes">
```

This isn't documented.

### Regex templates

What's this?

```xml
<ends-with>
    <template>\3</template>
    <capture number="0" name="html.tag.attribute.value.quote.right" />
</ends-with>
```

Named, reusable regex fragments like Lex offers would be cool.

### Syntax reference on provider symbols

In an HTML completion provider:

```xml
<symbols type="style-class" syntax="css" />
```

Is this a leftover from an older schema?

### Behavior variables

This `variables` attribute does not seem to be documented:

```xml
<behavior variables="true" suffix="(?!&gt;)">
```

### Strings in completion set

Maybe from an older schema?

```xml
    <set name="html.entities">
        <string>&amp;quot;</string>
        <string>&amp;apos;</string>
```

