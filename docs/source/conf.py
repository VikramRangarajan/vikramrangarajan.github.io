from pathlib import Path
import json

ROOT = Path(__file__).parent.parent.parent.absolute()

project = "Portfolio"
copyright = "2024, Vikram Rangarajan"
author = "Vikram Rangarajan"


extensions = ["sphinx_design"]

templates_path = ["_templates"]
exclude_patterns = []


with open(ROOT / "portfolio/portfolio.json") as f:
    por = json.load(f)

info = por["info"]
email = info["email"]
linkedin = info["linkedin"]
github = info["github"]
google_scholar = info["google_scholar"]
phone = info["phone"]

html_theme = "pydata_sphinx_theme"
html_sidebars = {"**": []}
html_theme_options = {
    "navigation_with_keys": False,
    "navbar_end": ["theme-switcher", "navbar-icon-links"],
    "github_url": github,
    "navbar_start": [],
    "logo": {
        "text": "Introduction",
    },
    "icon_links": [
        {
            "name": "LinkedIn",
            "url": linkedin,
            "icon": "fa-brands fa-linkedin",
            "type": "fontawesome",
        },
        {
            "name": "Email",
            "url": f"mailto:{email}",
            "icon": "fa-solid fa-envelope",
            "type": "fontawesome",
        },
        {
            "name": "Google Scholar",
            "url": google_scholar,
            "icon": "fa-brands fa-google-scholar",
            "type": "fontawesome",
        },
        {
            "name": "Phone",
            "url": phone,
            "icon": "fa-solid fa-phone",
            "type": "fontawesome",
        },
    ],
    "footer_end": [],
    "search_bar_text": "Search the Portfolio...",
}
html_static_path = ["_static"]
html_show_sphinx = False
html_show_sourcelink = False
