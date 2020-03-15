class Destination < ApplicationRecord
  include Common
  belongs_to :user

  attr_accessor :all_visit_num, :all_destination_num

  # 取得するJSONを定義
  def output_column(fields = [])
    white_list = ['all_visit_num', 'all_destination_num']
    if fields.blank?
      fields = attribute_names
      fields.concat(white_list)
      [true, fields]
    else
      [field_valid(fields), fields]
    end
  end

  ####################################################################################

  def set_all_visit_num
    self.all_visit_num = self.class.where(place_id: place_id).where(is_visit: true).size
    self
  end

  ####################################################################################

  def set_all_destination_num
    self.all_destination_num = self.class.where(place_id: place_id).size
    self
  end
end
