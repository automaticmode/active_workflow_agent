# frozen_string_literal: true

require_relative "active_workflow_agent/version"
require_relative "active_workflow_agent/parsed_request"
require_relative "active_workflow_agent/response"
require_relative "active_workflow_agent/register_response"

module ActiveWorkflowAgent
  CheckResponse = Response
  ReceiveResponse = Response
end
