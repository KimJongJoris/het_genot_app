class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.contacted_at = DateTime.current

    if @contact.save
      flash[:success] = "Contact successful"
      redirect_to contact_new_path, status: :see_other
    else
      flash[:alert] = "Something went wrong."
      render :new, status: :unprocessable_entity
    end

  end

  def contact_params
    params.require(:contact).permit(:email, :address, :phone)
  end

end
