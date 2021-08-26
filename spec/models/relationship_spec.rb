require "rails_helper"

RSpec.describe Relationship, type: :model do
  describe "association" do
    it "belongs_to user" do
      expect(Relationship.reflect_on_association(:user).macro).to eq :belongs_to
    end
  end
end
