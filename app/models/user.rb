class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :passkey_authenticatable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :passkeys, dependent: :destroy
  has_many :authored_post_its, class_name: "PostIt", foreign_key: "author_id", dependent: :destroy

  def self.passkeys_class
    Passkey
  end

  def self.find_for_passkey(passkey)
    self.find_by(id: passkey.user.id)
  end

  def after_passkey_authentication(passkey:)
    # Optional: Perform any additional actions after successful passkey authentication
  end

  def password_required?
    return false if webauthn_id.present?
    super
  end
end

Devise.add_module :passkey_authenticatable,
                  model: "devise/passkeys/model",
                  route: { session: [ nil, :new, :create, :destroy ] },
                  controller: "controller/sessions",
                  strategy: true
