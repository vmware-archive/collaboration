class GroupsController < ApplicationController

  # GET /groups
  # GET /groups.xml
  def index
    @org = Org.find params[:org_id]
    @groups = @org.groups

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @groups }
    end
  end

  # GET /groups/1
  # GET /groups/1.xml
  def show
    @org = Org.find params[:org_id]
    @group = @org.groups.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @group }
    end
  end

  # GET /groups/new
  # GET /groups/new.xml
  def new
    @org = Org.find params[:org_id]
    @group = @org.groups.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @group }
    end
  end

  # GET /groups/1/edit
  def edit
    @org = Org.find params[:org_id]
    @group = @org.groups.find(params[:id])
  end

  # POST /groups
  # POST /groups.xml
  def create
    @org = Org.find params[:org_id]
    @group = @org.groups.build(params[:group])

    respond_to do |format|
      if @group.save
        flash[:notice] = 'Group was successfully created.'
        format.html { redirect_to org_group_path(@org, @group) }
        format.xml  { render :xml => @group, :status => :created, :location => @group }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /groups/1
  # PUT /groups/1.xml
  def update
    @org = Org.find params[:org_id]
    @group = @org.groups.find(params[:id])

    respond_to do |format|
      if @group.update_attributes(params[:group])
        flash[:notice] = 'Group was successfully updated.'
        format.html { redirect_to org_group_path(@org, @group) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.xml
  def destroy
    @org = Org.find params[:org_id]
    @group = @org.groups.find(params[:id])
    @group.destroy

    respond_to do |format|
      flash[:notice] = 'Group was successfully deleted.'
      format.html { redirect_to(org_groups_url(@org)) }
      format.xml  { head :ok }
    end
  end
end
