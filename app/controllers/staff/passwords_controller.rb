class Staff::PasswordsController < ApplicationController
  def show
    redirect_to edit_staff_password_path
  end
end
