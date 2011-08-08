class GroupsController < ApplicationController
  before_filter :identify_parent

  # GET /groups
  # GET /groups.json
  def index
    @groups = @org.groups

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @groups }
    end
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @group = @org.groups.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @group }
    end
  end

  # GET /groups/new
  # GET /groups/new.json
  def new
    @group = @org.groups.build

    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @group }
    end
  end

  # GET /groups/1/edit
  def edit
    @group = @org.groups.find(params[:id])
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = @org.groups.build(params[:group])

    respond_to do |format|
      if @group.save
        flash[:notice] = 'Group was successfully created.'
        format.html { redirect_to org_group_path(@org, @group) }
        format.json  { render :json => @group, :status => :created, :location => @group }
      else
        format.html { render :action => "new" }
        format.json  { render :json => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /groups/1
  # PUT /groups/1.json
  def update
    @group = @org.groups.find(params[:id])

    respond_to do |format|
      if @group.update_attributes(params[:group])
        flash[:notice] = 'Group was successfully updated.'
        format.html { redirect_to org_group_path(@org, @group) }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.json  { render :json => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group = @org.groups.find(params[:id])
    @group.destroy

    respond_to do |format|
      flash[:notice] = 'Group was successfully deleted.'
      format.html { redirect_to(org_groups_url(@org)) }
      format.json  { head :ok }
    end
  end
end
