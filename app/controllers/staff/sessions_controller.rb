class Staff::SessionsController < ApplicationController
  def new
    if current_staff_member
      redirect_to :staff_root
    else
      @form = Staff::LoginForm.new
      render :new
    end
  end
end
