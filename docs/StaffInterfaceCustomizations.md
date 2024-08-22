# ArchivesSpace Customizations - Staff Interface

## Introduction

This document describes the UMD customizations made to the ArchivesSpace
staff ("frontend") interface.

## Overridden ArchivesSpace Files

The following stock ArchivesSpace files have been overridden to support UMD
customizations.

When updating ArchivesSpace, these files should be modified to incorporate any
updates from the stock ArchivesSpace files, while maintaining the UMD
customizations.

**Note:** Only files present in stock ArchivesSpace are listed in the table.

| File                                         | Functionality      |
| -------------------------------------------- | ------------------ |
| frontend/views/layouts/application.html.erb  | Environment Banner |
| frontend/views/site/_branding.html.erb       | Navbar Branding    |
| frontend/views/site/_footer.html.erb         | Custom Footer      |

## Functionality

### Custom Footer

**Jira Issue(s):** LIBASPACE-151

Verify that a "Web Accessibility" link appears in the footer.

### Environment Banner

**Jira Issue(s):** LIBASPACE-29

In accordance with SSDR policy an "environment banner" is displayed on all
non-production web applications.

To verify, run ArchivesSpace on a non-production system (local, test, or qa),
and verify that an environment banner is shown.

### Navbar Branding

**Jira Issue(s):** LIBASPACE-42

Verify that the UMD Libaries logo appears in the navigation bar
