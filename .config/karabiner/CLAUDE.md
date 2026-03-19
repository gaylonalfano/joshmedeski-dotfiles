# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Karabiner-Elements keyboard remapping configuration using a **Lua-based code generation** approach. Lua scripts define the configuration as structured tables, which are serialized to `karabiner.json` via a bundled JSON encoder. Karabiner-Elements auto-reloads when `karabiner.json` changes on disk.

**Important:** Lua is not an officially supported Karabiner generator -- this is a custom setup using standalone Lua. Official generators include GokuRakuJoudo (edn), karabiner.ts (TypeScript), and Jsonnet.

## Build Command

```bash
# Run from this directory (~/.config/karabiner/)
lua karabiner-elements.lua
```

This overwrites `karabiner.json` in place. Karabiner-Elements detects the change via macOS File System Events and reloads automatically. Errors appear in `~/.local/share/karabiner/log/console_user_server.log`.

## Architecture

### Code Generation Flow

```
karabiner-elements.lua (entry point)
├── lua/json.lua          # rxi/json.lua library (third-party, don't modify)
├── lua/hyper_key_rule.lua # Hyper key rule module
├── lua/rules.lua          # Additional rules (currently empty)
└── writes → karabiner.json
```

`karabiner-elements.lua` builds a Lua table matching the karabiner.json schema, requires rule modules, then calls `write_json_file()` to serialize and write.

### Lua vs JSON Drift

The Lua source is **out of sync** with the actual `karabiner.json`. The Lua defines only the hyper key and hjkl arrows, while `karabiner.json` contains additional rules (command-tab remap, akimbo cmd, volume knob modes, bluetooth device rules) that were added directly to the JSON or via the GUI. Running `lua karabiner-elements.lua` will **overwrite these extra rules**.

### assets/complex_modifications/

Contains importable rule files for the Karabiner GUI's "Add predefined rule" feature. These use a different top-level schema (`{ "title": "...", "rules": [...] }`) than `karabiner.json` profiles. Irrelevant to the Lua workflow -- rules should be defined in Lua modules instead.

## karabiner.json Schema

```
profiles[].complex_modifications.rules[].manipulators[]
```

Each manipulator has:
- `type`: always `"basic"`
- `from`: trigger key (key_code/consumer_key_code + modifiers)
- `to`: output events on press
- `to_if_alone`: output if pressed and released without other keys
- `to_after_key_up`: output after key release
- `to_delayed_action`: `{ to_if_invoked, to_if_canceled }` for timer-based actions
- `conditions`: array of conditions (`variable_if`, `frontmost_application_if`, etc.)

### Key Patterns Used

**Hyper Key** (Caps Lock as modifier): Uses `set_variable` to set `hyper=1` on press, `hyper=0` on release. Other rules check `variable_if: { name: "hyper", value: 1 }`. Tapping alone sends Escape.

**Simultaneous Keys**: `from.simultaneous` array for chords (e.g., left_command + right_command). Configure timing via `simultaneous_options`.

**State Machine** (volume knob): Uses `set_variable` to track modes (e.g., `volume_knob_mode: 0/1/2`) with `to_delayed_action` for double-tap detection and mode switching.

## Adding New Rules

1. Create a Lua module in `lua/` returning a rule table
2. Require it in `karabiner-elements.lua`
3. Add to the `rules` array in the config table
4. Run `lua karabiner-elements.lua`

Or, if maintaining rules directly in JSON, edit `karabiner.json` and let Karabiner auto-reload.

## Reference

- [karabiner.json structure](https://karabiner-elements.pqrs.org/docs/json/root-data-structure/)
- [Manipulator definition](https://karabiner-elements.pqrs.org/docs/json/complex-modifications-manipulator-definition/)
- [Conditions (variable_if, app conditions)](https://karabiner-elements.pqrs.org/docs/json/complex-modifications-manipulator-definition/conditions/)
- [to event fields (set_variable, shell_command)](https://karabiner-elements.pqrs.org/docs/json/complex-modifications-manipulator-definition/to/)
- [EventViewer](https://karabiner-elements.pqrs.org/docs/manual/operation/eventviewer/) for debugging key codes
