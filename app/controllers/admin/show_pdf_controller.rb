class Admin::ShowPdfController < AdminController
  
  def index
    @record = Order.find(params[:order_id])
    respond_to do |format|
      format.pdf do
        show_pdf = ShowPdf.new(@record).render
        send_data show_pdf,
        filename: "注文書.pdf",
        type: 'application/pdf',
        disposition: 'inline' # 外すとアクセス時に自動ダウンロードされるようになる
      end
    end
  end
end