class User < ApplicationRecord
  has_secure_password validations: false
  has_one_attached :avatar
  belongs_to :town
  # 名前
  validates :name, presence: true, length: {
    in: 1..50, message: "は1文字以上50文字以内で入力してください"
  }

  # メールアドレス
  validates :email, presence: true, uniqueness: true, length: {
    in: 3..256, message: "は3文字以上256文字以内で入力してください"
  }
  validates :email, format: {
    with: %r{\A[^,$'"\\/=\?!:;]+\z},
    message: 'は「-_.@」以外の記号は使用できません'
  }
  validates :email, format: {
    with: /\A[\w][\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i,
    message: "の形式が違います"
  }

  # パスワード
  validates :password, presence: true, confirmation: true, length: {
    in: 8..50, message: "は8文字以上50文字以内で入力してください"
  }

  # 住んでる都道府県
  validates :town_id, presence: true


  def get_errors_hash
    errors_hash = {}
    valid_columns = [
      :name,
      :email,
      :password,
      :password_confirmation,
      :avatar,
      :town_id
    ]
    valid_columns.each do |column|
      errors_hash[column] = self.errors.full_messages_for(column).first
    end
    return errors_hash
  end

  ####################################################################################

  def default_avatar_set
    unless avatar.attached?
      File.open('public/default.png') do |f|
        avatar.attach(io: File.open(f.path), filename: 'avatar/default.png')
      end
    end
  end
end
