class KeywordsController < ApplicationController
  def create
    keyword = Keyword.new(keywords_params)
    keyword.user_id = current_user.id
    keyword.save

    redirect_to dashboard_path
  end

  private

  def keywords_params
    params.require(:keyword).permit(:user_id, :keyword, :follow, :favorite, :min_sentiment, :max_sentiment)
  end
end
