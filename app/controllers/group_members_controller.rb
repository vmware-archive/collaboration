class GroupMembersController < ApplicationController
  # GET /group_members
  # GET /group_members.xml
  def index
    @group = Group.find params[:id]
    @group_members = @group.group_members

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @group_members }
    end
  end

  # GET /group_members/new
  # GET /group_members/new.xml
  def new
    @group = Group.find params[:id]
    @group_member = @group.group_members.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @group_member }
    end
  end


  # POST /group_members
  # POST /group_members.xml
  def create
    @group = Group.find params[:group_id]
    @group_member = @group.group_members.build(params[:group_member])

    respond_to do |format|
      if @group_member.save
        format.html { redirect_to(@group_member, :notice => 'Group member was successfully created.') }
        format.xml  { render :xml => @group_member, :status => :created, :location => @group_member }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @group_member.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /group_members/1
  # DELETE /group_members/1.xml
  def destroy
    @group = Group.find params[:group_id]
    @group_member = @group.group_members.find(params[:id])
    @group_member.destroy

    respond_to do |format|
      format.html { redirect_to(group_members_url) }
      format.xml  { head :ok }
    end
  end
end
