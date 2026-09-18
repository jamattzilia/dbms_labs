# Laboratory Work No. 3

**Subject:** 3-a. Creation of the elementary HTML document. Formatting of a font and paragraph.
3-b. Insertion of figures in the HTML document. Creation of bookmarks and hyperlinks.

**Purpose:**
- learn to create the elementary hypertext document by means of the Notepad text editor;
- learn to use font- and paragraph-formatting tags;
- learn to insert pictures into an HTML document;
- learn to create bookmarks and hyperlinks.

**Variant:** this laboratory work has no variants — the task is the same for every student; personal data (surname, first name, group number) is substituted into the document individually.

Data used: **Doe John**, group **SISCCO-2502NS**.

## Work structure

| File | Purpose |
|---|---|
| [`1_Doe.htm`](1_Doe.htm) | part 3-a: headings, font formatting |
| [`2_Doe.htm`](2_Doe.htm) | part 3-a (step 6): paragraph formatting (Lorem Ipsum sample text) |
| [`3_Doe.htm`](3_Doe.htm) | part 3-a (step 7) + 3-b (step 3): lists, bookmarks and hyperlinks |
| [`4_Doe.htm`](4_Doe.htm) | part 3-b (steps 2, 4): image insertion and a hyperlink on an image |
| `images/arrow1.svg`, `arrow2.svg`, `arrow3.svg` | substitute graphic files for `Arrows1.wmf`, `Arrows2.wmf`, `Arrows3.wmf` (the WMF format is not supported by modern browsers, so SVG was used instead) |

## Part 3-a. Creation of the elementary HTML document

### Steps 1–2. Basic structure (`1_Doe.htm`)

```html
<HTML>
<HEAD> <TITLE> Doe </TITLE>
</HEAD>
<BODY>
I welcome you on my first web page!
</BODY>
</HTML>
```

### Step 3. Signature and line break

A signature was added after the greeting phrase using the `<BR>` tag (each part starts on a new line):

```html
I welcome you on my first web page! <BR>
Student of the SISCCO-2502NS group <BR>
Doe John
```

### Step 4. Formatting with headings (Heading styles)

The lines were first styled as `<h1>/<h6>/<h4>`, then changed to `<h2>/<h5>/<h3>` (final version):

```html
<H2>I welcome you on my first web page!</H2>
<H5>Student of the SISCCO-2502NS group</H5>
<H3>Doe John</H3>
```

### Step 5. Font formatting

A line with the Russian sample phrase from the assignment — *«Нас утро встречает прохладой»* ("Morning greets us with coolness") — was added and formatted as required by the sample:
- **Нас** ("Us") — struck-through text (`<S>`);
- **утро** ("morning") — bold italic, each letter in a different color (`<B><I><FONT COLOR="...">`);
- **встречает** ("greets") — underlined, small text (`<U><SMALL>`);
- **про*хлад*ой** ("coolness") — the fragment "хлад" in italic red, "ой" in blue.

This exercise specifically tests per-letter/per-fragment font formatting on Cyrillic text, so the Russian phrase itself is kept as dictated by the assignment rather than translated.

The signature line (`Student of the SISCCO-2502NS group` / `Doe John`) is set in italics with a relative font-size increase: `<FONT SIZE="+2"><I> ... </I></FONT>`.

A bookmark named `Morning` was placed before this line (used later for a hyperlink from `3_Doe.htm`):

```html
<A NAME="Morning"></A>
<P>
<S>Нас</S>
<B><I><FONT COLOR="red">у</FONT><FONT COLOR="green">т</FONT><FONT COLOR="blue">р</FONT><FONT COLOR="purple">о</FONT></I></B>
<U><SMALL>встречает</SMALL></U>
про<I><FONT COLOR="red">хлад</FONT></I><FONT COLOR="blue">ой</FONT>
</P>
```

Final file — [`1_Doe.htm`](1_Doe.htm).

### Step 6. Paragraph formatting (`2_Doe.htm`)

A new document was created; the text of the first two lines is center-aligned:

```html
<P ALIGN="CENTER">
Приветствую Вас на моей второй web-странице! <BR>
Lorem Ipsum
</P>
```

(The first line is the greeting text dictated by the assignment — "Welcome to my second web page!". The original methodical guide suggested a Hamlet's-monologue paraphrase as sample text for this section; it was replaced here with the classic Lorem Ipsum filler text, since the point of the exercise is paragraph formatting, not the specific wording.)

A bookmark named `Mono` is placed before the sample paragraph. The text is formatted as a paragraph with justified alignment (`JUSTIFY`) and bounded above and below by horizontal rules (`<HR>`):

```html
<A NAME="Mono"></A>
<HR SIZE="2">
<P ALIGN="JUSTIFY">
Lorem ipsum dolor sit amet, consectetur adipiscing elit, ...
</P>
<HR SIZE="2">
```

The same text is then duplicated, split into lines with `<BR>`, and center-aligned — this layout stays intact when the browser window is resized, unlike the justified version.

Final file — [`2_Doe.htm`](2_Doe.htm).

### Step 7. List formatting (`3_Doe.htm`)

A document with a greeting and a "Fonts, Titles, Paragraphs" list was created — first as an ordered list (`<ol>`), then changed to an unordered (bulleted) list (`<ul>`), as required by the assignment.

A "mixed" list was also created: an outer ordered list (`Fonts`, `Headings`, `Paragraphs`) with nested unordered sub-lists:

```html
<OL>
<LI>Fonts
  <UL>
    <LI>Size</LI>
    <LI>Color</LI>
    <LI>To a set</LI>
    <LI>Indexes</LI>
  </UL>
</LI>
<LI>Headings
  <UL><LI>From 1st to the 6th level</LI></UL>
</LI>
<LI>Paragraphs
  <UL>
    <LI>Alignment</LI>
    <LI>A rupture of lines in the paragraph</LI>
    <LI>With reformatting use.</LI>
  </UL>
</LI>
</OL>
```

Final file — [`3_Doe.htm`](3_Doe.htm).

## Part 3-b. Inserting images, bookmarks and hyperlinks

### Inserting images (`4_Doe.htm`)

The document `2_Doe.htm` was opened, an image `Arrows1` (`images/arrow1.svg`) sized 50×50 pixels was added at the beginning, and the result was saved under the name `4_Doe.htm`. Then:
- the image was given `ALIGN="right"` alignment;
- an image `Arrows2` (`images/arrow2.svg`) sized 100×100 pixels was added at the end of the document, with the tooltip `ALT="Figure 2"`.

```html
<IMG SRC="images/arrow1.svg" WIDTH="50" HEIGHT="50" ALIGN="right" ALT="to Return">
...
<IMG SRC="images/arrow2.svg" WIDTH="100" HEIGHT="100" ALIGN="left" ALT="Figure 2">
```

### Bookmarks and hyperlinks (`3_Doe.htm`)

Hyperlinks were assigned to the unordered `Fonts / Titles / Paragraphs` list:

| Word | Link |
|---|---|
| `Fonts` | to the `Morning` bookmark in `1_Doe.htm` — `<A HREF="1_Doe.htm#Morning">Fonts</A>` |
| `Titles` (Headings) | to the `Hello` bookmark at the beginning of the current document `3_Doe.htm` — `<A HREF="#Hello">Titles</A>` |
| `Paragraphs` | to the document `2_Doe.htm` — `<A HREF="2_Doe.htm">Paragraphs</A>` |

A `Hello` bookmark was created at the beginning of `3_Doe.htm`:

```html
<A NAME="Hello"></A>
<P>Приветствую Вас на моей третьей web-странице!</P>
```

(The line means "Welcome to my third web page!", as dictated by the assignment.)

In the mixed list, the word `reformatting` is linked to the `Mono` bookmark in `2_Doe.htm`:

```html
<LI>With <A HREF="2_Doe.htm#Mono">reformatting</A> use.</LI>
```

### Hyperlink on an image (`4_Doe.htm`)

The `Arrows1` image was given the tooltip `ALT="to Return"` and a hyperlink to the document `3_Doe.htm`:

```html
<A HREF="3_Doe.htm">
  <IMG SRC="images/arrow1.svg" WIDTH="50" HEIGHT="50" ALIGN="right" ALT="to Return">
</A>
```

## Verification

All four documents are interconnected through hyperlinks:

```
3_Doe.htm --Fonts--> 1_Doe.htm#Morning
3_Doe.htm --Titles--> 3_Doe.htm#Hello (jump to the top of the current page)
3_Doe.htm --Paragraphs--> 2_Doe.htm
3_Doe.htm --reformatting--> 2_Doe.htm#Mono
4_Doe.htm --Arrows1 image--> 3_Doe.htm
```

Opening `1_Doe.htm`, `2_Doe.htm`, `3_Doe.htm`, `4_Doe.htm` in a browser and following every link confirms that the bookmarks and hyperlinks work correctly.

## Reference tables (from the lab guide)

### Main font- and paragraph-formatting tags

| Purpose | Tag |
|---|---|
| Heading, level № | `<H№> text </H№>` (№ from 1 to 6) |
| Paragraph | `<P> text </P>` |
| Line break | `<BR>` |
| Paragraph alignment | `<P ALIGN="LEFT\|CENTER\|RIGHT\|JUSTIFY">` |
| Horizontal rule | `<HR SIZE="?">` |
| Bold / italic / underline / strikethrough | `<B>`, `<I>`, `<U>`, `<S>` |
| Larger / smaller font | `<BIG>`, `<SMALL>` |
| Superscript / subscript | `<SUP>`, `<SUB>` |
| Font size | `<FONT SIZE="?">` (1–7, or relative, e.g. `+2`) |
| Font color | `<FONT COLOR="color_name\|#RRGGBB">` |
| Ordered / unordered list | `<OL>`/`<UL>` with `<LI>` items |

### Main tags for images, bookmarks and links

| Purpose | Tag |
|---|---|
| Insert an image | `<IMG SRC="file" WIDTH="width" HEIGHT="height">` |
| Align an image | `<IMG ... ALIGN="left\|right\|top\|bottom">` |
| Tooltip text | `<IMG ... ALT="text">` |
| Link to another page | `<A HREF="page"> text </A>` |
| Link to a bookmark in another document | `<A HREF="page#bookmark"> text </A>` |
| Link to a bookmark in the current document | `<A HREF="#bookmark"> text </A>` |
| Define a bookmark | `<A NAME="bookmark_name"></A>` |

## Conclusion

This laboratory work covered creating simple HTML documents in a text editor: document structure (`HTML/HEAD/TITLE/BODY`), font formatting (bold, italic, underline, strikethrough, color, size), paragraph formatting (alignment, horizontal rules, line breaks), creating ordered, unordered, and nested lists, inserting images with a defined size, alignment, and tooltip, and creating bookmarks and hyperlinks — both between different documents and within a single document.
