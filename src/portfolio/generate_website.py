import os
import json
from pathlib import Path
from rst_utils import title, subtitle, card, card_carousel
from docx_utils import ddict
import re

ROOT = Path(__file__).parent.parent.parent.absolute()

if os.path.exists(ROOT / "docs/source/index.rst"):
    os.remove(ROOT / "docs/source/index.rst")
f = open(ROOT / "docs/source/index.rst", "w")
title(f, "Vikram Rangarajan - Portfolio")


with open(ROOT / "src/portfolio/portfolio.json") as portfolio_file:
    por = ddict(json.load(portfolio_file))


# Education Section
subtitle(f, "Education")
education = por.current.education
for edu in education:
    time = edu["start"]
    if edu["end"] is None:
        time += " to Present, Expected " + edu["expected"]
    else:
        time += " to " + edu["end"]
    card(
        f,
        f"{edu['name']} - {time}",
        f"Degree: {edu['degree']}\nMajor: {edu['major']}\nMinor: {edu['minor']}\nGPA: {edu['GPA']}",
    )

# Experience Section
subtitle(f, "Experience & Projects")
experiences = por.current.experience
for exp in experiences:
    end = exp["end"] if exp["end"] is not None else "Present"
    body_text = ""
    if exp["title"] is not None:
        body_text += exp["title"]
    if exp["description"] is not None:
        body_text += "\n" + exp["description"]
    card(
        f,
        f"{exp['company-name']} - {exp['start']} to {end}",
        body_text,
        exp["title_link"],
    )

# Skills Section
skill_groups = por.current.skills
subtitle(f, "Technical Skills")
for skill_group in skill_groups.keys():
    skills = skill_groups[skill_group]
    name = re.sub("[^0-9a-zA-Z]+", " ", skill_group)

    f.write(f"{name.capitalize()}\n\n")
    card_carousel(f, skills, [None] * len(skills), [None] * len(skills))

# Awards Section
subtitle(f, "Awards & Certifications")
awards = por.current.awards
for awd in awards:
    card(
        f,
        f"{awd['name']} - {awd['date']}",
        None,
        awd["link"],
    )
f.close()
