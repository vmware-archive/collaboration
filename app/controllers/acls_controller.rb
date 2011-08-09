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
    @potential_owned_resources = potential_owned_resources
    @potential_entities = potential_entities

    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @acl }
    end
  end

  # GET /acls/1/edit
  def edit
    @acl = @project.acls.find(params[:id])
    @potential_owned_resources = potential_owned_resources
    @potential_entities = potential_entities
  end

  def potential_owned_resources
    if @org.owned_resources
      @org.owned_resources.collect{|o| ["#{o.resource_type} - #{o.resource.display_name}", o.id]}
    end
  end

  def potential_entities
   if (params[:entity_type] == User.to_s)
     # TODO: Replace first with default
     # Or should it be m.id ?
     if  (@org.groups.first && @org.groups.first.group_members)
       x = @org.groups.first.group_members.collect {|m| [m.user.display_name, m.user.id]}
       x.uniq
     else
       []
      end
   else
     @org.groups.collect{|g| [g.display_name, g.id]} if @org.groups
   end
  end

  # POST /acls
  # POST /acls.json
  def create
    @acl = @project.acls.build(params[:acl])

    respond_to do |format|
      if @acl.save
        flash[:notice] = 'Resource assignment was successfully created.'
        format.html { redirect_to org_project_acl_url(@org, @project, @acl)}
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

    respond_to do |format|
      if @acl.update_attributes(params[:acl])
        flash[:notice] = 'Resource assignment was successfully updated.'
        format.html { redirect_to org_project_acl_url(@org, @project, @acl) }
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
