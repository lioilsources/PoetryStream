#!/usr/bin/env python3
"""Check every Play text in play_console_metadata.md against Play's limits.

    python3 store/play/tools/check_lengths.py

A text is a fenced block preceded by a marker line

    <!-- check: <name> <limit> -->

Counts are Unicode code points, which is what Play Console counts (č, ř, ž are
one character each). Exits non-zero if anything is over its limit.
"""
import pathlib
import re
import sys

MD = pathlib.Path(__file__).resolve().parents[1] / "play_console_metadata.md"
PATTERN = re.compile(r"<!-- check: (\S+) (\d+) -->\s*\n```[^\n]*\n(.*?)\n```", re.S)


def main():
    text = MD.read_text(encoding="utf-8")
    bad = 0
    found = PATTERN.findall(text)
    if not found:
        raise SystemExit("no <!-- check: --> markers found")
    for name, limit, body in found:
        n, limit = len(body), int(limit)
        flag = "OK " if n <= limit else "OVER"
        bad += n > limit
        print(f"{flag} {name:<22} {n:>5} / {limit}")
    sys.exit(1 if bad else 0)


if __name__ == "__main__":
    main()
