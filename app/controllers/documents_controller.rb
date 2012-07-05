class DocumentsController < ApplicationController
  # GET /documents
  # GET /documents.json
  def index
    @documents = Document.where(association => params[association])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @documents }
    end
  end

  # GET /documents/new
  # GET /documents/new.json
  def new
    @document = Document.new(association => params[association])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @document }
    end
  end

  # POST /documents
  # POST /documents.json
  def create
    @document = Document.new(params[:document])

    respond_to do |format|
      if @document.save
        format.html {
          redirect_to assoc_path, notice: 'Document was successfully created.'
        }
        format.json { render json: @document, status: :created, location: @document }
      else
        format.html { render action: "new" }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document = Document.find(params[:id])
    @document.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  private

    def assoc_path
      methods = { :case_id => method(:case_path), :person_id => method(:person_path) }

      methods[association].call(params[:document][association])
    end

    def association
      if params[:case_id] or params[:person_id]
        params[:case_id] ? :case_id : :person_id
      else
        params[:document][:case_id] ? :case_id : :person_id
      end
    end
end
