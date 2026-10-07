# Research Software Engineering

<!--
This file is the landing page of the website. Give every document in latex/
an entry with these three parts: the title, as a link to the PDF in pdf/, and
a short description. `make check` verifies that every PDF is linked here.
-->

## [Design Principles for Research Software](pdf/Design_Principles_for_Research_Software.pdf)

Guidelines for research software, in academia and in industry, from a one-off
script to the libraries and workflows that a community or a company relies
on, in any programming language and scientific field. Research software
stands on a ladder, and the principles are what it takes to climb it. Most are
general software engineering principles, stated for a setting where the
typical failure is not a crash but a plausible, wrong number.

## [Testing Research Software](pdf/Testing_Research_Software.pdf)

How to test research software: where the expected values of tests come from,
how to write tests that catch a plausible, wrong number, and how to keep a
test suite honest as the code changes. Short principles, meant for looking
things up while working.

## [Documenting Research Software](pdf/Documenting_Research_Software.pdf)

How to document research software: which documents a package needs and for
which readers, how to write the reference, the changelog, and the citation,
and how to keep documentation true as the code changes, so that users do not
report a method the software no longer computes. Short principles, meant for
looking things up while working.

## [Types of Research Software Tests](pdf/Types_of_Research_Software_Tests.pdf)

The types of tests for research software, and the terms of testing that the
other documents use. Every test makes three choices: its scope, its
inputs, and its oracle. For each type, the same fields say what it is, what
it catches, what it misses, and what it pairs with, and a table explains
common names such as smoke test and regression test.
