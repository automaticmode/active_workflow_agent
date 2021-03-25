# frozen_string_literal: true

require "json"

RSpec.describe ActiveWorkflowAgent::RegisterResponse do
  context "initialised with valid arguments" do
    before(:each) do
      @response = ActiveWorkflowAgent::RegisterResponse.new(
        name: "TestAgent",
        display_name: "Test Agent",
        description: "This is a test agent",
        default_options: { "option_key" => "option_value" }
      )
    end

    describe ".new" do
      it "creates a new RegisterResponse object" do
        expect(@response)
          .to be_an(ActiveWorkflowAgent::RegisterResponse)
      end
    end

    describe "#to_h" do
      it "#returns a valid register response hash" do
        expect(@response.to_h).to have_key("result")
        expect(@response.to_h["result"]).to be_a(Hash)
      end
    end

    describe "#to_json" do
      it "returns a valid JSON string" do
        parsed = JSON.parse(@response.to_json)
        expect(parsed["result"]).to be_a(Hash)
      end
    end
  end

  context "initialised with invalid arguments" do
    describe ".new" do
      describe "name argument" do
        it "must be a string" do
          args = {
            name: [],
            display_name: "Test Agent",
            description: "This is a test agent"
          }
          expect { ActiveWorkflowAgent::RegisterResponse.new(args) }
            .to raise_error(ArgumentError)
        end

        it "can not be an empty string" do
          args = {
            name: "",
            display_name: "Test Agent",
            description: "This is a test agent"
          }
          expect { ActiveWorkflowAgent::RegisterResponse.new(args) }
            .to raise_error(ArgumentError)
        end

        it "can not contain spaces" do
          args = {
            name: "Test Agent",
            display_name: "Test Agent",
            description: "This is a test agent"
          }
          expect { ActiveWorkflowAgent::RegisterResponse.new(args) }
            .to raise_error(ArgumentError)
        end
      end

      describe "display_name argument" do
        it "must be a string" do
          args = {
            name: "TestAgent",
            display_name: [],
            description: "This is a test agent"
          }
          expect { ActiveWorkflowAgent::RegisterResponse.new(args) }
            .to raise_error(ArgumentError)
        end

        it "can not be an empty string" do
          args = {
            name: "TestAgent",
            display_name: "",
            description: "This is a test agent"
          }
          expect { ActiveWorkflowAgent::RegisterResponse.new(args) }
            .to raise_error(ArgumentError)
        end
      end

      describe "default_options argument" do
        it "must be a hash" do
          args = {
            name: "TestAgent",
            display_name: "Test Agent",
            description: "This is a test agent",
            default_options: []
          }
          expect { ActiveWorkflowAgent::RegisterResponse.new(args) }
            .to raise_error(ArgumentError)
        end
      end
    end
  end
end
