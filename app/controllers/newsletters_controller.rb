class NewslettersController < ApplicationController

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

private


  def params_newsletter
    params.require(:newsletter).permit(:email)
  end

end
