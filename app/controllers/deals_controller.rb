class DealsController < ApplicationController
  # GET /deals
  # GET /deals.xml
  
  before_filter :authenticate_user!, :only => [:take, :taken]
  
  def index
    @deals = Deal.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @deals }
    end
  end
  
  def showcase
    @featured = Deal.where("featured = ? and start < ? and finish > ?", true, Time.now, Time.now)[0]
    @additional = Deal.where("featured = ? and start < ? and finish > ?", false, Time.now, Time.now)
    render :action => "none" if @featured.nil? and @additional.empty?
    @featured = @additional.shift if @featured.nil?
  end
  
  def none
    
  end
  
  def take
    @deal = Deal.find(params[:id])
  end
  
  def taken
    UsersDeals.new(:user_id => current_user.id, :deal_id => params[:id], :promocode => current_user.email).save
  end

  # GET /deals/1
  # GET /deals/1.xml
  def show
    @deal = Deal.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @deal }
    end
  end

  # GET /deals/new
  # GET /deals/new.xml
  def new
    @deal = Deal.new
    @partners = Partner.all

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @deal }
    end
  end

  # GET /deals/1/edit
  def edit
    @deal = Deal.find(params[:id])
    @partners = Partner.all
  end

  # POST /deals
  # POST /deals.xml
  def create
    @deal = Deal.new(params[:deal])
    @partners = Partner.all

    respond_to do |format|
      if @deal.save
        format.html { redirect_to(@deal, :notice => 'Deal was successfully created.') }
        format.xml  { render :xml => @deal, :status => :created, :location => @deal }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @deal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /deals/1
  # PUT /deals/1.xml
  def update
    @deal = Deal.find(params[:id])
    @partners = Partner.all

    respond_to do |format|
      if @deal.update_attributes(params[:deal])
        format.html { redirect_to(@deal, :notice => 'Deal was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @deal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /deals/1
  # DELETE /deals/1.xml
  def destroy
    @deal = Deal.find(params[:id])
    @deal.destroy

    respond_to do |format|
      format.html { redirect_to(deals_url) }
      format.xml  { head :ok }
    end
  end
end
