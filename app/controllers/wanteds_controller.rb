class WantedsController < ApplicationController
  def create
    @wanted = Wanted.create(wanted_params.merge(default_flg: false))
    redirect_to user_wanted_path(current_user, @default_wanted)
  end

  def destroy
    @selected_wanted = Wanted.find(params[:id])
    @selected_wanted.destroy
    redirect_to user_wanted_path(current_user, @default_wanted)
  end

  def update
    @selected_wanted = Wanted.find(params[:id])
    @selected_wanted.update(wanted_params)
    redirect_to user_wanted_path(current_user, @default_wanted)
  end

  def show
    # create用のフォームがあるのでここでnewする。
    @new_wanted = Wanted.new(name:"ほしい物リスト")

    @wanteds = User.find(params[:user_id]).wanteds
    @selected_wanted = Wanted.find(params[:id])

    @selected_wanted_products = @selected_wanted.wanted_products
    @selected_id = @selected_wanted.id
    @user_id = params[:user_id]

    if @selected_wanted.wanted_products.present?
      @update_datetimes = Hash[@selected_wanted.wanted_products.map{|wp| [wp.product_id, wp.updated_at.strftime("%m月 %d %Y")]}]
    end
  end

  private

  def wanted_params
    params.require(:wanted).permit(:name, :open_flg).merge(user_id: current_user.id)
  end

end
