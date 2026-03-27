"""Convert Vault JSON export to .env file format.

Usage:
    python vault_to_env.py vault.json
    python vault_to_env.py vault.json -o .env
"""

import json
import sys


def main():
    if len(sys.argv) < 2:
        print("Usage: python vault_to_env.py <vault.json> [-o .env]")
        sys.exit(1)

    with open(sys.argv[1]) as f:
        data = json.load(f)

    lines = []
    for key, value in data.items():
        if isinstance(value, dict):
            # JSON objects → single-line JSON string
            value = json.dumps(value, separators=(",", ":"))
        lines.append(f"{key}={value}")

    output = "\n".join(lines) + "\n"

    if "-o" in sys.argv:
        out_path = sys.argv[sys.argv.index("-o") + 1]
        with open(out_path, "w") as f:
            f.write(output)
        print(f"Written to {out_path}")
    else:
        print(output, end="")


if __name__ == "__main__":
    main()
