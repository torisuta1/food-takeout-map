require "rails_helper"

RSpec.describe Genre, type: :model do
  describe "association" do
    it "belongs_to posts" do
      expect(Like.reflect_on_association(:post).macro).to eq :belongs_to
    end

    it "belongs_to user" do
      expect(Like.reflect_on_association(:user).macro).to eq :belongs_to
    end
  end
end
