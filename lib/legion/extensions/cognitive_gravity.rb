# frozen_string_literal: true

require 'legion/extensions/cognitive_gravity/version'
require 'legion/extensions/cognitive_gravity/helpers/constants'
require 'legion/extensions/cognitive_gravity/helpers/attractor'
require 'legion/extensions/cognitive_gravity/helpers/orbiting_thought'
require 'legion/extensions/cognitive_gravity/helpers/gravity_engine'
require 'legion/extensions/cognitive_gravity/runners/gravity'

module Legion
  module Extensions
    module CognitiveGravity
      extend Legion::Extensions::Core if Legion::Extensions.const_defined? :Core
    end
  end
end
