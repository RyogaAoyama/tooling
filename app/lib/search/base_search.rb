class Search::BaseSearch
  def search
    raise NotImplementedError.new("#{self.class}##{__method__}が実装されていません")
  end
end