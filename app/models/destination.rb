class Destination < ApplicationRecord
  belongs_to :user

  # TODO: output_columnを実装すること
  def output_column; end
end
