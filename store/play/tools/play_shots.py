#!/usr/bin/env python3
"""Frame raw device captures into Google Play phone and tablet screenshot sets.

    python3 store/play/tools/play_shots.py [--src DIR] [--no-captions]

Input:  ../ol1n.now/apps/poetrystream/screenshots/raw/mobile/ios/*.png
Output: store/play/screenshots/phone/NN_<slug>.png   1080x1920
        store/play/screenshots/tablet/NN_<slug>.png  1920x1200

Why framed and not cropped: Play caps screenshots at a 2:1 aspect and the raw
captures are 1125x2436 (2.165:1). Cover-cropping to 9:16 would cut a third of
the poem off, so each capture is scaled to fit and centred on the app's own
warm-charcoal background with a short Czech caption above it.

The top 132 px of every capture (the iOS status bar, and the "TestFlight"
back-link on one of them) is trimmed first: Play reviewers and users should
not see another platform's chrome in an Android listing.
"""
import pathlib
import sys

from PIL import Image, ImageDraw, ImageFilter, ImageFont

ROOT = pathlib.Path(__file__).resolve().parents[3]
DEFAULT_SRC = ROOT.parent / "ol1n.now/apps/poetrystream/screenshots/raw/mobile/ios"
OUT_DIR = ROOT / "store" / "play" / "screenshots"

STATUS_BAR = 132  # px of iOS status bar at 1125x2436 (@3x, 44 pt)

TARGETS = {
    "phone": (1080, 1920),
    "tablet": (1920, 1200),
}

# (raw file stem, output slug, caption) in listing order.
SCENES = [
    ("Stream", "stream", "Verše plynou jako stream"),
    ("Báseň", "basen", "Báseň po strofách"),
    ("Zoneta", "cteni", "Čtení celé básně"),
    ("Sbírky", "sbirky", "Čtyři sbírky, 48 básní"),
    ("In-app", "nakup", "Další sbírky jednorázovým nákupem"),
    ("Kožní ambulance", "kozni_ambulance", "Nová sbírka Kožní ambulance"),
]

SERIF = "/System/Library/Fonts/Supplemental/Georgia.ttf"
BG = (10, 8, 6)
CAPTION = (232, 213, 183)


def flatten(im):
    if im.mode != "RGBA":
        return im.convert("RGB")
    bg = Image.new("RGB", im.size, BG)
    bg.paste(im, (0, 0), im)
    return bg


def frame(im, size, caption):
    tw, th = size
    margin = round(th * 0.05)
    cap_h = round(th * 0.10) if caption else 0
    avail_h = th - 2 * margin - cap_h
    avail_w = tw - 2 * margin
    scale = min(avail_h / im.height, avail_w / im.width)
    shot = im.resize((round(im.width * scale), round(im.height * scale)), Image.LANCZOS)

    radius = round(shot.width * 0.05)
    mask = Image.new("L", shot.size, 0)
    ImageDraw.Draw(mask).rounded_rectangle(
        [0, 0, shot.width - 1, shot.height - 1], radius=radius, fill=255)

    canvas = Image.new("RGB", size, BG)
    # soft amber glow behind the device, echoing the app's radial gradients
    glow = Image.new("RGBA", size, (0, 0, 0, 0))
    r = round(max(tw, th) * 0.35)
    cx, cy = tw // 2, th // 2 + cap_h // 2
    ImageDraw.Draw(glow).ellipse([cx - r, cy - r, cx + r, cy + r], fill=(120, 70, 30, 70))
    glow = glow.filter(ImageFilter.GaussianBlur(r * 0.5))
    canvas.paste(glow, (0, 0), glow)

    pos = ((tw - shot.width) // 2, margin + cap_h + (avail_h - shot.height) // 2)
    border = Image.new("L", (shot.width + 4, shot.height + 4), 0)
    ImageDraw.Draw(border).rounded_rectangle(
        [0, 0, border.width - 1, border.height - 1], radius=radius + 2, fill=255)
    canvas.paste((60, 52, 42), (pos[0] - 2, pos[1] - 2), border)
    canvas.paste(shot, pos, mask)

    if caption:
        draw = ImageDraw.Draw(canvas)
        size_px = round(th * 0.036)
        font = ImageFont.truetype(SERIF, size_px)
        while draw.textlength(caption, font=font) > tw - 2 * margin:
            size_px -= 2
            font = ImageFont.truetype(SERIF, size_px)
        w = draw.textlength(caption, font=font)
        draw.text(((tw - w) / 2, margin + (cap_h - size_px) / 2 - size_px * 0.15),
                  caption, font=font, fill=CAPTION)
    return canvas


def main():
    argv = sys.argv[1:]
    src = pathlib.Path(argv[argv.index("--src") + 1]) if "--src" in argv else DEFAULT_SRC
    captions = "--no-captions" not in argv

    for name, size in TARGETS.items():
        out = OUT_DIR / name
        out.mkdir(parents=True, exist_ok=True)
        for old in out.glob("*.png"):  # numbering may shift; no stale uploads
            old.unlink()
        for i, (stem, slug, caption) in enumerate(SCENES, start=1):
            path = src / f"{stem}.png"
            if not path.exists():
                raise SystemExit(f"missing capture: {path}")
            im = flatten(Image.open(path))
            im = im.crop((0, STATUS_BAR, im.width, im.height))
            dest = out / f"{i:02d}_{slug}.png"
            frame(im, size, caption if captions else None).save(dest, "PNG")
            print(f"{name:<7} {size[0]}x{size[1]}  {dest.name}")


if __name__ == "__main__":
    main()
