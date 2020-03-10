class Destination < ApplicationRecord
  include Common
  belongs_to :user

  def output_column(fields = [])
    if fields.blank?
      [true, attribute_names]
    else
      [field_valid(fields), fields]
    end
  end
end
