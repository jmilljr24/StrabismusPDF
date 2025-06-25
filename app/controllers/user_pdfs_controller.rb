# require_relative '.../app/string_boxes_processor'

class UserPdfsController < ApplicationController
  include UserPdfsHelper
  before_action :set_user_pdf, only: %i[create]

  # GET /user_pdfs or /user_pdfs.json
  def index
    # @user_pdfs = UserPdf.all
  end

  # GET /user_pdfs/1 or /user_pdfs/1.json
  # def show
  #   # colorizer(@user_pdf)
  #   python_color(@user_pdf)
  #
  #   UserPdf.first.destroy if UserPdf.count > 10 # increase for production
  #
  #   # respond_to do |format|
  #   #   format.turbo_stream do
  #   #     render turbo_stream: turbo_stream.replace('downloader',
  #   #                                               partial: 'user_pdfs/user_pdf',
  #   #                                               locals: { user_pdf: @user_pdf })
  #   #   end
  #   # end
  # end

  # GET /user_pdfs/new
  def new
    @user_pdf = UserPdf.new
  end

  # GET /user_pdfs/1/edit
  # def edit
  # end

  # POST /user_pdfs or /user_pdfs.json
  def create
    @user_pdf ||= UserPdf.new(user_pdf_params)

    respond_to do |format|
      if @user_pdf.save
        # UserPdf.first.destroy if UserPdf.count > 5
        ColorizeJob.perform_later(@user_pdf.id)
        format.turbo_stream
        format.html { redirect_to user_pdf_url(@user_pdf) }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_pdfs/1 or /user_pdfs/1.json
  # def update
  #   respond_to do |format|
  #     if @user_pdf.update(user_pdf_params)
  #       format.html { redirect_to user_pdf_url(@user_pdf), notice: "User pdf was successfully updated." }
  #       format.json { render :show, status: :ok, location: @user_pdf }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @user_pdf.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /user_pdfs/1 or /user_pdfs/1.json
  # def destroy
  #   @user_pdf.destroy!
  #
  #   respond_to do |format|
  #     format.html { redirect_to user_pdfs_url, notice: "User pdf was successfully destroyed." }
  #     format.json { head :no_content }
  #   end
  # end

  # def colorize_pdf
  #   @user_pdf = UserPdf.find(params[:id])
  #   # colorizer(@user_pdf)
  #   python_color(@user_pdf)
  #   # send_data @blob.download, type: 'application/pdf', disposition: 'inline', target: '_blank',
  #   #                           filename: @blob.filename.to_s
  #
  #   render turbo_stream: turbo_stream.replace("pdf_load",
  #     partial: "/user_pdfs/downloads",
  #     locals: {user_pdf: @user_pdf})
  # end

  # def recolorize
  #   @user_pdf = UserPdf.find(params[:id])
  #   # colorizer(@user_pdf)
  #   python_color(@user_pdf)
  #   send_data @blob.download, type: "application/pdf", disposition: "inline", target: "_blank",
  #     filename: @blob.filename.to_s
  # end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user_pdf
    if params[:id]
      @user_pdf = UserPdf.find(params[:id])
    else
      UserPdf.new(user_pdf_params)
    end
  end

  # Only allow a list of trusted parameters through.
  def user_pdf_params
    params.require(:user_pdf).permit(:pdf)
  end

  # def process_pdf_hightlights(user_pdf_params)
  #   return unless user_pdf_params
  #
  #   begin
  #   rescue
  #   end
  # end
end
