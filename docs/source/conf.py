# Configuration file for the Sphinx documentation builder.
#
# For the full list of built-in configuration values, see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

# -- Project information -----------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#project-information

project = 'Portfolio'
copyright = '2024, Vikram Rangarajan'
author = 'Vikram Rangarajan'

# -- General configuration ---------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#general-configuration

extensions = []

templates_path = ['_templates']
exclude_patterns = []



# -- Options for HTML output -------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#options-for-html-output

html_theme = "pydata_sphinx_theme"
html_theme_options = {
    "navigation_with_keys": True,
    "navbar_end": ["theme-switcher", "navbar-icon-links"],
    "github_url": "https://github.com/VikramRangarajan/",
    "logo": {
        "text": "Portfolio",
    },
    # "navigation_depth": -1,
    "icon_links": [
        {
            "name": "LinkedIn",
            "url": "https://www.linkedin.com/in/vikram-rangarajan/",
            "icon": "fa-brands fa-linkedin",
            "type": "fontawesome",
        },
    ],
}
html_static_path = ['_static']
