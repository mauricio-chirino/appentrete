# == Schema Information
#
# Table name: documentary_films
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

class DocumentaryFilmTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
