# This file is app/controllers/movies_controller.rb
class MoviesController < ApplicationController

	def index
		@all_ratings = Movie.all_ratings
		sort_ = params[:sort_by]
		# ratings_ = params[:ratings]
		if params.has_key?(:ratings)
			ratings_ = params[:ratings]
			@all_rating = []
			if ratings_["G"] == "1"
				@all_rating.append("G")
			end
			if ratings_["PG"] == "1"
				@all_rating.append("PG")
			end
			if ratings_["PG-13"] == "1"
				@all_rating.append("PG-13")
			end
			if ratings_["R"] == "1"
				@all_rating.append("R")
			end
			# putsdsad
			@movies = Movie.find_all_by_rating(@all_rating)
		else
			@all_rating = ["PG", "G", "R", "PG-13"]
			@movies = Movie.all
		end
		
		
		if sort_ == 'title'
		 	@movies =  Movie.find(:all, :order=>'title')
		end
		if sort_ == 'release_date'
			@movies =  Movie.find(:all, :order=>'release_date')
		end
	end

	def show
		id = params[:id] # retrieve movie ID from URI route
		@movie = Movie.find(id) # Look up movie by unique ID
		# will render app/views/movies/show.<extension> by default
	end

	def new
		# default: render 'new' template
	end

	def create
		@movie = Movie.create!(params[:movie])
		flash[:notice] = "#{@movie.title} was successfully created."
		redirect_to movies_path
	end

	def edit
		@movie = Movie.find params[:id]
	end

	def update
		@movie = Movie.find params[:id]
		@movie.update_attributes!(params[:movie])
		flash[:notice] = "#{@movie.title} was successfully updated."
		redirect_to movie_path(@movie)
	end

	def destroy
		@movie = Movie.find(params[:id])
		@movie.destroy
		flash[:notice] = "Movie '#{@movie.title}' deleted."
		redirect_to movies_path
	end

end
