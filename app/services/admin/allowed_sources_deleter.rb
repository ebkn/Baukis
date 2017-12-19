class Admin::AllowedSourcesDeleter
  class << self
    def delete(params)
      return if params.blank? || params[:allowed_sources].blank?

      ids = []
      params[:allowed_sources].each_value do |hash|
        ids << hash[:id] if hash[:_destroy] == '1'
      end
      delete_allowed_sources(ids) if ids.present?
    end

    private

    def delete_allowed_sources(ids)
      AllowedSource.where(namespace: 'staff', id: ids).delete_all
    end
  end
end
