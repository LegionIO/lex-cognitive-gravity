# lex-cognitive-gravity

**Level 3 Leaf Documentation**
- **Parent**: `/Users/miverso2/rubymine/legion/extensions-agentic/CLAUDE.md`
- **Gem**: `lex-cognitive-gravity`

## Purpose

Models attractor dynamics in cognition. Attractors are high-mass cognitive concepts that exert gravitational pull on orbiting thoughts. Thoughts within an attractor's capture radius are pulled in; those too distant escape. Each simulation tick determines captures and escapes based on mass and orbital distance. Attractors gain mass through accretion (reinforcement) and lose mass through erosion (decay). Collapsed attractors (mass < COLLAPSE_THRESHOLD) can no longer capture thoughts. Supermassive attractors (mass >= SUPERMASSIVE_THRESHOLD) have extended capture radius.

## Gem Info

| Field | Value |
|---|---|
| Gem name | `lex-cognitive-gravity` |
| Version | `0.1.0` |
| Namespace | `Legion::Extensions::CognitiveGravity` |
| Ruby | `>= 3.4` |
| License | MIT |
| GitHub | https://github.com/LegionIO/lex-cognitive-gravity |

## File Structure

```
lib/legion/extensions/cognitive_gravity/
  cognitive_gravity.rb              # Top-level require
  version.rb                        # VERSION = '0.1.0'
  client.rb                         # Client class
  helpers/
    constants.rb                    # Attractor domains, mass/density/orbit labels, thresholds
    attractor.rb                    # Attractor value object
    orbiting_thought.rb             # OrbitingThought value object
    gravity_engine.rb               # Engine: attractors, thoughts, tick, accretion, erosion
  runners/
    gravity.rb                      # Runner module
```

## Key Constants

| Constant | Value | Meaning |
|---|---|---|
| `MAX_ATTRACTORS` | 200 | Attractor cap |
| `MAX_ORBITING` | 500 | Orbiting thought cap |
| `DEFAULT_MASS` | 1.0 | Starting attractor mass |
| `MASS_ACCRETION` | 0.15 | Mass increase per accretion call |
| `MASS_EROSION` | 0.05 | Mass decrease per erosion call |
| `CAPTURE_RADIUS` | 0.2 | Default orbital radius within which thoughts are captured |
| `COLLAPSE_THRESHOLD` | 0.1 | Mass below this = collapsed; cannot capture |
| `SUPERMASSIVE_THRESHOLD` | 3.0 | Mass above this = supermassive; extended capture radius |
| `ATTRACTOR_DOMAINS` | array | `[:fear, :desire, :belief, :habit, :memory, :identity, :goal, :trauma]` |
| `MASS_LABELS` | hash | `supermassive` (3.0+) through `collapsed` |
| `DENSITY_LABELS` | hash | `dense` (0.8+) through `sparse` |
| `ORBIT_LABELS` | hash | `captured` through `escaped` |

## Helpers

### `Attractor`

A dominant cognitive concept with gravitational mass.

- `initialize(domain:, content:, mass: DEFAULT_MASS, attractor_id: nil)`
- `accrete!(rate)` — increases mass by `MASS_ACCRETION`
- `erode!(rate)` — decreases mass by `MASS_EROSION`, floor 0.0
- `collapsed?` — mass < `COLLAPSE_THRESHOLD`
- `supermassive?` — mass >= `SUPERMASSIVE_THRESHOLD`
- `capture_radius` — extended if supermassive
- `mass_label`
- `to_h`

### `OrbitingThought`

A cognitive element in orbital relationship with an attractor.

- `initialize(content:, domain:, orbital_distance: 0.5, thought_id: nil)`
- `captured?` — orbital_distance <= attractor's capture_radius
- `escaped?` — orbital_distance > 1.0
- `to_h`

### `GravityEngine`

- `add_attractor(domain:, content:, mass: DEFAULT_MASS)` — returns `{ added:, attractor_id:, attractor: }` or capacity error
- `add_orbiting_thought(content:, domain:, orbital_distance: 0.5)` — returns `{ added:, thought_id:, thought: }` or capacity error
- `simulate_tick` — for each non-collapsed attractor, evaluates all thoughts within capture radius (captures) and marks distant thoughts (escapes); returns capture/escape counts
- `accrete_attractor(attractor_id:)` — increases mass
- `erode_attractor(attractor_id:)` — decreases mass
- `strongest_attractors(limit: 10)` — sorted by mass descending
- `cognitive_density_map` — domain -> mean mass map
- `gravity_report` — full stats

## Runners

**Module**: `Legion::Extensions::CognitiveGravity::Runners::Gravity`

| Method | Key Args | Returns |
|---|---|---|
| `create_attractor` | `domain:`, `content:`, `mass: DEFAULT_MASS` | `{ success:, attractor_id:, attractor: }` |
| `add_thought` | `content:`, `domain:`, `orbital_distance: 0.5` | `{ success:, thought_id:, thought: }` |
| `tick_gravity` | — | `{ success:, captures:, escapes: }` |
| `accrete` | `attractor_id:` | `{ success:, mass:, label: }` |
| `erode` | `attractor_id:` | `{ success:, mass:, label: }` |
| `strongest_attractors` | `limit: 10` | `{ success:, attractors: }` |
| `thought_distribution` | — | `{ success:, distribution: }` |
| `cognitive_density_map` | — | `{ success:, density_map: }` |
| `gravity_report` | — | Full report hash |

Private: `gravity_engine` — memoized `GravityEngine`. Logs via `log_debug` helper.

## Integration Points

- **`lex-memory`**: High-mass attractors correspond to high-strength memory traces. `simulate_tick` results (captured thoughts) can reinforce corresponding memory traces.
- **`lex-emotion`**: Attractor domains map to emotional categories (`:fear`, `:desire`). Strong emotional valence from `lex-emotion` can trigger accretion of matching domain attractors.
- **`lex-cognitive-inertia`**: Entrenched beliefs in `lex-cognitive-inertia` correspond to high-mass attractors in gravity. Both model resistance to change in different metaphors.

## Development Notes

- `simulate_tick` is an O(attractors × thoughts) operation. With MAX_ATTRACTORS=200 and MAX_ORBITING=500, the worst case is 100,000 comparisons per tick. Keep attractor and thought counts reasonable for performance.
- Collapsed attractors (`mass < 0.1`) are skipped during tick but remain in the store. Callers should prune collapsed attractors periodically.
- `add_orbiting_thought` assigns a random orbital distance if none is provided; callers can provide explicit distance for deterministic behavior.
- In-memory only.

---

**Maintained By**: Matthew Iverson (@Esity)
