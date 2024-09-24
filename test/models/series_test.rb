# == Schema Information
#
# Table name: series
#
#  id         :bigint           not null, primary key
#  name       :string
#  sinopsis   :string
#  director   :string
#  imagen     :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  categoria  :integer
#
require "test_helper"

class SeriesTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
