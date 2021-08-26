require "rails_helper"

RSpec.describe Post, type: :model do
  let(:user) { create(:user) }

  context "store names, reviews, and genres are entered" do
    let(:post) { build(:post, user_id: user.id) }
    it "can register" do
      expect(post).to be_valid
    end
  end

  context "can register without a review" do
    let(:post) { build(:post, user_id: user.id, content: "") }
    it "can register" do
      expect(post).to be_valid
    end
  end

  context "no user information" do
    let(:post) { build(:post, user_id: "") }
    it "can not register" do
      expect(post).to_not be_valid
    end
  end

  context "store name not entered" do
    let(:post) { build(:post, user_id: user.id, title: "") }
    it "can not register" do
      expect(post).to_not be_valid
    end
  end

  context "genre not entered" do
    let(:post) { build(:post, user_id: user.id, genre_id: "") }
    it "can not register" do
      expect(post).to_not be_valid
    end
  end

  context "belongs_to" do
    it "belongs_to user" do
      expect(Post.reflect_on_association(:user).macro).to eq :belongs_to
    end
  end

  context "belongs_to" do
    it "belongs_to genre" do
      expect(Post.reflect_on_association(:genre).macro).to eq :belongs_to
    end
  end

  context "has_many" do
    it "has_many likes" do
      expect(Post.reflect_on_association(:likes).macro).to eq :has_many
    end
  end

  context "has_many" do
    it "has_many images" do
      expect(Post.reflect_on_association(:images).macro).to eq :has_many
    end
  end
end
