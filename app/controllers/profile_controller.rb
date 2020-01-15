class ProfileController < ApplicationController
    before_action :authenticate_user!, only: [:edit, :create, :update, :destroy, :follow, :unfollow]
    before_action :set_user, only: [:show, :uploads, :follow, :unfollow]
    before_action :prevent_self_follow, only: [:follow, :unfollow]

    def show
        @test = "sadsa"
        puts "here"
    end

    def follow
        current_user.follow!(@user)
        # redirect_back(fallback_location: root_path)
    end

    def unfollow
        current_user.unfollow!(@user)
        # redirect_back(fallback_location: root_path)
    end

    private
        def set_user
            @user = User.find(params[:id])
        end

        def prevent_self_follow
            redirect_to root_path, notice: "You can't do that." if @user == current_user
        end
end
