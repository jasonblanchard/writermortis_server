class IndexController < ApplicationController

  def index
    index_key = params[:index_key]
    render :text => bootstrap_index(index_key)
  end

  private

  def bootstrap_index(index_key)
    index_key ||= $redis.get('writermortis:current')
    $redis.get(index_key)
  end

end
