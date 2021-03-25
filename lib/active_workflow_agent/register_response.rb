# frozen_string_literal: true

require "json"

module ActiveWorkflowAgent
  # Helper class to construct a response to ActiveWorkflow's register method.
  # https://docs.activeworkflow.org/remote-agent-api#the-register-method
  class RegisterResponse
    def initialize(name:, display_name:, description:, default_options: {})
      @name = name
      @display_name = display_name
      @description = description
      @default_options = default_options

      validate_args
    end

    def to_h
      {
        "result" => {
          "name" => @name,
          "display_name" => @display_name,
          "description" => @description,
          "default_options" => @default_options
        }
      }
    end

    def to_json(*)
      JSON.dump(to_h)
    end

    private

    def validate_args
      str_msg = "must be a string"
      empty_msg = "can not be empty"
      whitespace_msg = "can not have whitespace"
      hash_msg = "must be a hash"

      # name
      raise(ArgumentError, "name #{str_msg}") unless @name.is_a?(String)
      raise(ArgumentError, "name #{empty_msg}") if @name.empty?
      raise(ArgumentError, "name #{whitespace_msg}") if @name.include?(" ")
      # display_name
      # rubocop:disable Layout/LineLength
      raise(ArgumentError, "display_name #{str_msg}") unless @display_name.is_a?(String)
      raise(ArgumentError, "display_name #{empty_msg}") if @display_name.empty?
      # default_options
      raise(ArgumentError, "default_options #{hash_msg}") unless @default_options.is_a?(Hash)
      # rubocop:enable Layout/LineLength
    end
  end
end
