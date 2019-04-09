class PagesController < ApplicationController
  def home
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
