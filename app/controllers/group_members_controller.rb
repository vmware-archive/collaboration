class GroupMembersController < ApplicationController
  before_filter :identify_parent

  # GET /group_members
  # GET /group_members.json
  def index
    @group_members = @group.group_members

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @group_members }
    end
  end

  # GET /group_members/new
  # GET /group_members/new.json
  def new
    @group_member = @group.group_members.build
    @candidates = User.find(:all).collect {|u| [u.display_name, u.id]}
    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @group_member }
    end
  end


  # POST /group_members
  # POST /group_members.json
  def create
    @group_member = @group.group_members.build(params[:group_member])

    respond_to do |format|
      if @group_member.save
        flash[:notice] = 'Group member was successfully created.'
        format.html { redirect_to org_group_group_members_path(@org, @group) }
        format.json  { render :json => @group_member, :status => :created, :location => @group_member }
      else
        format.html { render :action => "new" }
        format.json  { render :json => @group_member.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /group_members/1
  # DELETE /group_members/1.json
  def destroy
    @group_member = @group.group_members.find(params[:id])
    @group_member.destroy

    respond_to do |format|
      format.html { redirect_to(org_group_group_members_url(@org, @group)) }
      format.json  { head :ok }
    end
  end
end
