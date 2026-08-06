% Freezing a GitHub repository and minting a Zenodo DOI
% Step by step instruction, web browser only
% 2026-08-06

The whole procedure below is done in a web browser. No git client, no command line and no local tooling are required. The only step performed outside the browser is the optional test run of the downloaded code in Section 2.

# 1. What you will obtain

Zenodo (operated by CERN and OpenAIRE) takes a snapshot of your repository at the moment a GitHub release is published, stores it as a ZIP archive and mints a DOI. After the first release you have two identifiers:

| Identifier | Meaning | Typical use |
|---|---|---|
| Concept DOI | Always resolves to the newest version of the record | Put it in the README so readers reach the current code |
| Version DOI | Resolves to one frozen release, for example v1.0.0 | Cite in the manuscript, because it guarantees reproducibility |

Zenodo shows the concept DOI as the DOI of "all versions" on the record page.

One limitation of the automatic integration: a DOI cannot be reserved in advance for a GitHub release, and a repository cannot be attached to an already existing concept DOI. The DOI appears only after the release has been processed. If the manuscript must contain the DOI before the code is frozen, use the manual route in Section 11.

# 2. Prepare the repository (GitHub web interface)

Do this before you release anything. Archived files cannot be changed afterwards, they can only be superseded by a new version.

## 2.1 Remove what must not be published

Open the file in the repository, click the pencil icon to edit it or the trash icon to delete it, then commit the change directly to the default branch.

Check for: passwords, API keys and tokens, unpublished data belonging to other people, absolute paths containing personal names, large intermediate result files.

Deleting a file in a new commit does not remove it from the commit history, and Zenodo archives only the snapshot of the tagged state, not the history. Still, the history remains visible on GitHub. If a credential was ever committed, treat it as compromised and revoke it. Rewriting history is not possible from the web interface.

## 2.2 Check the size of the deposit

Click the green **Code** button, then **Download ZIP**, and look at the size of the downloaded file. Zenodo accepts up to 50 GB per record, but a code archive should normally stay in the range of megabytes. Move large datasets and binaries out of the repository and deposit them as a separate Zenodo dataset record, linked later through the related identifiers field.

## 2.3 Add a license

1. Click **Add file**, then **Create new file**.
2. Type `LICENSE` as the file name. GitHub then offers a **Choose a license template** button on the right.
3. Pick the license (MIT, BSD 3-Clause, Apache 2.0 and GPL 3.0 are the usual choices for scientific code), fill in the year and your name, and commit.

Without an explicit license the code is legally "all rights reserved", and many journals reject such deposits.

## 2.4 Write the README

Edit `README.md` with the pencil icon. A reader who has never seen the project should find there: the required software and its versions (for example Octave 9.x and the packages used), where the input data come from, which script reproduces the main figures or tables, and the expected runtime.

## 2.5 Verify that the archive is self contained

Download the ZIP through **Code**, then **Download ZIP**, unpack it into an empty directory on your computer and run the main script there. This is the same archive that Zenodo will store, so anything missing here will be missing in the deposit.

Keep in mind what the GitHub source archive does not contain: git submodules, files excluded by `export-ignore` rules in `.gitattributes`, and Git LFS content (only the LFS pointer files are archived). If you rely on any of these, copy the required content into the repository as ordinary files, or attach the missing files by hand to the Zenodo record after publication.

## 2.6 Make the repository public

Go to **Settings**, section **General**, area **Danger Zone**, then **Change visibility** and set it to public. Zenodo archives releases of public repositories only.

# 3. Add the citation metadata files

Zenodo reads two optional files from the root of the repository: `CITATION.cff` and `.zenodo.json`.

Precedence rule: when both files are present, Zenodo uses **only** `.zenodo.json` and ignores `CITATION.cff` entirely for the GitHub release. Add `.zenodo.json` only if you need Zenodo specific fields such as grants, communities or related identifiers. In every other case `CITATION.cff` alone is sufficient, and it has the extra benefit that GitHub renders a "Cite this repository" button from it.

## 3.1 CITATION.cff

In the repository click **Add file**, then **Create new file**, type `CITATION.cff` as the name and paste the content:

```yaml
cff-version: 1.2.0
message: "If you use this software, please cite it as below."
type: software
title: "Short descriptive title of the software"
abstract: "One paragraph describing what the code does."
authors:
  - family-names: "Kowalski"
    given-names: "Jan"
    orcid: "https://orcid.org/0000-0000-0000-0000"
    affiliation: "Warsaw University of Technology"
version: "1.0.0"
date-released: "2026-08-06"
license: MIT
repository-code: "https://github.com/USER/REPO"
keywords:
  - numerical simulation
  - octave
```

Then commit the file to the default branch.

Points to watch:

* `date-released` must use the YYYY-MM-DD format.
* Add the `doi:` field only after the first DOI exists, see Section 9.
* After the commit, GitHub parses the file. A valid file produces a **Cite this repository** button in the About panel on the right of the repository page. A parsing error is reported in a yellow banner above the file listing. Treat the appearance of that button as the confirmation that the syntax is correct.
* If you prefer a guided editor, generate the file at `https://citation-file-format.github.io/cff-initializer-javascript/` and paste the result into GitHub.

## 3.2 .zenodo.json (optional)

Same procedure: **Add file**, then **Create new file**, name it `.zenodo.json`.

```json
{
    "upload_type": "software",
    "title": "Short descriptive title of the software",
    "version": "1.0.0",
    "access_right": "open",
    "license": "mit",
    "language": "eng",
    "creators": [
        {
            "name": "Kowalski, Jan",
            "orcid": "0000-0000-0000-0000",
            "affiliation": "Warsaw University of Technology"
        }
    ],
    "keywords": [
        "numerical simulation",
        "octave"
    ],
    "related_identifiers": [
        {
            "identifier": "10.1000/journal.article.doi",
            "relation": "isSupplementTo",
            "resource_type": "publication-article"
        }
    ],
    "grants": [
        {"id": "10.13039/501100000780::101122956"}
    ],
    "communities": [
        {"identifier": "your-community-identifier"}
    ]
}
```

If this file is structurally invalid or contains invalid values, the release processing fails and nothing is published on Zenodo. Before committing, paste the content into an online JSON validator (for example `https://jsonlint.com`) and confirm that it parses.

Both metadata files must be committed before the release is created, otherwise they will not be part of the frozen snapshot and Zenodo will not see them.

# 4. Connect your Zenodo account to GitHub

1. Open `https://zenodo.org` and log in, either with a Zenodo account or directly through GitHub.
2. Click the profile menu in the header and choose **GitHub**.
3. If the accounts are not linked yet, Zenodo redirects you to GitHub and asks for authorization. Accept the requested permissions. They allow Zenodo to install the release webhook in your repositories.
4. Recommended: in the Zenodo profile settings link your ORCID as well, so that deposits are attributed to you automatically.

# 5. Enable the repository in Zenodo

1. On the Zenodo GitHub page click **Sync now** in the header to refresh the list of your repositories.
2. Find the repository and move its slider to the ON position.
3. Refresh the page and confirm that the repository is listed among the enabled ones.

If the repository is not listed, check that it is public, that you have admin rights to it, and, for repositories owned by an organization, that the organization owner has granted third party access to Zenodo.

The webhook works from this moment on. Releases published before enabling are not archived retroactively.

# 6. Create the tag and publish the GitHub release

In the web interface the tag is created together with the release, in one form.

1. Open the repository page and click **Releases** in the right sidebar (or the **Releases** section under the About panel).
2. Click **Draft a new release**.
3. Click **Choose a tag**, type the new tag name, for example `v1.0.0`, and select **Create new tag: v1.0.0 on publish**. Use semantic versioning and start with `v1.0.0` for the version accompanying the manuscript.
4. Leave the target branch at the default branch, unless you deliberately freeze another branch.
5. Fill in the release title, for example `v1.0.0`.
6. Write the release notes: what the code does, which manuscript it belongs to, what changed since the previous version. You may use **Generate release notes** and then edit the result.
7. Leave **Set as a pre-release** unchecked for the final archival version.
8. Do not use **Save draft**. A draft does not trigger Zenodo. Click **Publish release**.

Once published, note the commit the tag points to. It is shown next to the tag name on the release page.

# 7. Verify the Zenodo record and complete the metadata

1. Wait a few minutes. Ingestion time depends on the archive size and the current load on Zenodo.
2. Go back to the Zenodo GitHub page. The release appears under the repository entry together with its DOI. The record is also visible under **My dashboard**, section uploads.
3. Open the record and check: title, list of authors and their order, ORCID identifiers, affiliations, description, license, version, resource type (Software), and the link back to the GitHub repository.
4. If the metadata harvested from GitHub is incomplete, click **Edit**, correct the fields and click **Publish** again. Metadata can be corrected at any time. Files cannot be changed after publication.
5. In the record page, look at **External resources** and check the archival status in Software Heritage, which provides an additional preservation copy.

If the release does not appear on the Zenodo GitHub page, or appears with an error, open the failed entry and read the message. The most frequent cause is an invalid `.zenodo.json` or `CITATION.cff`. Correct the file in GitHub, then remove the failed release and its tag and repeat Section 6:

1. Open **Releases**, select the release, click **Edit** (pencil icon) and then **Delete this release**.
2. Open the **Tags** tab on the same page, find the tag, open the three dots menu next to it and choose **Delete tag**.

# 8. Publish the DOI in the repository

Copy both identifiers from the Zenodo record page: the concept DOI (labelled as covering all versions) and the version DOI.

Edit `README.md` with the pencil icon and add the badge at the top:

```markdown
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.1234567.svg)](https://doi.org/10.5281/zenodo.1234567)
```

Add a citation section at the end of `README.md`:

```markdown
## How to cite

Kowalski, J. (2026). Short descriptive title of the software (v1.0.0)
[Computer software]. Zenodo. https://doi.org/10.5281/zenodo.1234568
```

Edit `CITATION.cff` and add the concept DOI:

```yaml
doi: 10.5281/zenodo.1234567
```

These commits are made after the release, so they enter the archive only with the next version. This is normal practice and nobody expects the first archived snapshot to contain its own DOI.

# 9. Publishing a corrected or extended version later

1. Commit the code changes to the default branch through the web editor.
2. Update `version` and `date-released` in `CITATION.cff`, and `version` in `.zenodo.json` if you use it. Reusing the same version string across releases produces several Zenodo versions carrying identical version labels, which confuses readers.
3. Draft a new release with a new tag, for example `v1.1.0`, and publish it as in Section 6.
4. Zenodo adds a new version to the existing record, mints a new version DOI and keeps the concept DOI pointing to the newest version.

Never reuse a tag name that has already been released.

# 10. What to put in the manuscript

Cite the version DOI of the exact release used to produce the reported results, and give the repository URL next to it. Example of a data availability statement:

> The code used in this study is openly available at `https://github.com/USER/REPO` and archived at Zenodo, https://doi.org/10.5281/zenodo.1234568 (version v1.0.0).

# 11. Alternative route when the DOI is needed before the release

Journals often ask for the DOI at submission, before the code is frozen. In that case bypass the automatic integration for the first deposit.

1. In Zenodo click **New upload**.
2. Fill in the metadata: title, authors with ORCID, description, license, resource type Software.
3. In the DOI field click **Reserve DOI**. Zenodo displays the DOI immediately, and you can put it in the manuscript, in `README.md` and in `CITATION.cff`.
4. Commit those files in GitHub, then create and publish the release as in Section 6.
5. On the release page in GitHub, right click the **Source code (zip)** link and download the archive.
6. Return to the Zenodo upload, drag the ZIP file into the files area and click **Publish**.

A record created this way is not connected to the GitHub webhook, and it cannot be attached to the automatic integration afterwards. Every later version has to be uploaded by hand with the **New version** button on the record page.

# 12. Final checklist

* Credentials, private data and large binaries removed from the repository.
* `LICENSE` present and consistent with the license declared in the metadata.
* `README.md` explains dependencies, input data and the command reproducing the main results.
* Downloaded ZIP unpacked into an empty directory and the main script executed successfully.
* `CITATION.cff` committed and accepted by GitHub (the "Cite this repository" button is visible). `.zenodo.json` added only if Zenodo specific fields are needed, and validated as JSON.
* Repository public, Zenodo account linked to GitHub, repository slider set to ON in Zenodo.
* Release published, not left as a draft.
* Zenodo record verified: authors, ORCID, license, version, resource type Software.
* Concept DOI and version DOI copied, badge and citation section added to `README.md`, `doi:` added to `CITATION.cff`.
* Version DOI of the exact release quoted in the manuscript.
