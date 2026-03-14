# lex-cognitive-gravity

Cognitive attractor dynamics engine for brain-modeled agentic AI in the LegionIO ecosystem.

## What It Does

Models gravitational attraction in thought space. Attractors are dominant cognitive concepts (fears, desires, beliefs, habits, goals) with mass that exerts pull on orbiting thoughts. Each simulation tick evaluates which thoughts fall within an attractor's capture radius (pulled in) and which escape. Attractors gain mass through accretion (reinforcement) and lose mass through erosion (decay). Collapsed attractors (mass below 0.1) can no longer capture thoughts. Supermassive attractors (mass >= 3.0) have extended capture radius.

## Usage

```ruby
require 'legion/extensions/cognitive_gravity'

client = Legion::Extensions::CognitiveGravity::Client.new

# Create a dominant attractor concept
result = client.create_attractor(domain: :goal, content: 'build reliable distributed system', mass: 2.0)
attractor_id = result[:attractor_id]

# Add orbiting thoughts
client.add_thought(content: 'consider retry backoff strategy', domain: :goal, orbital_distance: 0.15)
client.add_thought(content: 'unrelated distraction', domain: :habit, orbital_distance: 0.8)

# Simulate gravitational tick
client.tick_gravity
# => { success: true, captures: 1, escapes: 0 }

# Strengthen an attractor
client.accrete(attractor_id: attractor_id)
# => { success: true, mass: 2.15, label: :heavy }

# See strongest attractors
client.strongest_attractors(limit: 5)
# => { success: true, attractors: [...] }
```

## Development

```bash
bundle install
bundle exec rspec
bundle exec rubocop
```

## License

MIT
