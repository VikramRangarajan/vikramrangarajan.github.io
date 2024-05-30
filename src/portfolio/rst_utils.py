def title(f, t: str):
    f.write("=" * len(t) + "\n")
    f.write(t + "\n")
    f.write("=" * len(t) + "\n\n")


def subtitle(f, t: str):
    f.write(t + "\n")
    f.write("=" * len(t) + "\n\n")


def indexes_and_tables(f):
    f.write("* :ref:`genindex`\n\n")


def card(f, title=None, body=None, link=None, indent=0):
    indent = "\t" * indent
    f.write(indent + ".. card::")
    if title is not None:
        f.write(" " + title)
    if body is None and link is None:
        f.write("\n\n")
    else:
        if link is not None:
            f.write(f"\n\t{indent}:link: {link}")

            if body is None:
                f.write("\n\n")
        
        if body is not None:
            body = body.replace("\n", indent + "\n\n\t")
            f.write(f"\n\n\t{indent}{body}\n\n")

def card_carousel(f, titles: list, bodies: list, links: list, num_show=5):
    f.write(f".. card-carousel:: {num_show}\n\n")
    for title, body, link in zip(titles, bodies, links):
        card(f, title, body, link, indent=1)