class User < ApplicationRecord
  has_secure_password validations: false
  has_one_attached :avatar
  attr_accessor :image
  belongs_to :town
  # 名前
  validates :name, presence: true, allow_nil: true, length: {
    in: 1..50, message: 'は1文字以上50文字以内で入力してください'
  }

  # メールアドレス
  validates :email, presence: true, allow_nil: true, uniqueness: true, length: {
    in: 3..256, message: 'は3文字以上256文字以内で入力してください'
  }
  validates :email, format: {
    with: %r{\A[^,$'"\\/=\?!:;]+\z},
    message: 'は「-_.@」以外の記号は使用できません'
  }
  validates :email, format: {
    with: /\A[\w][\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i,
    message: 'の形式が違います'
  }

  # パスワード
  validates :password, presence: true, allow_nil: true, confirmation: true, length: {
    in: 8..50, message: 'は8文字以上50文字以内で入力してください'
  }, on: :update

  validates :password, presence: true, confirmation: true, length: {
    in: 8..50, message: 'は8文字以上50文字以内で入力してください'
  }, on: :create

  # 住んでる都道府県
  validates :town_id, allow_nil: true, presence: true

  def get_errors_hash
    errors_hash = {}
    valid_columns = %i[
      name
      email
      password
      password_confirmation
      avatar
      town_id
    ]
    valid_columns.each do |column|
      errors_hash[column] = errors.full_messages_for(column).first
    end
    errors_hash
  end

  ####################################################################################

  def default_avatar_set
    return if avatar.attached?

    File.open('public/default.png') do |f|
      avatar.attach(io: File.open(f.path), filename: 'avatar/default.png')
    end
  end

  ####################################################################################

  # JSONで返却するカラムリストを返却
  def output_column
    black_list = %w[
      password_digest
      id
    ]

    columns = attribute_names

    black_list.each { |val| columns.delete(val) }
    columns
  end
end
