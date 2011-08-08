class ResourceAssignmentsController < ApplicationController
  # GET /resource_assignments
  # GET /resource_assignments.json
  def index
    @resource_assignments = ResourceAssignment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @resource_assignments }
    end
  end

  # GET /resource_assignments/1
  # GET /resource_assignments/1.json
  def show
    @resource_assignment = ResourceAssignment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @resource_assignment }
    end
  end

  # GET /resource_assignments/new
  # GET /resource_assignments/new.json
  def new
    @resource_assignment = ResourceAssignment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @resource_assignment }
    end
  end

  # GET /resource_assignments/1/edit
  def edit
    @resource_assignment = ResourceAssignment.find(params[:id])
  end

  # POST /resource_assignments
  # POST /resource_assignments.json
  def create
    @resource_assignment = ResourceAssignment.new(params[:resource_assignment])

    respond_to do |format|
      if @resource_assignment.save
        format.html { redirect_to(@resource_assignment, :notice => 'Resource assignment was successfully created.') }
        format.json  { render :json => @resource_assignment, :status => :created, :location => @resource_assignment }
      else
        format.html { render :action => "new" }
        format.json  { render :json => @resource_assignment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /resource_assignments/1
  # PUT /resource_assignments/1.json
  def update
    @resource_assignment = ResourceAssignment.find(params[:id])

    respond_to do |format|
      if @resource_assignment.update_attributes(params[:resource_assignment])
        format.html { redirect_to(@resource_assignment, :notice => 'Resource assignment was successfully updated.') }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.json  { render :json => @resource_assignment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /resource_assignments/1
  # DELETE /resource_assignments/1.json
  def destroy
    @resource_assignment = ResourceAssignment.find(params[:id])
    @resource_assignment.destroy

    respond_to do |format|
      format.html { redirect_to(resource_assignments_url) }
      format.json  { head :ok }
    end
  end
end
