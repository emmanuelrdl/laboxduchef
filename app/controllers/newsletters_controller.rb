class NewslettersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]
  before_action :landing_page
  before_action :navbar_choice

 def new
    @newsletter = Newsletter.new
 end


  def create
    @newsletter = Newsletter.new(params_newsletter)
    if @newsletter.save
      flash[:notice] = 'Merci pour votre intérêt! Nous vous recontacterons bientôt'
      redirect_to new_newsletter_path
    else
      render :new
     end
  end

  def landing_page
  @disable_nav = true
  @disable_footer = true
  end

  def navbar_choice
    @navbar_home = true
  end

private


  def params_newsletter
    params.require(:newsletter).permit(:email)
  end

end
