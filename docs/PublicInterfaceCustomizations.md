# Public Interface Customizations

## Introduction

This document describes the UMD customizations made to the ArchivesSpace
public ("public") interface.

## Overridden ArchivesSpace Files

The following stock ArchivesSpace files have been overridden to support UMD
customizations.

When updating ArchivesSpace, these files should be modified to incorporate any
updates from the stock ArchivesSpace files, while maintaining the UMD
customizations.

**Note:** Only files present in stock ArchivesSpace are listed in the table.

| File                                         | Functionality      |
| -------------------------------------------- | ------------------ |
| public/views/layouts/application.html.erb    | Environment Banner, Matomo Analytics, UMD Header, Search Box Image |
| public/views/objects/show.html.erb           | Request Instructions |
| public/views/repositories/_repository_details.html.erb | Library Details Fix |
| public/views/resources/show.html.erb         | Request Instructions |
| public/views/shared/_footer.html.erb         | Custom Footer |
| public/views/shared/_header.html.erb         | Custom Header, Navbar Search, Search Box Image, Website Feedback |
| public/views/shared/_idbadge.html.erb        | Resource Ids |
| public/views/shared/_navigation.html.erb     | Navbar Links, Navbar Search |
| public/views/shared/_only_facets.html.erb    | Search Facets |
| public/views/shared/_record_innards.html.erb | Field Reordering, Inventories Display |
| public/views/shared/_result.html.erb         | Found In Reordering |
| public/views/shared/_search.html.erb         | Search Box Image, Search Stop-gap |

## Functionality

### Custom Footer

**Jira Issue(s):** LIBASPACE-112, LIBASPACE-113

Verify that the footer has been customized, i.e., among other things contains:

* "Useful Links" and "Contact Us" sections
* a "Web Accessibility" link

### Custom Header

**Jira Issue(s):** LIBASPACE-112

Verify that the UMD Libraries logo appears in the header.

### Environment Banner

**Jira Issue(s):** LIBASPACE-115

In accordance with SSDR policy an "environment banner" is displayed on all
non-production web applications.

To verify, run ArchivesSpace on a non-production system (local, test, or qa),
and verify that an environment banner is shown.

### Field Reordering

**Jira Issue(s):** LIBASPACE-119

In the "accessions", "objects", and "resources" views, flipped the precedence
of the test in the "Overview" section to make the "abstract" text the default,
with the "scopecontext" text as the fallback.

**Verification:**

(See LIBASPACE-119 for more detailed verification steps)

Local development: On the "Archives of the Atlantic Monthly" entry verify that
the text immediately under the "Collection Overview" tab displays the text
"The Atlantic Monthly Press was founded in 1917...", (which is from the
abstract), and not "The archives of Atlantic Monthly Press...", which is the
text from the "scopecontext").

### Found In Reordering

**Jira Issue(s):** LIBASPACE-138

In the collections list, moved the "Found In" field displayed for each
collection above the overview/abstract summary.

**Verification:**

Left-click the "Collections" link in the navigation bar, and in the resulting
list, verify that each entry has a "Found In" field above the "Abstract" field.

### Inventories Display

**Jira Issue(s):** LIBASPACE-214

When a collection has "External Documents", display an
"Inventories/Additional Information" panel at the top of the collapsed sections
of the collection page.

**Verification:**

(See LIBASPACE-214 for more detailed verification steps)

Local development: In the staff interface, edit the
"Archives of the Atlantic Monthly" entry, and add an "External Documents" entry.

Then in the public interface, verify that a collapsed
"Inventories/Additional Information" panel is shown in the collection page,
at the top of the other collapsed sections.

### Library Details Fix

**Jira Issue(s):** LIBASPACE-276

Removes an extraneous "Library" that stock ArchivesSpace adds to library names
in the "Library Details" panel on collections pages.

**Verification:**

(See LIBASPACE-276 for more detailed verification steps)

On a collections page, verify that in the "Library Detail" panel, the text
"Part of the" only displays the associated library name, without adding an
additional "Library".

For example, for a collection in the "Michelle Smith Performing Arts Library",
the text should be "Part of the Michelle Smith Performing Arts Library", *not*
"Michelle Smith Performing Arts Library Library".

### Matomo Analyics

**Jira Issue(s):** LIBASPACE-348, LIBASPACE-350

Adds the Matomo Analytics functionality to the public interface.

Verified most easily when running in Kubernetes, by accessing a web page, and
using the browser's "View Source" to examine the HTML source code, and verify
that the HTML “head” tag contains Matomo Analytics JavaScript, i.e.code similar to the following:

```javascript
    <!-- Matomo Analytics -->
    <script>
      var _paq = window._paq = window._paq || [];
      /* tracker methods like "setCustomDimension" should be called before "trackPageView" */
      ...
    </script>
```

### Navbar Links

**Jira Issue(s):** LIBASPACE-120, LIBASPACE-200

Added "Home" and "Help" links to the navigation bar. Since the "Help" link
is an absolute URL, some customization was necessary to only use the "app_prefix"
method if the URL is relative.

Verify that the navigation bar contains "Home" and "Help" links.

### Navbar Search

**Jira Issue(s):** LIBASPACE-117

Replaced the magnifying glass in the stock ArchivesSpace with a textbox and
magnifying glass that performs a keyword search.

Verify that the navigation bar contains a "Search" textbox with a magnifying
glass icon to the right.

### Request Instructions

**Jira Issue(s):** LIBASPACE-210

**Verification:**

(See LIBASPACE-210 for more detailed verification steps)

* On a collections page, verify that a blue banner with the text
  "Use the right side menu to identify relevant boxes and place requests."
  is displayed.

* Select one of the items in the collection, such that the Aeon "Request Box 1"
  button is shown. Left-click the "Request Box 1" button, and on the resulting
  page verify that a blue banner with the text
  "Click button below to request this box. You will be asked to register/sign in
  to your Special Collections Research Account to complete your request."
  is displayed.

### Resource Ids

**Jira Issue(s):** LIBASPACE-141

Simplified the display of resource identifier by removing the "Identifier:"
label added to them in stock ArchivesSpace. The identifier is only displayed
for "Collection", "Series", and "Subseries" types, and not for other types,
such as "File".

**Verification:**

(See LIBASPACE-141 for more additional and more detailed verification steps)

On a collection page, verify that under the collection title, appears an
icon and the word "Collection" immediately followed by an alpha-numeric
identifier. An "Identifier: " label should *not* be displayed.

### Search Box Image

**Jira Issue(s):** LIBASPACE-116

Modified the home page to show an image behind the search box.

Verify on the home page than an image (of hand-written documents) appears behind
the search box.

### Search Facets

**Jira Issue(s):** LIBASPACE-152

Removed the "Topic" facet.

Verify on the search results page that a "Topic" facet is not in the
"Additional filters" facet list.

### Search Stop-gap

**Jira Issue(s):** LIBASPACE-341

Removed the "+" button allowing additional search filters to be added to the
search box. This was done to as a stop-gap solution until a fix can be found
(see LIBASPACE-342).

Verify that the search panel on the home page does *not* contain a "+" button
next to the "To" field

### UMD Header

**Jira Issue(s):** LIBASPACE-110, LIBASPACE-137

Adds the university-mandated "University of Maryland"  to the top of all web
pages.

Verify that the "University of Maryland" header bar appears as the top of all
web pages.

### Website Feedback

**Jira Issue(s):** LIBASPACE-200

Verify that the page header contains "Help us improve our website" /
"Send feedback" text right-aligned in the same row as the UMD Libraries logo.
