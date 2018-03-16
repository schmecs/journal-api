require 'rails_helper'

RSpec.describe User, type: :model do
  # ensure proper relationship to Posts
  it { should have_many(:posts).dependent(:destroy) }

  # ensure it validates username
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }

end
