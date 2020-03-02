module Common
  def field_valid(fields)
    fields.all? { |val| attribute_names.include?(val) }
  end
end
