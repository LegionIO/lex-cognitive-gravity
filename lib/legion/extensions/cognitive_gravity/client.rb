# frozen_string_literal: true

require 'legion/extensions/cognitive_gravity/helpers/constants'
require 'legion/extensions/cognitive_gravity/helpers/attractor'
require 'legion/extensions/cognitive_gravity/helpers/orbiting_thought'
require 'legion/extensions/cognitive_gravity/helpers/gravity_engine'
require 'legion/extensions/cognitive_gravity/runners/gravity'

module Legion
  module Extensions
    module CognitiveGravity
      class Client
        include Runners::Gravity

        def initialize(**)
          @gravity_engine = Helpers::GravityEngine.new
        end

        private

        attr_reader :gravity_engine
      end
    end
  end
end
