class OrderMailer < ApplicationMailer
  def after_shipping
    @name = params[:name]
    mail(to: params[:to], subject: "黒染め完了と発送のお知らせ【丸幸産業株式会社】")
  end
end
