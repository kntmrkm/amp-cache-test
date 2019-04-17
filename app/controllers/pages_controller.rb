class PagesController < ApplicationController
  def root
    render plain: 'root'
  end

  def home
    expires_in 1.minute #, public: true

    if request.format.symbol == :amp
    end

    respond_to do |format|
      format.html
      format.amp do
        lookup_context.formats = [:amp, :html] # .htmlのテンプレートも検索する
        render layout: 'amp'
      end
    end
  end
end
