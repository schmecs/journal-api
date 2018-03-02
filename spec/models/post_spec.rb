require 'rails_helper'

RSpec.describe Post, type: :model do

  # ensure it belongs to a single user
  it { should belong_to(:user) }

  # ensure it validates content
  it { should validate_presence_of(:content) }

end
