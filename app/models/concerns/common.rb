module Common
  def field_valid(fields)
    fields.all? { |val| self.attribute_names.include?(val) }
  end
end
