class IndexController < ApplicationController

  def index
    index_key = params[:index_key]
    render :text => bootstrap_index(index_key)
  end

  private

  def bootstrap_index(index_key)
    redis = RedisService.new
    index_key ||= redis.get('writermortis:current')
    redis.get(index_key) || 'Cannot find index'
  end

end
