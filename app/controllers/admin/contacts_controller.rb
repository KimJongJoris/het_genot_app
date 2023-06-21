class Admin::ContactsController < Admin::BaseController

  def index
    @contacts = Contact.all
  end

end
