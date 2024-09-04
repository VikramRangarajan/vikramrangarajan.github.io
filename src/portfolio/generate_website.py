from pathlib import Path
import re
import os

from rst_utils import title, subtitle, card, card_carousel
from generate_resume import create_docx, docx_to_pdf
from data import Portfolio, str_date, Margins, DocxConfig

ROOT = Path(__file__).parent.parent.parent.absolute()

f = open(ROOT / "docs" / "source" / "index.rst", "w")
title(f, "Vikram Rangarajan - Portfolio")


with open(ROOT / "src" / "portfolio" / "portfolio.json") as portfolio_file:
    por = Portfolio.model_validate_json(portfolio_file.read())


# Education Section
subtitle(f, "Education")
education = por.education
if education is not None:
    for edu in education:
        if edu.current is False:
            continue
        time = str_date(edu.start)
        if edu.end is None and edu.expected is not None:
            time += " to Present, Expected " + str_date(edu.expected)
        elif edu.end is not None:
            time += " to " + str_date(edu.end)
        card(
            f,
            f"{edu.name} - {time}",
            f"Degree: {edu.degree}\nMajor: {edu.major}\nMinor: {edu.minor}\nGPA: {edu.GPA}",
        )

# Experience Section
subtitle(f, "Experience & Projects")
experiences = por.experience
if experiences is not None:
    for exp in experiences:
        if exp.current is False:
            continue
        end = str_date(exp.end) if exp.end is not None else "Present"
        body_text = ""
        if exp.title is not None:
            body_text += exp.title
        if exp.description is not None:
            body_text += "\n" + "\n".join(exp.description)
        card(
            f,
            f"{exp.company_name} - {str_date(exp.start)} to {end}",
            body_text,
            exp.title_link,
        )

# Skills Section
skills = por.skills
if skills is not None:
    subtitle(f, "Technical Skills")
    for name in skills.keys():
        skill_group = skills[name]
        name: str = re.sub("[^0-9a-zA-Z]+", " ", name)
        f.write(f"{name.capitalize()}\n\n")
        card_carousel(
            f, skill_group, [None] * len(skill_group), [None] * len(skill_group), 2
        )

# Awards Section
awards = por.awards
if awards is not None:
    subtitle(f, "Awards & Certifications")
    for awd in awards:
        if awd.current is False:
            continue
        awd_date = awd.date if isinstance(awd.date, str) else str_date(awd.date)
        card(
            f,
            f"{awd.name} - {awd_date}",
            None,
            awd.link,
        )


# Create Publications tab
if por.publications is not None:
    f.write("\n.. toctree::\n\t:hidden:\n\n\tpublications")
    with open(ROOT / "docs" / "source" / "publications.rst", "w") as pub_file:
        title(pub_file, "Publications")
        for pub in por.publications:
            authors_str = ", ".join(pub.authors)
            authors_str = authors_str.replace(por.info.name, f"**{por.info.name}**")
            if pub.journal is not None:
                authors_str += f"\nIn {pub.journal}"
            if "published" not in pub.status.lower():
                authors_str += f"\n{pub.status}"
            if pub.date is not None:
                authors_str += str_date(pub.date)
            card(pub_file, pub.title, authors_str, pub.link)


f.write("\n.. toctree::\n\t:hidden:\n\n\tresumes")

# Create Resumes tab
with open(ROOT / "docs" / "source" / "resumes.rst", "w") as res_file:
    title(res_file, "Resume Downloads")
    res_file.write("\n:download:`PDF <_static/resume.pdf>`\n")
    res_file.write("\n:download:`DOCX <_static/resume.docx>`\n\n")
    res_file.write(".. pdf-include:: _static/resume.pdf#view=Fit")

f.close()

# Generate Resume Documents
if not os.path.exists(ROOT / "docs" / "source" / "_static"):
    os.mkdir(ROOT / "docs" / "source" / "_static")
docx_config = DocxConfig(
    margins=Margins(top=0.75, bottom=0.75, left=0.75, right=0.75),
    title_font_size=20,
    heading_font_size=14,
    text_font_size=11,
)
create_docx(ROOT / "docs" / "source" / "_static" / "resume.docx", docx_config)
docx_to_pdf(ROOT / "docs" / "source" / "_static" / "resume.docx")
