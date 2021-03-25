# frozen_string_literal: true

require "json"

module ActiveWorkflowAgent
  # Helper class to construct responses to ActiveWorkflow's agent API.
  # https://docs.activeworkflow.org/remote-agent-api#responses
  class Response
    # Create an object for responding to 'receive' or 'check' methods.
    def initialize
      @logs = []
      @errors = []
      @messages = []
      @memory = {}
    end

    # Add log messages to the response object.
    def add_logs(*logs)
      # Validation.
      must_str = "must be (non-empty) strings"
      not_empty = "can not be empty strings"
      logs.each do |log|
        raise(ArgumentError, "Logs #{must_str}.") unless log.is_a?(String)
        raise(ArgumentError, "Logs #{not_empty}.") if log == ""
      end

      logs.each { |log| @logs << log }
    end

    def add_errors(*errors)
      # Validation.
      must_str = "must be (non-empty) strings"
      not_empty = "can not be empty strings"
      errors.each do |err|
        raise(ArgumentError, "Errors #{must_str}.") unless err.is_a?(String)
        raise(ArgumentError, "Errors #{not_empty}.") if err == ""
      end

      errors.each { |err| @errors << err }
    end

    def add_messages(*messages)
      # Validation.
      must_hash = "must be (non-empty) hashes"
      not_empty = "can not be empty hashes"
      messages.each do |msg|
        raise(ArgumentError, "Messages #{must_hash}.") unless msg.is_a?(Hash)
        raise(ArgumentError, "Messages #{not_empty}.") if msg == {}
      end

      messages.each { |msg| @messages << msg }
    end

    def add_memory(memory)
      must_hash = "must be a hash"
      raise(ArgumentError, "Memory #{must_hash}.") unless memory.is_a?(Hash)

      @memory = memory
    end

    def to_h
      {
        "result" => {
          "logs" => @logs,
          "errors" => @errors,
          "messages" => @messages,
          "memory" => @memory
        }
      }
    end

    def to_json(*)
      JSON.dump(to_h)
    end
  end
end
