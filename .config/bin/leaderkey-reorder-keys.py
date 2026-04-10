#!/usr/bin/env python3
"""Reorder keys in leaderkey config.json to: key, type, label, value, iconPath, actions."""
import json
import sys

KEY_ORDER = ["key", "label", "type", "value", "iconPath", "actions"]
CONFIG = sys.argv[1] if len(sys.argv) > 1 else None

if not CONFIG:
    sys.exit(0)


def reorder(obj):
    if isinstance(obj, dict):
        result = {}
        for k in KEY_ORDER:
            if k in obj:
                result[k] = reorder(obj[k])
        for k, v in obj.items():
            if k not in KEY_ORDER:
                result[k] = reorder(v)
        return result
    elif isinstance(obj, list):
        return [reorder(i) for i in obj]
    return obj


with open(CONFIG, "r") as f:
    data = json.load(f)

data = reorder(data)

with open(CONFIG, "w") as f:
    json.dump(data, f, indent=2, ensure_ascii=False)
    f.write("\n")
