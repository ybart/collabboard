class Users::RegistrationsController < Devise::RegistrationsController
  include Devise::Passkeys::Controllers::RegistrationsControllerConcern
  include RelyingParty

  skip_before_action :require_email_and_passkey_label, if: :skip_passkey?
  skip_before_action :verify_passkey_registration_challenge, if: :skip_passkey?
  skip_before_action :configure_sign_up_params, if: :skip_passkey?

  def skip_passkey?
    # Skip passkey creation if a password is provided and no passkey credentials exist
    params.dig(:user, :password).present? && params.dig(:user, :passkey_credential).blank?
  end

  def create_passkey_for_resource(resource:)
    if skip_passkey?
      yield if block_given?
      return
    end

    # Default behavior from devise-passkeys
    super
  end
end
