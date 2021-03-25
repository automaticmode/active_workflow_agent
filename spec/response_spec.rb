# frozen_string_literal: true

require "json"

RSpec.describe ActiveWorkflowAgent::Response do
  describe "#to_h" do
    it "#returns a valid response hash" do
      response = ActiveWorkflowAgent::Response.new

      expect(response.to_h).to have_key("result")
      expect(response.to_h["result"]).to be_a_kind_of(Hash)
    end
  end

  describe "#to_json" do
    it "returns a valid JSON string" do
      response = ActiveWorkflowAgent::Response.new

      parsed = JSON.parse(response.to_json)
      expect(parsed["result"]).to be_a_kind_of(Hash)
    end
  end

  describe "#add_logs" do
    it "adds log messages to a response" do
      log1 = "A log message"
      log2 = "Another log message"
      response = ActiveWorkflowAgent::Response.new

      response.add_logs(log1, log2)

      expect(response.to_h["result"]["logs"]).to include(log1, log2)
    end

    it "raises an error when a log is not a string" do
      response = ActiveWorkflowAgent::Response.new

      expect { response.add_logs("A log", []) }
        .to raise_error(ArgumentError)
    end

    it "raises an error when a log is an empty string" do
      response = ActiveWorkflowAgent::Response.new

      expect { response.add_logs("A log", "", "Another log") }
        .to raise_error(ArgumentError)
    end

    it "raises an error and doesn't add any logs if one is invalid" do
      response = ActiveWorkflowAgent::Response.new

      expect { response.add_logs("A log", "Another log", "") }
        .to raise_error(ArgumentError)
      expect(response.to_h["result"]["logs"]).to eq([])
    end
  end

  describe "#add_erros" do
    it "adds error messages to a response" do
      err1 = "An error message"
      err2 = "Another error message"
      response = ActiveWorkflowAgent::Response.new

      response.add_errors(err1, err2)

      expect(response.to_h["result"]["errors"]).to include(err1, err2)
    end

    it "raises an error when a error message is not a string" do
      response = ActiveWorkflowAgent::Response.new

      expect { response.add_errors("An error", {}) }
        .to raise_error(ArgumentError)
    end

    it "raises an error when an error message is an empty string" do
      response = ActiveWorkflowAgent::Response.new

      expect { response.add_errors("An error", "", "Another error") }
        .to raise_error(ArgumentError)
    end

    it "raises an error and doesn't add any error messages if one is invalid" do
      response = ActiveWorkflowAgent::Response.new

      expect { response.add_errors("An error", "Another error", "") }
        .to raise_error(ArgumentError)
      expect(response.to_h["result"]["errors"]).to eq([])
    end
  end

  describe "#add_messages" do
    it "adds messages to a response" do
      msg1 = { "Hello": "world" }
      msg2 = { "Bye": "for fow" }
      response = ActiveWorkflowAgent::Response.new

      response.add_messages(msg1, msg2)

      expect(response.to_h["result"]["messages"]).to include(msg1, msg2)
    end

    it "raises an error when a message is not a hash" do
      response = ActiveWorkflowAgent::Response.new

      expect { response.add_messages("A message") }
        .to raise_error(ArgumentError)
    end

    it "raises an error when an message is an empty hash" do
      response = ActiveWorkflowAgent::Response.new

      expect { response.add_messages({}) }.to raise_error(ArgumentError)
    end

    it "raises an error and doesn't add any messages if one is invalid" do
      response = ActiveWorkflowAgent::Response.new

      expect { response.add_messages({ "Good": "message" }, "A bad message") }
        .to raise_error(ArgumentError)
      expect(response.to_h["result"]["messages"]).to eq([])
    end
  end

  describe "#add_memory" do
    it "adds a memory hash to a response" do
      mem = { "Remember": "this" }
      response = ActiveWorkflowAgent::Response.new

      response.add_memory(mem)

      expect(response.to_h["result"]["memory"]).to eq(mem)
    end

    it "raises an error when memory is not a hash" do
      response = ActiveWorkflowAgent::Response.new

      expect { response.add_memory("A memory") }
        .to raise_error(ArgumentError)
    end
  end
end
