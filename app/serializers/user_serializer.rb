# frozen_string_literal: true

class UserSerializer < ApplicationSerializer
  attributes :id, :first_name, :last_name, :email
end
