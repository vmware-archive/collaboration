class AclsController < ApplicationController
  before_filter :identify_parent
  before_filter :get_potential

  def get_potential
    @potential_owned_resources = potential_owned_resources
    @potential_entities = potential_entities
  end

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

  def potential_owned_resources
    if @org.owned_resources
      @org.owned_resources.collect{|o| ["#{o.resource_type} - #{o.resource.display_name}", o.id]}
    end
  end

  def potential_entities
   if ((params.has_key? :entity_type) && (params[:entity_type] == "User"))
     logger.info "In user case"
     if  (@org.groups.first && @org.groups.first.group_members)
       x = @org.groups.first.group_members.collect {|m| [m.user.display_name, m.user_id]}
       return x.uniq
      end
   else
     logger.info "In group case #{params[:entity_type]}"
     return @org.groups.collect{|g| [g.display_name, g.id]} if @org.groups
   end
    []
  end

  # POST /acls
  # POST /acls.json
  def create
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

    params[:acl].each do |key, val|
      params[:acl][key] = (val == "1") if (key =~ /_bit/)
    end

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
