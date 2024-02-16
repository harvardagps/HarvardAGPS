# Custom config (resource file) for BibTool.
#
# Usage (bash):
#   $ bibtool -r bibtool-config some.bib
#   $ bibtool -r bibtool-config some.bib -o new.bib
#   $ bibtool -r bibtool-config some.bib -o some.bib
#   $ bibtool -X "^key$" -r bibtool-config some.bib
#   $ bibtool -X "entryKeyRegex" -r bibtool-config some.bib
#   $ bibtool -X "entryKeyContainsThisValue" -r bibtool-config some.bib
#   $ bibtool -X "^entrykeyIsExactlyThisValue$" -r bibtool-config some.bib
#
# Worflow (VS Code + LaTeX Workshop by James-Yu + Smart-Title-Case by awtnb):
#   1) Open .bib file.
#   2) Type @... to create bib entry using snippet (or paste an entry).
#   3) Title Case and {ProtectWords}.
#   4) Save .bib file (entry key will be 'key').
#   5) In a terminal run:
#        $ bibtool -r bibtool-config some.bib -o some.bib
#   6) Enjoy:
#        auto generated key,
#        formatting, sorting, and standardisation, and
#        compare the diff using version control.
#   7) Rename the article pdf to use key.pdf.

# Start by including BibTool's default resource file.
resource default

# Include BibLaTeX resource file.
resource biblatex

# Keep only the BibLaTeX entry types and attributes listed, delete the rest.
resource keep_biblatex

# Replace "" with {}.
resource braces

# Configuration (resource commands) that vary from previously included resources. #

#
# General
#
sort                     = on
sort.cased               = on
print.align.key          = 18 # Default: 18, alternate: 0.
print.use.tab            = off
suppress.initial.newline = on
pass.comments            = on
# Duplicate (double) entries.
# These don't work when key generation is turned on in the same run
# since keys are first disambiguated with key*1.
# Hint: key*1 shows duplicates directly in use with a sufficently complex key.format.
check.double             = on
check.double.delete      = on
print.deleted.prefix     = "###"
print.deleted.entries    = on

#
# Field types and field rewrites.
#
symbol.type = cased # lower, upper, cased

keep.field {{
    ids
    options
    author
    title
    date
    urldate
    address
    sortname
    shortauthor
    shorttitle
    journal
    journaltitleaddon
    publisher
}}

new.field.type { ids = IDs }
new.field.type { year = Date }
new.field.type { location = Address }
new.field.type { options = Options }
new.field.type { journal = Journal }
new.field.type { journaltitle = Journal }
new.field.type { journaltitleaddon = JournalTitleAddon }

# Field ordering within entries.
# * = all entry types.
# Fields not listed are placed after those listed in the same order as found in the entry.
sort.order {* =
      ids
    # options
    # sortkey
    # sortname
    # shortauthor
    # author
    # editor
    # date
    # year
    # shorttitle
    # title
    # booktitle
    # shortjournal
    # journal
    # journaltitleaddon
    # publisher
    # location
    # address
    # edition
    # volume
    # number
    # pages
    # part
    # url
    # urldate
}

#
# Keys
#
key.generation           = on
key.make.alias           = off
preserve.keys            = off
preserve.key.case        = on
default.key              = "key"
key.number.separator     = "*"
key.base                 = digit
fmt.name.name            = ""
fmt.inter.name           = ""
fmt.et.al                = "EtAl"
fmt.name.title           = "-"
ignored.word for
ignored.word to
ignored.word and
ignored.word of
ignored.word in

# Generate a key from field values in the following order of preference:
# FirstAuthorYearThreeWordsOfTitle
# FirstEditorYearThreeWordsOfTitle
# ThreeWordsOfTitleYear
# Note: Year is taken from date field, then year field, then literal text 'Nd'.
# Note: Author/Editor/Title are sometimes automatically substituted by BibTool.
# Note: shortauthor, shorttitle etc provide additional override capability.
key.format =
{
    {
        { %1n(shortauthor)
        # %1n(author)
        # %1n(shorteditor)
        # %1n(editor)
        # %1n(translator)
        }
        { %d(date)
        # %d(year)
        # Nd
        }
        { %3.6W(shorttitle)
        # %3.6W(title)
        #
        }
    }
    #
    {
        { %3.6W(shorttitle)
        # %3.6W(title)
        }
        { %d(date)
        # %d(year)
        # Nd
        }
    }
}
