class AclsController < ApplicationController
  before_filter :identify_parent

  # GET /acls
  # GET /acls.json
  def index
    @acls = @project.acls

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @acls }
    end
  end

  # GET /acls/1
  # GET /acls/1.json
  def show
    @acl = @project.acls.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @acl }
    end
  end

  # GET /acls/new
  # GET /acls/new.json
  def new
    @acl = @project.acls.build
    @acl.entity_type = params[:entity_type]

    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @acl }
    end
  end

  # GET /acls/1/edit
  def edit
    @acl = @project.acls.find(params[:id])
  end

  # POST /acls
  # POST /acls.json
  def create
    [:read_bit, :create_bit, :update_bit, :delete_bit].each do |key|
      params[:acl][key] = (params.has_key? key.to_s)
    end
    @acl = @project.acls.build(params[:acl])

    respond_to do |format|
      if @acl.save
        flash[:notice] = 'Resource assignment was successfully created.'
        format.html { redirect_to org_project_acls_url(@org, @project)}
        format.json  { render :json => @acl, :status => :created, :location => @acl }
      else
        format.html { render :action => "new" }
        format.json  { render :json => @acl.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /acls/1
  # PUT /acls/1.json
  def update
    @acl = @project.acls.find(params[:id])

    [:read_bit, :create_bit, :update_bit, :delete_bit].each do |key|
      params[:acl][key] = (params.has_key? key.to_s)
    end

    # Needed since we dont switch types
    params[:acl].delete :entity_type

    respond_to do |format|
      if @acl.update_attributes(params[:acl])
        flash[:notice] = 'Resource assignment was successfully updated.'
        format.html { redirect_to org_project_acls_url(@org, @project) }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.json  { render :json => @acl.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /acls/1
  # DELETE /acls/1.json
  def destroy
    @acl = @project.acls.find(params[:id])
    @acl.destroy

    respond_to do |format|
      format.html { redirect_to(org_project_acls_url(@org, @project)) }
      format.json  { head :ok }
    end
  end
end
