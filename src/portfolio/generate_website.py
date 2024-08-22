from pathlib import Path
import re

from rst_utils import title, subtitle, card, card_carousel
from generate_resume import create_docx, docx_to_pdf
from data import WholePortfolio, str_date

ROOT = Path(__file__).parent.parent.parent.absolute()

f = open(ROOT / "docs" / "source" / "index.rst", "w")
title(f, "Vikram Rangarajan - Portfolio")


with open(ROOT / "src" / "portfolio" / "portfolio.json") as portfolio_file:
    por = WholePortfolio.model_validate_json(portfolio_file.read())


# Education Section
subtitle(f, "Education")
education = por.current.education
if education is not None:
    for edu in education:
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
experiences = por.current.experience
if experiences is not None:
    for exp in experiences:
        end = str_date(exp.end) if exp.end is not None else "Present"
        body_text = ""
        if exp.title is not None:
            body_text += exp.title
        if exp.description is not None:
            body_text += "\n" + exp.description
        card(
            f,
            f"{exp.company_name} - {str_date(exp.start)} to {end}",
            body_text,
            exp.title_link,
        )

# Skills Section
skills = por.current.skills
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
awards = por.current.awards
if awards is not None:
    subtitle(f, "Awards & Certifications")
    for awd in awards:
        awd_date = awd.date if isinstance(awd.date, str) else str_date(awd.date)
        card(
            f,
            f"{awd.name} - {awd_date}",
            None,
            awd.link,
        )


# Create Publications tab
if por.current.publications is not None:
    f.write("\n.. toctree::\n\t:hidden:\n\n\tpublications")
    with open(ROOT / "docs" / "source" / "publications.rst", "w") as pub_file:
        title(pub_file, "Publications")
        for pub in por.current.publications:
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
create_docx(ROOT / "docs" / "source" / "_static" / "resume.docx")
docx_to_pdf(ROOT / "docs" / "source" / "_static" / "resume.docx")
