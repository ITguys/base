class Manage::Data::ApplicationController < Manage::ApplicationController
  respond_to :html, :js, :json, :xml #, :xls, :csv, :tsv
end
