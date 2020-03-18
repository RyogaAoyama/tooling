require 'rails_helper'

RSpec.describe 'Common', type: :model do
  include Search::Common
  describe '#get_address(position, g_api)' do
    let(:position) { TestData::POSITION }
    let(:g_api) { OuterApi::GoogleApi.new }
    it '都道府県名が返却されること' do
      expect(get_address(position, g_api)).to eq '岡山県'
    end
  end

  describe '#flatten_hash(hash)' do
    let(:hash) do
      {
        test: {
          nest1: 'aaa',
          nest2: {
            nest3: 'bbb'
          }
        }
      }
    end
    let(:result) { flatten_hash(hash) }
    it 'hashにネストがないこと' do
      result.each do |val|
        expect(val.is_a?(Hash)).to be_falsey
      end
    end
  end

  describe '#field_format(join_data)' do
    let(:address) { '岡山県小田郡矢掛町里山田１０３６' }
    let(:address_number) { '〒714-1213' }
    let(:photos) { (1..10).to_a }
    let(:join_data) do
      {
        'formatted_address' => "日本、#{ address_number } #{ address }",
        'photos' => photos
      }
    end
    let(:result) { field_format(join_data) }
    it '郵便番号と住所が分かれている' do
      expect(result['address_number']).to eq address_number
      expect(result['address']).to eq address
    end

    it '写真が7件だけ取得されていること' do
      expect(result['photos'].size).to eq 7
    end

    context '写真が7件未満の場合' do
      let(:photos) { [] }
      it '件数分の写真を返却' do
        expect(result['photos'].size).to eq 0
      end
    end
  end

  describe '#town_refine(places, town_name)' do
    let(:places) do
      [
        { 'plus_code' => { 'compound_code' => 'XFP4+4V 日本、岡山県 新見市' } },
        { 'plus_code' => { 'compound_code' => 'XFP4+4V 日本、岡山県 岡山市' } },
        { 'plus_code' => { 'compound_code' => 'XFP4+4V 日本、広島県 広島市' } }
      ]
    end
    let(:town_name) { '岡山' }
    let(:result) { town_refine(places, town_name) }
    it '指定した都道府県の観光地のみ取得できている' do
      expect(
        result.all? { |val| val['plus_code']['compound_code'].include?(town_name) }
      ).to be_truthy
    end
  end

  describe '#load_define_api_field(join_data: join_data)' do
    let(:fields) { FieldDefine::SEARCH_RESULT_FIELDS }
    let(:join_data) do
      join_data = before_def_fmt_joindata
      join_data.delete('photos')
      return join_data
    end
    let(:result) { load_define_api_field(join_data: join_data) }

    context '値がなくてフィールドが存在しなかった場合' do
      it '定義されているフィールドが全て存在すること' do
        expect(result.size).to eq fields.size
      end
      it '値のない項目は空白埋めされていること' do
        expect(result['photos']).to eq ''
      end
    end

    context '値の取得に失敗した場合' do
      let(:result) { load_define_api_field }

      it '全フィールド空白埋めされている' do
        expect(result.values.all? { |val| val == '' }).to be_truthy
      end
      it '定義されているフィールドが全て存在すること' do
        expect(result.size).to eq fields.size
      end
    end
  end
end
