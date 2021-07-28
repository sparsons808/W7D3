# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'validations' do
    subject(:user) { FactoryBot.create(:user) }

    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:session_token) }
    
    it { should validate_absence_of(:password) }
  end

  describe 'associations' do
    subject(:user) { FactoryBot.create(:user) }

    it { should belong_to(:category).class_name('userCategory') }
    it { should have_many(:goals) }
  end
end
