from pathlib import Path
from importlib.util import spec_from_file_location, module_from_spec

ROOT = Path(__file__).parent.parent.parent.absolute()

spec = spec_from_file_location("data", ROOT / "src" / "portfolio" / "data.py")
if spec is None or spec.loader is None:
    raise ImportError()
data = module_from_spec(spec)
spec.loader.exec_module(data)

project = "Portfolio"
copyright = "2024, Vikram Rangarajan"
author = "Vikram Rangarajan"


extensions = [
    "sphinx_design",
    "sphinx_simplepdf",
]

templates_path = ["_templates"]
exclude_patterns = []


with open(ROOT / "src/portfolio/portfolio.json") as f:
    por = data.WholePortfolio.model_validate_json(f.read())

info = por.info
email = info.email
phone = info.phone
linkedin = info.linkedin
github = info.github

html_theme = "pydata_sphinx_theme"
html_sidebars = {
    "**": []
}
html_theme_options = {
    "navigation_with_keys": False,
    "navbar_end": ["theme-switcher", "navbar-icon-links"],
    "github_url": github,
    "logo": {
        "text": "Portfolio",
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
            "name": "Phone",
            "url": f"tel:{phone}",
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
