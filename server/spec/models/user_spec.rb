require 'rails_helper'

RSpec.describe User, :type => :model do
  it { should have_many :stories }
  it { should have_many :pieces }
end
