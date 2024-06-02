require 'rails_helper'

RSpec.describe "Api::Users", type: :request do
    describe "GET show" do
        context "user exists" do
            it "is successful" do
            end
        end

        context "ise does not exist" do
            it "is not found" do
            end
        end

    end
end