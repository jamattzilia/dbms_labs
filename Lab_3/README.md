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

All tags and attributes in the markup are written in lowercase.

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
<html>
<head> <title> Doe </title>
</head>
<body>
I welcome you on my first web page!
</body>
</html>
```

### Step 3. Signature and line break

A signature was added after the greeting phrase using the `<br>` tag (each part starts on a new line):

```html
I welcome you on my first web page! <br>
Student of the SISCCO-2502NS group <br>
Doe John
```

### Step 4. Formatting with headings (Heading styles)

The lines were first styled as `<h1>/<h6>/<h4>`, then changed to `<h2>/<h5>/<h3>` (final version):

```html
<h2>I welcome you on my first web page!</h2>
<h5>Student of the SISCCO-2502NS group</h5>
<h3>Doe John</h3>
```

### Step 5. Font formatting

A line with the Russian sample phrase from the assignment — *«Нас утро встречает прохладой»* ("Morning greets us with coolness") — was added and formatted as required by the sample:
- **Нас** ("Us") — struck-through text (`<s>`);
- **утро** ("morning") — bold italic, each letter in a different color (`<b><i><font color="...">`);
- **встречает** ("greets") — underlined, small text (`<u><small>`);
- **про*хлад*ой** ("coolness") — the fragment "хлад" in italic red, "ой" in blue.

This exercise specifically tests per-letter/per-fragment font formatting on Cyrillic text, so the Russian phrase itself is kept as dictated by the assignment rather than translated.

The signature line (`Student of the SISCCO-2502NS group` / `Doe John`) is set in italics with a relative font-size increase: `<font size="+2"><i> ... </i></font>`.

A bookmark named `Morning` was placed before this line (used later for a hyperlink from `3_Doe.htm`):

```html
<a name="Morning"></a>
<p>
<s>Нас</s>
<b><i><font color="red">у</font><font color="green">т</font><font color="blue">р</font><font color="purple">о</font></i></b>
<u><small>встречает</small></u>
про<i><font color="red">хлад</font></i><font color="blue">ой</font>
</p>
```

Final file — [`1_Doe.htm`](1_Doe.htm).

### Step 6. Paragraph formatting (`2_Doe.htm`)

A new document was created; the text of the first two lines is center-aligned:

```html
<p align="center">
Приветствую Вас на моей второй web-странице! <br>
Lorem Ipsum
</p>
```

(The first line is the greeting text dictated by the assignment — "Welcome to my second web page!". The original methodical guide suggested a Hamlet's-monologue paraphrase as sample text for this section; it was replaced here with the classic Lorem Ipsum filler text, since the point of the exercise is paragraph formatting, not the specific wording.)

A bookmark named `Mono` is placed before the sample paragraph. The text is formatted as a paragraph with justified alignment (`justify`) and bounded above and below by horizontal rules (`<hr>`):

```html
<a name="Mono"></a>
<hr size="2">
<p align="justify">
Lorem ipsum dolor sit amet, consectetur adipiscing elit, ...
</p>
<hr size="2">
```

The same text is then duplicated, split into lines with `<br>`, and center-aligned — this layout stays intact when the browser window is resized, unlike the justified version.

Final file — [`2_Doe.htm`](2_Doe.htm).

### Step 7. List formatting (`3_Doe.htm`)

A document with a greeting and a "Fonts, Titles, Paragraphs" list was created — first as an ordered list (`<ol>`), then changed to an unordered (bulleted) list (`<ul>`), as required by the assignment.

A "mixed" list was also created: an outer ordered list (`Fonts`, `Headings`, `Paragraphs`) with nested unordered sub-lists:

```html
<ol>
<li>Fonts
  <ul>
    <li>Size</li>
    <li>Color</li>
    <li>To a set</li>
    <li>Indexes</li>
  </ul>
</li>
<li>Headings
  <ul><li>From 1st to the 6th level</li></ul>
</li>
<li>Paragraphs
  <ul>
    <li>Alignment</li>
    <li>A rupture of lines in the paragraph</li>
    <li>With reformatting use.</li>
  </ul>
</li>
</ol>
```

Final file — [`3_Doe.htm`](3_Doe.htm).

## Part 3-b. Inserting images, bookmarks and hyperlinks

### Inserting images (`4_Doe.htm`)

The document `2_Doe.htm` was opened, an image `Arrows1` (`images/arrow1.svg`) sized 50×50 pixels was added at the beginning, and the result was saved under the name `4_Doe.htm`. Then:
- the image was given `align="right"` alignment;
- an image `Arrows2` (`images/arrow2.svg`) sized 100×100 pixels was added at the end of the document, with the tooltip `alt="Figure 2"`.

```html
<img src="images/arrow1.svg" width="50" height="50" align="right" alt="to Return">
...
<img src="images/arrow2.svg" width="100" height="100" align="left" alt="Figure 2">
```

### Bookmarks and hyperlinks (`3_Doe.htm`)

Hyperlinks were assigned to the unordered `Fonts / Titles / Paragraphs` list:

| Word | Link |
|---|---|
| `Fonts` | to the `Morning` bookmark in `1_Doe.htm` — `<a href="1_Doe.htm#Morning">Fonts</a>` |
| `Titles` (Headings) | to the `Hello` bookmark at the beginning of the current document `3_Doe.htm` — `<a href="#Hello">Titles</a>` |
| `Paragraphs` | to the document `2_Doe.htm` — `<a href="2_Doe.htm">Paragraphs</a>` |

A `Hello` bookmark was created at the beginning of `3_Doe.htm`:

```html
<a name="Hello"></a>
<p>Приветствую Вас на моей третьей web-странице!</p>
```

(The line means "Welcome to my third web page!", as dictated by the assignment.)

In the mixed list, the word `reformatting` is linked to the `Mono` bookmark in `2_Doe.htm`:

```html
<li>With <a href="2_Doe.htm#Mono">reformatting</a> use.</li>
```

### Hyperlink on an image (`4_Doe.htm`)

The `Arrows1` image was given the tooltip `alt="to Return"` and a hyperlink to the document `3_Doe.htm`:

```html
<a href="3_Doe.htm">
  <img src="images/arrow1.svg" width="50" height="50" align="right" alt="to Return">
</a>
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

Bookmark names (`Morning`, `Mono`, `Hello`) in the `name="..."` / `href="#..."` attributes are kept as originally cased, since bookmark-name matching in `href="#..."` is case-sensitive in some browsers — only the tag and attribute names themselves were lowercased.

## Reference tables (from the lab guide)

### Main font- and paragraph-formatting tags

| Purpose | Tag |
|---|---|
| Heading, level № | `<h№> text </h№>` (№ from 1 to 6) |
| Paragraph | `<p> text </p>` |
| Line break | `<br>` |
| Paragraph alignment | `<p align="left\|center\|right\|justify">` |
| Horizontal rule | `<hr size="?">` |
| Bold / italic / underline / strikethrough | `<b>`, `<i>`, `<u>`, `<s>` |
| Larger / smaller font | `<big>`, `<small>` |
| Superscript / subscript | `<sup>`, `<sub>` |
| Font size | `<font size="?">` (1–7, or relative, e.g. `+2`) |
| Font color | `<font color="color_name\|#rrggbb">` |
| Ordered / unordered list | `<ol>`/`<ul>` with `<li>` items |

### Main tags for images, bookmarks and links

| Purpose | Tag |
|---|---|
| Insert an image | `<img src="file" width="width" height="height">` |
| Align an image | `<img ... align="left\|right\|top\|bottom">` |
| Tooltip text | `<img ... alt="text">` |
| Link to another page | `<a href="page"> text </a>` |
| Link to a bookmark in another document | `<a href="page#bookmark"> text </a>` |
| Link to a bookmark in the current document | `<a href="#bookmark"> text </a>` |
| Define a bookmark | `<a name="bookmark_name"></a>` |

## Conclusion

This laboratory work covered creating simple HTML documents in a text editor: document structure (`html/head/title/body`), font formatting (bold, italic, underline, strikethrough, color, size), paragraph formatting (alignment, horizontal rules, line breaks), creating ordered, unordered, and nested lists, inserting images with a defined size, alignment, and tooltip, and creating bookmarks and hyperlinks — both between different documents and within a single document.
