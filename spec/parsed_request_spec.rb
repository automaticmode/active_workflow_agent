# frozen_string_literal: true

RSpec.describe ActiveWorkflowAgent::ParsedRequest do
  context "when the request has the register method" do
    # https://docs.activeworkflow.org/remote-agent-api#the-register-method
    let(:reg_req) { { "method" => "register", "params" => {} } }
    let(:parsed_request) { ActiveWorkflowAgent::ParsedRequest.new(reg_req) }

    describe "#method" do
      it "returns :register" do
        expect(parsed_request.method).to eq(:register)
      end
    end

    describe "#options" do
      it "returns a empty hash" do
        expect(parsed_request.options).to eq({})
      end
    end

    describe "#memory" do
      it "returns an empty hash" do
        expect(parsed_request.memory).to eq({})
      end
    end

    describe "#credentials" do
      it "returns an empty array" do
        expect(parsed_request.credentials).to eq([])
      end
    end

    describe "#message" do
      it "returns a empty hash" do
        expect(parsed_request.message).to eq({})
      end
    end
  end

  context "when the request has the check method" do
    # A check request.
    # https://docs.activeworkflow.org/remote-agent-api#the-check-method
    let(:check_req) do
      {
        "method" => "check",
        "params" => {
          "message" => nil,
          "options" => {
            "option": "value"
          },
          "memory" => {
            "key": "value"
          },
          "credentials" => [
            { "name": "admin_email", "value": "admin@example.org" }
          ]
        }
      }
    end
    let(:check_parsed) { ActiveWorkflowAgent::ParsedRequest.new(check_req) }

    describe "#method" do
      it "returns :check" do
        expect(check_parsed.method).to eq(:check)
      end
    end

    describe "#options" do
      it "returns a hash" do
        expect(check_parsed.options).to eq({ option: "value" })
      end
    end

    describe "#memory" do
      it "returns a hash" do
        expect(check_parsed.memory).to eq({ key: "value" })
      end
    end

    describe "#credentials" do
      it "returns an array" do
        cred_arr = [{ name: "admin_email", value: "admin@example.org" }]
        expect(check_parsed.credentials).to eq(cred_arr)
      end
    end

    describe "#message" do
      it "returns an empty hash" do
        expect(check_parsed.message).to eq({})
      end
    end
  end

  context "when the request has the receive method" do
    # A receive request.
    # https://docs.activeworkflow.org/remote-agent-api#the-receive-method
    let(:receive_req) do
      {
        "method" => "receive",
        "params" => {
          "message" => {
            "payload" => { "a": 1, "b": 2 }
          },
          "options" => {
            "option" => "value",
            "email_credential" => "admin_email"
          },
          "memory" => {
            "key" => "value"
          },
          "credentials" => [
            { "name" => "admin_email", "value" => "admin@example.org" }
          ]
        }
      }
    end
    let(:receive_parsed) { ActiveWorkflowAgent::ParsedRequest.new(receive_req) }

    describe "#method" do
      it "returns :receive" do
        expect(receive_parsed.method).to eq(:receive)
      end
    end

    describe "#options" do
      it "returns a hash" do
        expect(receive_parsed.options).to be_a(Hash)
      end
    end

    describe "#memory" do
      it "returns a hash" do
        expect(receive_parsed.memory).to be_a(Hash)
      end
    end

    describe "#credentials" do
      it "returns an array" do
        expect(receive_parsed.credentials).to be_an(Array)
      end
    end

    describe "#message" do
      it "returns a hash" do
        expect(receive_parsed.message).to eq({ a: 1, b: 2 })
      end
    end
  end
end
