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

class UserTest < ActiveSupport::TestCase
  context 'validations' do
    subject { build(:user) }

    should validate_presence_of(:username)
    should validate_presence_of(:password_digest)
    should validate_presence_of(:session_token)
    
    should validate_absence_of(:password)
  end

  context 'associations' do
    subject {build(:user)}

    should belong_to(:category).class_name('userCategory')
    it { should have_many(:goals) }
  end
end
