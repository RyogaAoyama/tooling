class Search::BaseSearch
  def search
    raise NotImplementedError, "#{ self.class }##{ __method__ }が実装されていません"
  end
end
