class Admin::AllowedSourcesController < Admin::Base
  def index
    @allowed_sources = AllowedSource.order_by_octets
                                    .page(params[:page])
    @new_allowed_source = AllowedSource.new
  end
end
