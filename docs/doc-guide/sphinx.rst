.. _sphinxdoc:

=====================================
Using Sphinx for kernel documentation
=====================================

The Linux kernel uses `Sphinx`_ to generate pretty documentation from
`reStructuredText`_ files under ``Documentation``. To build the documentation in
HTML or PDF formats, use ``make htmldocs`` or ``make pdfdocs``. The generated
documentation is placed in ``Documentation/output``.

.. _Sphinx: http://www.sphinx-doc.org/
.. _reStructuredText: http://docutils.sourceforge.net/rst.html

The reStructuredText files may contain directives to include structured
documentation comments, or kernel-doc comments, from source files. Usually these
are used to describe the functions and types and design of the code. The
kernel-doc comments have some special structure and formatting, but beyond that
they are also treated as reStructuredText.

Finally, there are thousands of plain text documentation files scattered around
``Documentation``. Some of these will likely be converted to reStructuredText
over time, but the bulk of them will remain in plain text.

.. _sphinx_install:

Sphinx Install
==============

The ReST markups currently used by the Documentation/ files are meant to be
built with ``Sphinx`` version 1.7 or higher.

There's a script that checks for the Sphinx requirements. Please see
:ref:`sphinx-pre-install` for further details.

Most distributions are shipped with Sphinx, but its toolchain is fragile,
and it is not uncommon that upgrading it or some other Python packages
on your machine would cause the documentation build to break.

A way to avoid that is to use a different version than the one shipped
with your distributions. In order to do so, it is recommended to install
Sphinx inside a virtual environment, using ``virtualenv-3``
or ``virtualenv``, depending on how your distribution packaged Python 3.

.. note::

   #) It is recommended to use the RTD theme for html output. Depending
      on the Sphinx version, it should be installed separately,
      with ``pip install sphinx_rtd_theme``.

   #) Some ReST pages contain math expressions. Due to the way Sphinx works,
      those expressions are written using LaTeX notation. It needs texlive
      installed with amsfonts and amsmath in order to evaluate them.

In summary, if you want to install Sphinx version 2.4.4, you should do::

       $ virtualenv sphinx_2.4.4
       $ . sphinx_2.4.4/bin/activate
       (sphinx_2.4.4) $ pip install -r Documentation/sphinx/requirements.txt

After running ``. sphinx_2.4.4/bin/activate``, the prompt will change,
in order to indicate that you're using the new environment. If you
open a new shell, you need to rerun this command to enter again at
the virtual environment before building the documentation.

.. _sphinx-pre-install:

Checking for Sphinx dependencies
--------------------------------

There's a script that automatically check for Sphinx dependencies. If it can
recognize your distribution, it will also give a hint about the install
command line options for your distro::

	$ ./scripts/sphinx-pre-install
	Checking if the needed tools for Fedora release 26 (Twenty Six) are available
	Warning: better to also install "texlive-luatex85".
	You should run:

		sudo dnf install -y texlive-luatex85
		/usr/bin/virtualenv sphinx_2.4.4
		. sphinx_2.4.4/bin/activate
		pip install -r Documentation/sphinx/requirements.txt

	Can't build as 1 mandatory dependency is missing at ./scripts/sphinx-pre-install line 468.

By default, it checks all the requirements for both html and PDF, including
the requirements for images, math expressions and LaTeX build, and assumes
that a virtual Python environment will be used. The ones needed for html
builds are assumed to be mandatory; the others to be optional.

It supports two optional parameters:

``--no-pdf``
	Disable checks for PDF;

``--no-virtualenv``
	Use OS packaging for Sphinx instead of Python virtual environment.


Sphinx Build
============

The usual way to generate the documentation is to run ``make htmldocs`` or
``make pdfdocs``. There are also other formats available: see the documentation
section of ``make help``. The generated documentation is placed in
format-specific subdirectories under ``Documentation/output``.

To generate documentation, Sphinx (``sphinx-build``) must obviously be
installed. For prettier HTML output, the Read the Docs Sphinx theme
(``sphinx_rtd_theme``) is used if available. For PDF output you'll also need
``XeLaTeX`` and ``convert(1)`` from ImageMagick (https://www.imagemagick.org).
All of these are widely available and packaged in distributions.

To pass extra options to Sphinx, you can use the ``SPHINXOPTS`` make
variable. For example, use ``make SPHINXOPTS=-v htmldocs`` to get more verbose
output.

It is also possible to pass an extra DOCS_CSS overlay file, in order to customize
the html layout, by using the ``DOCS_CSS`` make variable.

By default, the build will try to use the Read the Docs sphinx theme:

    https://github.com/readthedocs/sphinx_rtd_theme

If the theme is not available, it will fall-back to the classic one.

The Sphinx theme can be overridden by using the ``DOCS_THEME`` make variable.

To remove the generated documentation, run ``make cleandocs``.

Writing Documentation
=====================

Adding new documentation can be as simple as:

1. Add a new ``.rst`` file somewhere under ``Documentation``.
2. Refer to it from the Sphinx main `TOC tree`_ in ``Documentation/index.rst``.

.. _TOC tree: http://www.sphinx-doc.org/en/stable/markup/toctree.html

This is usually good enough for simple documentation (like the one you're
reading right now), but for larger documents it may be advisable to create a
subdirectory (or use an existing one). For example, the graphics subsystem
documentation is under ``Documentation/gpu``, split to several ``.rst`` files,
and has a separate ``index.rst`` (with a ``toctree`` of its own) referenced from
the main index.

See the documentation for `Sphinx`_ and `reStructuredText`_ on what you can do
with them. In particular, the Sphinx `reStructuredText Primer`_ is a good place
to get started with reStructuredText. There are also some `Sphinx specific
markup constructs`_.

.. _reStructuredText Primer: http://www.sphinx-doc.org/en/stable/rest.html
.. _Sphinx specific markup constructs: http://www.sphinx-doc.org/en/stable/markup/index.html

Specific guidelines for the kernel documentation
------------------------------------------------

Here are some specific guidelines for the kernel documentation:

* Please don't go overboard with reStructuredText markup. Keep it
  simple. For the most part the documentation should be plain text with
  just enough consistency in formatting that it can be converted to
  other formats.

* Please keep the formatting changes minimal when converting existing
  documentation to reStructuredText.

* Also update the content, not just the formatting, when converting
  documentation.

* Please stick to this order of heading adornments:

  1. ``=`` with overline for document title::

       ==============
       Document title
       ==============

  2. ``=`` for chapters::

       Chapters
       ========

  3. ``-`` for sections::

       Section
       -------

  4. ``~`` for subsections::

       Subsection
       ~~~~~~~~~~

  Although RST doesn't mandate a specific order ("Rather than imposing a fixed
  number and order of section title adornment styles, the order enforced will be
  the order as encountered."), having the higher levels the same overall makes
  it easier to follow the documents.

* For inserting fixed width text blocks (for code examples, use case
  examples, etc.), use ``::`` for anything that doesn't really benefit
  from syntax highlighting, especially short snippets. Use
  ``.. code-block:: <language>`` for longer code blocks that benefit
  from highlighting. For a short snippet of code embedded in the text, use \`\`.
