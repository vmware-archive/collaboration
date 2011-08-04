class ResourceAssignmentsController < ApplicationController
  # GET /resource_assignments
  # GET /resource_assignments.xml
  def index
    @resource_assignments = ResourceAssignment.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @resource_assignments }
    end
  end

  # GET /resource_assignments/1
  # GET /resource_assignments/1.xml
  def show
    @resource_assignment = ResourceAssignment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @resource_assignment }
    end
  end

  # GET /resource_assignments/new
  # GET /resource_assignments/new.xml
  def new
    @resource_assignment = ResourceAssignment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @resource_assignment }
    end
  end

  # GET /resource_assignments/1/edit
  def edit
    @resource_assignment = ResourceAssignment.find(params[:id])
  end

  # POST /resource_assignments
  # POST /resource_assignments.xml
  def create
    @resource_assignment = ResourceAssignment.new(params[:resource_assignment])

    respond_to do |format|
      if @resource_assignment.save
        format.html { redirect_to(@resource_assignment, :notice => 'Resource assignment was successfully created.') }
        format.xml  { render :xml => @resource_assignment, :status => :created, :location => @resource_assignment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @resource_assignment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /resource_assignments/1
  # PUT /resource_assignments/1.xml
  def update
    @resource_assignment = ResourceAssignment.find(params[:id])

    respond_to do |format|
      if @resource_assignment.update_attributes(params[:resource_assignment])
        format.html { redirect_to(@resource_assignment, :notice => 'Resource assignment was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @resource_assignment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /resource_assignments/1
  # DELETE /resource_assignments/1.xml
  def destroy
    @resource_assignment = ResourceAssignment.find(params[:id])
    @resource_assignment.destroy

    respond_to do |format|
      format.html { redirect_to(resource_assignments_url) }
      format.xml  { head :ok }
    end
  end
end
