class Users::ReauthenticationController < DeviseController
  include Devise::Passkeys::Controllers::ReauthenticationControllerConcern
  include RelyingParty

  def set_relying_party_in_request_env
    request.env[relying_party_key] = relying_party
  end

  # def new_challenge
  #   options = WebAuthn::Credential.options_for_create(
  #     user: {
  #       id: WebAuthn.generate_user_id,
  #       name: current_user.email,
  #       display_name: current_user.email
  #     },
  #     authenticator_selection: {
  #       user_verification: "required",
  #       authenticator_attachment: "platform"
  #     }
  #   )
  #   render json: options
  # end
end
