class ContactsController < ApplicationController
before_action :authenticate_user!
skip_before_action :authenticate_user!, only: [:new, :create]

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])
    @contact.request = request
    if @contact.deliver
      flash.now[:notice] = 'Merci pour votre message! Nous vous recontacterons bientôt'
      redirect_to root_path
    else
      flash.now[:error] = 'Echec envoi.'
      render :new
    end
  end
end
