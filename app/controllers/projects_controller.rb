class ProjectsController < ApplicationController
  before_filter :identify_parent

  # GET /projects
  # GET /projects.json
  def index
    @projects = @org.projects

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = @org.projects.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    @project = @org.projects.build

    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = @org.projects.find(params[:id])
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = @org.projects.build(params[:project])

    respond_to do |format|
      if @project.save
        flash[:notice] = 'Project was successfully created.'
        format.html { redirect_to org_project_path(@org, @project) }
        format.json  { render :json => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.json  { render :json => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    @project = @org.projects.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        flash[:notice] = 'Project was successfully updated.'
        format.html { redirect_to org_project_path(@org, @project) }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.json  { render :json => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project = @org.projects.find(params[:id])
    @project.destroy

    respond_to do |format|
      flash[:notice] = 'Project was successfully deleted.'
      format.html { redirect_to org_projects_url(@org) }
      format.json  { head :ok }
    end
  end
end
