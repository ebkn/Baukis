class Admin::AllowedSourcesController < Admin::Base
  def index
    @allowed_sources = AllowedSource.order_by_octets.page(params[:page])
    @new_allowed_source = AllowedSource.new
  end

  def create
    @new_allowed_source = AllowedSource.new(allowed_source_params)
    @new_allowed_source.namespace = 'staff'
    if @new_allowed_source.save
      redirect_to admin_allowed_sources_path, notice: '許可IPアドレスを追加しました'
    else
      @allowed_sources = AllowedSource.order_by_octets.page(params[:page])
      flash.now.alert = '許可IPアドレスの値が正しくありません'
      render :index
    end
  end

  def delete
    flash[:notice] = '許可IPアドレスを削除しました' if delete_allowed_sources
    redirect_to admin_allowed_sources_path
  end

  private

  def allowed_source_params
    params.require(:allowed_source)
          .permit(:octet1, :octet2, :octet3, :octet4)
  end

  def delete_allowed_sources_params
    params.require(:allowed_sources)
          .permit(allowed_sources: %i[id _destroy])
  end

  def delete_allowed_sources
    Admin::AllowedSourcesDeleter.delete(delete_allowed_sources_params)
  end
end
