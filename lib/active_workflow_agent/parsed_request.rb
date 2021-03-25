# frozen_string_literal: true

module ActiveWorkflowAgent
  #  Helper class to parse the content of a request from the Agent API.
  class ParsedRequest
    attr_reader :method, :options, :memory, :credentials, :message

    def initialize(request)
      @method = request["method"].to_sym
      # Set to empty for 'register' method.
      @options = {}
      @memory = {}
      @credentials = []
      @message = {}

      if %i[check receive].include? @method
        @options = request["params"]["options"]
        @memory = request["params"]["memory"]
        @credentials = request["params"]["credentials"]
      end
      @message = request["params"]["message"]["payload"] if @method == :receive
    end
  end
end
