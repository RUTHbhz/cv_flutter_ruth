from pathlib import Path
from PIL import Image, ImageDraw, ImageFont, ImageOps

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / "screenshots"
ASSETS = ROOT / "assets" / "portraits"
W, H = 390, 844
INK = "#0D1011"
PAPER = "#F4F9FC"
COPPER = "#C87843"
COPPER_LIGHT = "#E3A06D"
MUTED = "#718087"


def font(size, bold=False):
    path = "C:/Windows/Fonts/arialbd.ttf" if bold else "C:/Windows/Fonts/arial.ttf"
    return ImageFont.truetype(path, size)


def canvas():
    return Image.new("RGB", (W, H), PAPER)


def text(draw, xy, value, size, fill=INK, bold=False, anchor=None):
    draw.text(xy, value, font=font(size, bold), fill=fill, anchor=anchor)


def avatar(path, size):
    image = ImageOps.fit(Image.open(path).convert("RGB"), (size, size), centering=(0.5, 0.42))
    mask = Image.new("L", (size, size), 0)
    ImageDraw.Draw(mask).ellipse((0, 0, size - 1, size - 1), fill=255)
    return image, mask


def header(draw, title):
    text(draw, (24, 44), title, 11, COPPER, True)
    draw.rounded_rectangle((326, 62, 374, 110), radius=16, fill=INK)
    text(draw, (350, 86), "BBR", 12, COPPER_LIGHT, True, "mm")


def bottom_nav(draw, selected):
    draw.rectangle((0, 764, W, H), fill="white")
    labels = [(82, "Accueil"), (195, "Famille"), (308, "Contact")]
    for index, (x, label) in enumerate(labels):
        if index == selected:
            draw.rounded_rectangle((x - 48, 784, x + 48, 832), radius=24, fill="#F8E9DE")
        text(draw, (x, 808), "⌂" if index == 0 else ("●" if index == 1 else "@"), 27, COPPER if index == selected else "#62564F", True, "mm")
        text(draw, (x, 850), label, 13, "#62564F", False, "mm")


def family_capture():
    image = canvas()
    draw = ImageDraw.Draw(image)
    header(draw, "MA FAMILLE")
    text(draw, (24, 165), "Une famille,", 34, INK, True)
    text(draw, (24, 202), "une force.", 34, INK, True)
    text(draw, (24, 231), "Les personnes qui m’inspirent au quotidien.", 15, MUTED)
    members = [
        ("KABERA", "Maman · Commerçante", "family-mother.jpeg"),
        ("BAHIZI", "Papa · Enseignant", "family-father.jpeg"),
        ("BAKUNZI", "Sœur · Comptable", "family-sister.jpeg"),
        ("NISHIMWE", "Frère · Ingénieur", "family-brother.jpeg"),
    ]
    for index, (name, relation, filename) in enumerate(members):
        top = 266 + index * 94
        draw.rounded_rectangle((24, top, 366, top + 82), radius=20, fill="white")
        photo, mask = avatar(ASSETS / filename, 52)
        image.paste(photo, (43, top + 15), mask)
        text(draw, (111, top + 36), name, 15, INK, True, "lm")
        text(draw, (111, top + 58), relation, 13, MUTED, False, "lm")
        text(draw, (348, top + 41), "›", 29, COPPER, False, "mm")
    bottom_nav(draw, 1)
    image.save(OUT / "03-family.png")


def login_capture():
    image = canvas()
    draw = ImageDraw.Draw(image)
    draw.rounded_rectangle((26, 90, 78, 142), radius=17, fill=INK)
    text(draw, (52, 116), "R", 26, COPPER_LIGHT, True, "mm")
    text(draw, (26, 215), "Bienvenue.", 38, INK, True)
    text(draw, (26, 252), "Découvrez mon univers professionnel", 16, MUTED)
    text(draw, (26, 276), "et personnel.", 16, MUTED)
    text(draw, (26, 333), "IDENTIFIANT", 11, MUTED, True)
    draw.rounded_rectangle((26, 345, 364, 407), radius=16, fill="white")
    text(draw, (64, 376), "Identifiant", 15, MUTED, False, "lm")
    text(draw, (26, 445), "MOT DE PASSE", 11, MUTED, True)
    draw.rounded_rectangle((26, 457, 364, 519), radius=16, fill="white")
    text(draw, (64, 488), "••••••••", 15, MUTED, False, "lm")
    draw.rounded_rectangle((26, 545, 364, 601), radius=16, fill=INK)
    text(draw, (195, 573), "Se connecter", 16, PAPER, True, "mm")
    text(draw, (195, 650), "CV personnel • Goma · RDC", 12, MUTED, False, "mm")
    image.save(OUT / "01-login-latest.png")


def accueil_capture():
    image = canvas()
    draw = ImageDraw.Draw(image)
    header(draw, "ACCUEIL")
    photo, mask = avatar(ASSETS / "ruth-profile.jpeg", 96)
    image.paste(photo, (24, 130), mask)
    text(draw, (138, 158), "Ruth Bwiza", 22, INK, True, "lm")
    text(draw, (138, 184), "Bahizi", 22, INK, True, "lm")
    text(draw, (138, 207), "Étudiante en Génie Logiciel", 12, MUTED, False, "lm")
    text(draw, (24, 277), "IDENTITÉ", 11, COPPER, True)
    draw.rounded_rectangle((24, 292, 366, 442), radius=20, fill="white")
    rows = [("Nom complet", "BWIZA BAHIZI RUTH"), ("Sexe · Nationalité", "Femme · Congolaise"), ("État civil", "Célibataire"), ("Naissance", "Goma, 24/10/2006")]
    for index, (label, value) in enumerate(rows):
        y = 321 + index * 29
        text(draw, (42, y), label, 12, MUTED, True, "lm")
        text(draw, (154, y), value, 13, INK, True, "lm")
    text(draw, (24, 484), "PROFIL PROFESSIONNEL", 11, COPPER, True)
    text(draw, (24, 518), "Étudiante en troisième année de Licence", 14, INK, True)
    text(draw, (24, 542), "en Génie Logiciel à ISIG Goma.", 14, INK, True)
    text(draw, (24, 604), "COMPÉTENCES LOGICIELLES", 11, COPPER, True)
    for x, width, label in [(24, 122, "JavaScript"), (154, 76, "SQL"), (238, 98, "HTML/CSS")]:
        draw.rounded_rectangle((x, 622, x + width, 656), radius=17, fill="white")
        text(draw, (x + width / 2, 639), label, 12, INK, True, "mm")
    bottom_nav(draw, 0)
    image.save(OUT / "02-accueil.png")


if __name__ == "__main__":
    OUT.mkdir(exist_ok=True)
    login_capture()
    accueil_capture()
    family_capture()
