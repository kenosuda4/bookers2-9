class MessagesController < ApplicationController

    def create
        @room = Room.create
        @entry1 = Entry.create(room_id => @room.id, :user_id => @user.id)
        @entry2 = Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(:room_id => @room.id))
        redirect_to "/rooms/#{@room.id}"
  end

  

end
