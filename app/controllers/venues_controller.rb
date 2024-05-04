class VenuesController < ApplicationController

  def index
    matching_venues = Venue.all
    @venues = matching_venues.order(:created_at)

    render({ :template => "venue_templates/venue_list" })
  end

  def show
    venue_id = params.fetch("an_id")
    matching_venues = Venue.where({ :id => venue_id })
    @the_venue = matching_venues.at(0)
    @comments = Comment.where({ :venue_id => @the_venue.id })
  
    render({ :template => "venue_templates/details" })
  end

  def create
    venue = Venue.new
    venue.address = params.fetch("query_address")
    venue.name = params.fetch("query_name")
    venue.neighborhood = params.fetch("query_neighborhood")
    venue.save

    redirect_to("/venues/#{venue.id}")
  end
  
  def update
    the_id = params.fetch("venue_id")

    matching_venues = Venue.where({ :id => the_id })
    the_venue = matching_venues.at(0)
    if the_venue.nil?
      # Handle the case where the venue was not found
      redirect_to("/venues", { :alert => "User not found." })
    else
    the_venue.address = params.fetch("query_address")
    the_venue.name = params.fetch("query_name")
    the_venue.neighborhood = params.fetch("query_neighborhood")
    the_venue.save
    
    redirect_to("/venues/#{the_venue.id}")
    end
  end

  def destroy
    the_id = params.fetch("venue_id")
    matching_venues = Venue.where({ :id => the_id })
    the_venue = matching_venues.at(0)
  
    if the_venue
      the_venue.destroy
    end
  
    redirect_to("/venues")
  end

end
