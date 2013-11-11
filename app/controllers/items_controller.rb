require 'rubygems'
require 'twilio-ruby'
include ApplicationHelper

class ItemsController < ApplicationController
  def index
    @item = Item.new
    @items = Item.all
    @fridge = Fridge.find(params[:fridge_id])
  end

  def create
    @new_item = Item.new(params[:item])
    @new_item.fridge_id = params[:fridge_id]
    current_fridge = find_fridge(params[:fridge_id])
    fridge_friends = find_only_friends_of_fridge(current_user, current_fridge)
    if @new_item.save
      text_current_user(twilio_client, current_user, current_fridge, @new_item)
      text_fridge_friends(twilio_client, fridge_friends, current_user, current_fridge, @new_item)
    else
      flash[:add_item_notice] = @new_item.errors.full_messages.join(", ")
    end
    redirect_to fridge_path(@new_item.fridge.id)
  end

  def create_grocery_list_item
    @new_item = Item.new(params[:item])
    @new_item.grocery_list_id = params[:grocery_list_id]
    @new_item.fridge_id = params[:fridge_id]
    current_fridge = find_fridge(params[:fridge_id])
    current_list = find_list(params[:grocery_list_id])
    if @new_item.save
      puts "item successfully saved!!" *80
    else
      flash[:add_item_notice] = @new_item.errors.full_messages.join(", ")
    end
    redirect_to fridge_grocery_list_path(current_fridge.id, current_list.id)
  end

  def show
    @item = Item.find(params[:id])
  end

  def destroy
    item = Item.find(params[:id]).destroy
    redirect_to fridge_path(item.fridge_id)
  end
end