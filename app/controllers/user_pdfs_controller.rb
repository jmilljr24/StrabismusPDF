# require_relative '.../app/string_boxes_processor'

class UserPdfsController < ApplicationController
  before_action :set_user_pdf, only: %i[show edit update destroy]

  # GET /user_pdfs or /user_pdfs.json
  def index
    @user_pdfs = UserPdf.all
  end

  # GET /user_pdfs/1 or /user_pdfs/1.json
  def show # rubocop:disable Metrics/
    file = ActiveStorage::Blob.first
    file.open do |tempfile|
      doc = HexaPDF::Document.open(tempfile.path)
      doc.pages.each_with_index do |page, index|
        puts "Processing page #{index + 1}"
        processor = if index == 0
                      StringBoxesProcessor.new(page)
                    else
                      StringBoxesProcessor.new(page, @color_key)
                    end
        page.process_contents(processor)
        str_boxes = processor.str_boxes
        processor.match(str_boxes)
        page_parts = processor.page_parts

        both_pages = @prev_page_parts & processor.current_page_parts.uniq

        processor.assign_color(page_parts, both_pages)
        processor.color(page_parts)
        @color_key = processor.color_key
        @prev_page_parts = processor.current_page_parts.uniq
      end
      @filename = Rails.root.join('tmp', 'Plans_Highlight.pdf').to_s
      doc.write(@filename, optimize: true)
      file = File.open(@filename)
      @blob = ActiveStorage::Blob.create_and_upload!(io: file, filename: 'Highlights.pdf')
    end
  end

  # GET /user_pdfs/new
  def new
    @user_pdf = UserPdf.new
  end

  # GET /user_pdfs/1/edit
  def edit; end

  # POST /user_pdfs or /user_pdfs.json
  def create
    @user_pdf = UserPdf.new(user_pdf_params)

    respond_to do |format|
      if @user_pdf.save
        format.html { redirect_to user_pdf_url(@user_pdf), notice: 'User pdf was successfully created.' }
        format.json { render :show, status: :created, location: @user_pdf }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user_pdf.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_pdfs/1 or /user_pdfs/1.json
  def update
    respond_to do |format|
      if @user_pdf.update(user_pdf_params)
        format.html { redirect_to user_pdf_url(@user_pdf), notice: 'User pdf was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_pdf }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user_pdf.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_pdfs/1 or /user_pdfs/1.json
  def destroy
    @user_pdf.destroy!

    respond_to do |format|
      format.html { redirect_to user_pdfs_url, notice: 'User pdf was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user_pdf
    @user_pdf = UserPdf.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_pdf_params
    params.require(:user_pdf).permit(:pdf)
  end

  def process_pdf_hightlights(user_pdf_params)
    return unless user_pdf_params

    begin
    rescue StandardError
    end
  end
end
