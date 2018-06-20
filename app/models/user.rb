class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

         has_many :reviews

         validates :email, {presence:true}
         validates :user_name, {presence:true}
         validates :user_phonetic, {presence:true}
         validates :postal, {presence:true,numericality: { only_integer: true }}
         validates :address, {presence:true}
         validates :tell, {presence:true, numericality: { only_integer: true }}




         def active_for_authentication?
             super && !delete_flag?
         end
  has_one :cart
  has_one :unsubscribe_comment
end
